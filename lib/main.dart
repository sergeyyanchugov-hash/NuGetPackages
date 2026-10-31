import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nuget_packages/l10n/app_localizations.dart';
import 'features/package/data/package_repository.dart';
import 'features/package/presentation/bloc/theme_cubit.dart';
import 'features/package/presentation/bloc/package_list_cubit.dart';
import 'features/package/presentation/bloc/package_detail_cubit.dart';
import 'features/package/presentation/pages/package_list_page.dart';
import 'features/package/presentation/pages/package_detail_page.dart';

void main() {
  runApp(const NuGetPackagesApp());
}

class NuGetPackagesApp extends StatefulWidget {
  const NuGetPackagesApp({Key? key}) : super(key: key);

  @override
  State<NuGetPackagesApp> createState() => _NuGetPackagesAppState();
}

class _NuGetPackagesAppState extends State<NuGetPackagesApp> {
  late final MockPackageRepository _repository;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _repository = MockPackageRepository();
    
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const PackageListPage(),
        ),
        GoRoute(
          path: '/package/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return PackageDetailPage(packageId: id);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<PackageListCubit>(
          create: (context) => PackageListCubit(_repository),
        ),
        BlocProvider<PackageDetailCubit>(
          create: (context) => PackageDetailCubit(_repository),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: '.NET Packages',
            themeMode: themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
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
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
