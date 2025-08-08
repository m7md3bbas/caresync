import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/service/offline_service.dart';
import 'package:flutter/material.dart';

class OfflineIndicator extends StatefulWidget {
  final Widget child;
  final String token;

  const OfflineIndicator({
    super.key,
    required this.child,
    required this.token,
  });

  @override
  State<OfflineIndicator> createState() => _OfflineIndicatorState();
}

class _OfflineIndicatorState extends State<OfflineIndicator> {
  final OfflineService _offlineService = OfflineService();
  bool _isOffline = false;
  bool _hasOfflineActions = false;

  @override
  void initState() {
    super.initState();
    _checkOfflineStatus();
    _listenToConnectivity();
  }

  void _listenToConnectivity() {
    _offlineService.connectivityStream.listen((result) {
      _checkOfflineStatus();
    });
  }

  Future<void> _checkOfflineStatus() async {
    final isOnline = await _offlineService.isOnline();
    final shouldShowIndicator = await _offlineService.shouldShowOfflineIndicator();
    
    if (mounted) {
      setState(() {
        _isOffline = !isOnline;
        _hasOfflineActions = shouldShowIndicator;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isOffline || _hasOfflineActions)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: _hasOfflineActions ? Colors.orange : Colors.red,
              child: Row(
                children: [
                  Icon(
                    _hasOfflineActions ? Icons.sync : Icons.wifi_off,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                                         child: Text(
                       _hasOfflineActions 
                         ? '${S.of(context).offlineIndicator} - ${_offlineService.getOfflineActions().length} ${S.of(context).offlineActionsPending}'
                         : S.of(context).noInternetConnection,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (_hasOfflineActions)
                    TextButton(
                      onPressed: () async {
                        await _offlineService.syncOfflineActions(widget.token);
                        _checkOfflineStatus();
                        if (mounted) {
                                                     ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                               content: Text(S.of(context).offlineActionsSynced),
                               backgroundColor: Colors.green,
                             ),
                           );
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                                             child: Text(
                         S.of(context).sync,
                         style: const TextStyle(fontSize: 12),
                       ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
