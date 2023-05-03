import 'dart:async';

import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../news_feed/views/news_feed_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (context) {
      return const SplashScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(milliseconds: 1500),
      () => context.goNamed('news-feed'),
    );

    return Scaffold(
      body: Center(
        child: AppText.headlineLarge('Breaking News'),
      ),
    );
  }
}
