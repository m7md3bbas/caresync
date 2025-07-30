import 'package:caresync/config/locale/generated/l10n.dart';
import 'package:caresync/config/locale/locale_cubit.dart';
import 'package:caresync/config/locale/locale_state.dart';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/doctor/doctor_cubit.dart';
import 'package:caresync/controller/profile/profile_cubit.dart';
import 'package:caresync/core/routes/app_routes.dart';
import 'package:caresync/core/service/auth_service.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:caresync/core/service/profile_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/core/theme/theme.dart';
import 'package:caresync/core/theme/theme_cubit.dart';
import 'package:caresync/core/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CureSync extends StatelessWidget {
  const CureSync({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(
          create: (context) => AuthCubit(authService: AuthService()),
        ),
        BlocProvider(create: (context) => DoctorCubit(DoctorService())),
        BlocProvider(
          create: (context) => ProfileCubit(
            ProfileService()..getProfile(
              SharedPrefHelper.getString(SharedPrefKeys.token) ?? '',
            ),
          ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              return MaterialApp.router(
                title: 'CureSync',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeState.themeMode,
                routerConfig: AppRouter.router,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: localeState.locale,
              );
            },
          );
        },
      ),
    );
  }
}
