import 'package:flutter_task/core/routes/error_screen.dart';
import 'package:flutter_task/core/routes/routes.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/page/home_screen.dart';
import '../../features/home/presentation/page/repositories_details_screen.dart';


class RouteGenerator {
  static final GoRouter router = GoRouter(
    errorBuilder: (
      context,
      state,
    ) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
        path:
            '/',
        redirect: (
          context,
          state,
        ) {
          return "/${Routes.home}";
        },
      ),

     
      GoRoute(
        name:
            Routes.home,
        path:
            "/${Routes.home}",

        builder:
            (
              context,
              state,
            ) =>
                const HomeScreen(),
      ),

      GoRoute(
        name: Routes.repositoryDetail,
        path: "/${Routes.repositoryDetail}",
         builder:
            (
              context,
              state,
            ) =>
                const RepositoriesDetailsScreen(),)
    ],
  );
}
