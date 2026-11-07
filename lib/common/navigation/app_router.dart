import 'package:go_router/go_router.dart';
import '../../features/package/presentation/view/package_list_screen.dart';
import '../../features/package/presentation/view/package_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PackageListScreen(),
    ),
    GoRoute(
      path: '/package/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return PackageDetailScreen(packageId: id);
      },
    ),
  ],
);
