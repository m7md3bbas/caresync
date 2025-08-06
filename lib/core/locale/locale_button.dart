import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/locale/locale_cubit.dart';
import 'package:caresync/core/locale/locale_state.dart';
import 'package:caresync/core/constants/languages_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleButton extends StatelessWidget {
  const LocaleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return BlocBuilder<LocaleCubit, LocaleState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).languageTitle,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall!.copyWith(fontSize: 30),
                          ),
                        ),
                        Divider(color: Theme.of(context).colorScheme.primary),
                        ListTile(
                          title: Text(
                            S.of(context).english,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall!.copyWith(fontSize: 20),
                          ),
                          onTap: () {
                            context.read<LocaleCubit>().changeLocale(
                              LanguagesLocale.getEnglishLan(),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text(
                            S.of(context).arabic,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall!.copyWith(fontSize: 20),
                          ),
                          onTap: () {
                            context.read<LocaleCubit>().changeLocale(
                              LanguagesLocale.getArabicLan(),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        child: Text(
          S.of(context).languageTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
