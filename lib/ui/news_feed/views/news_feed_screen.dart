import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/bottom_nav_bar.dart';
import '/ui/ui.dart';
import '../../../../models/models.dart';
import '../../../extensions/extensions.dart';
import '../../../repositories/news_repository.dart';
import '../blocs/news_feed/news_feed_bloc.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsFeedBloc(newsRepository: context.read<NewsRepository>())
            ..add(NewsFeedStarted()),
      child: const NewsFeedView(),
    );
  }
}

class NewsFeedView extends StatelessWidget {
  const NewsFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: AppText.headlineMedium('Breaking News'),
        actions: [
          AppIconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Container();
                },
              );
            },
            child: const Icon(Icons.notifications),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
      drawer: AppDrawer(
          title: AppGradientText(
              child: AppText.headlineMedium(AppConstants.appName)),
          drawerItems: NewsCategory.values.map(
            (value) {
              return AppListTile(
                onTap: () {
                  context.pushNamed(
                    'news-category',
                    queryParams: {'category': value.name},
                  );
                },
                title: AppText(value.name.capitalize()),
              );
            },
          ).toList(),
          drawerSecondaryItems: [
            AppListTile(
              onTap: () {},
              title: AppText('Settings'),
              leading: const Icon(Icons.settings),
            ),
          ]),
      extendBody: true,
      body: BlocBuilder<NewsFeedBloc, NewsFeedState>(
        builder: (context, state) {
          if (state.status == NewsFeedStatus.initial ||
              state.status == NewsFeedStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == NewsFeedStatus.loaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  (state.breakingNewsArticles.isNotEmpty)
                      ? AppCarousel(
                          carouselItems: state.breakingNewsArticles.map(
                            (article) {
                              return AppCardImageOverlay(
                                headline: AppText(
                                  article.headline,
                                  maxLines: 2,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                subhead: article.byline,
                                image: AppImage.network(
                                  article.imageUrl,
                                  height: size.height * 0.3,
                                  width: size.width,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ).toList(),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(AppConstants.sm),
                    child: (state.popularArticles.isNotEmpty)
                        ? AppList.vertical(
                            title: AppText('Popular'),
                            listItems: state.popularArticles.map(
                              (article) {
                                return AppListTile(
                                  title: AppText(article.headline),
                                  subtitle: AppText(article.byline),
                                  leadingWidth: size.height * 0.10,
                                  leading: AppImage.network(
                                    article.imageUrl,
                                    height: size.height * 0.10,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return NewsDetailsScreen(
                                            articleId: article.id,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ).toList(),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: AppText('Something went wrong'));
          }
        },
      ),
    );
  }
}
