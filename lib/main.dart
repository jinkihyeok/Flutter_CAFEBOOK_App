import 'package:caffe_app/features/authentication/repos/authentication_repo.dart';
import 'package:caffe_app/features/authentication/view_models/agree_vm.dart';
import 'package:caffe_app/features/authentication/views/first_screen.dart';
import 'package:caffe_app/features/home/views/home_screen.dart';
import 'package:caffe_app/features/home/views/item_view_model.dart';
import 'package:caffe_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import 'data/cafe_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(ProviderScope(
    child: provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (context) => AgreeViewModel()),
        provider.ChangeNotifierProvider(
            create: (context) => ItemViewModel(
                  repository: CafeRepository(),
                )),
      ],
      child: const CaffeApp(),
    ),
  ));
}

class CaffeApp extends ConsumerWidget {
  const CaffeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authRepo);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caffe App',
      themeMode: ThemeMode.light,
      home: auth.isLoggedIn ? const HomeScreen() : const FirstScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: true,
      ),
    );
  }
}
