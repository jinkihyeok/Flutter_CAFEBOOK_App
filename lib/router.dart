import 'package:caffe_app/features/authentication/sign_up/first_screen.dart';
import 'package:caffe_app/features/authentication/sign_up/second_screen.dart';
import 'package:caffe_app/features/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/home",
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
    ),
  ],
);
