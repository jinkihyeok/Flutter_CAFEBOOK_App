import 'package:caffe_app/features/authentication/views/first_screen.dart';
import 'package:caffe_app/features/authentication/views/second_screen.dart';
import 'package:caffe_app/features/detailpage/views/detailScreen.dart';
import 'package:caffe_app/features/home/views/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/second",
  routes: [
    GoRoute(
      name: FirstScreen.routeName,
      path: FirstScreen.routeURL,
      builder: (context, state) => const FirstScreen(),
    ),
    GoRoute(
      name: SecondScreen.routeName,
      path: SecondScreen.routeURL,
      builder: (context, state) => const SecondScreen(),
    ),
    GoRoute(
      name: HomeScreen.routeName,
      path: HomeScreen.routeURL,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: DetailScreen.routeName,
          path: DetailScreen.routeURL,
          builder: (context, state) {
            final placeId = state.pathParameters['placeId']!;
            return DetailScreen(placeId: placeId);
          },
        ),
      ],
    ),
  ],
);
