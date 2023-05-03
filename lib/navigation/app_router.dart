import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/article.dart';
import '../ui/ui.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'news-feed',
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const NewsFeedScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        name: 'news-details',
        path: '/news-details/:articleId',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: NewsDetailsScreen(articleId: state.params['articleId'] ?? ''),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        name: 'news-category',
        path: '/news-category',
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: NewsCategoryScreen(
                category: NewsCategory.values
                    .where((category) =>
                        category.name == state.queryParams['category'])
                    .first),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ],
  );
}
