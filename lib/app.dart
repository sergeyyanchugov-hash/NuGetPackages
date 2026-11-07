import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nuget_packages/common/navigation/app_router.dart';
import 'package:nuget_packages/common/theme/app_theme.dart';
import 'package:nuget_packages/l10n/app_localizations.dart';

import 'features/package/domain/i_package_repository.dart';
import 'features/package/data/package_repository.dart';
import 'features/package/presentation/bloc/theme/theme_cubit.dart';
import 'features/package/presentation/bloc/locale/locale_cubit.dart';
import 'features/package/presentation/bloc/list/package_list_cubit.dart';

class NuGetPackagesApp extends StatelessWidget {
  const NuGetPackagesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IPackageRepository>(
      create: (_) => PackageRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider<LocaleCubit>(
            create: (context) => LocaleCubit(),
          ),
          BlocProvider<PackageListCubit>(
            create: (context) => PackageListCubit(
              context.read<IPackageRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return BlocBuilder<LocaleCubit, Locale>(
              builder: (context, locale) {
                return MaterialApp.router(
                  title: '.NET Packages',
                  themeMode: themeMode,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  locale: locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''),
                    Locale('ru', ''),
                  ],
                  routerConfig: appRouter,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
