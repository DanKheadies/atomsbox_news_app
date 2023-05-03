import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../models/article.dart';
import '../../../repositories/news_repository.dart';
import '../../news_details/views/news_details_screen.dart';
import '../blocs/news_category/news_category_bloc.dart';

class NewsCategoryScreen extends StatelessWidget {
  const NewsCategoryScreen({super.key, required this.category});

  final NewsCategory category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsCategoryBloc(newsRepository: context.read<NewsRepository>())
            ..add(NewsCategoryStarted(category: category)),
      child: NewsCategoryView(category: category),
    );
  }
}

class NewsCategoryView extends StatelessWidget {
  const NewsCategoryView({super.key, required this.category});

  final NewsCategory category;

  @override
  Widget build(BuildContext context) {
    NewsCategory? category =
        context.select((NewsCategoryBloc bloc) => bloc.state.category);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: AppText.headlineMedium(category?.name ?? ''),
      ),
      extendBody: true,
      body: BlocBuilder<NewsCategoryBloc, NewsCategoryState>(
        builder: (context, state) {
          if (state.status == NewsCategoryStatus.initial ||
              state.status == NewsCategoryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == NewsCategoryStatus.loaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppList.vertical(
                      listItems: state.articles.map((article) {
                        return AppCardImageAndContentBlock(
                          headline: AppText(
                            article.headline,
                            // fontWeight: FontWeight.bold,
                            maxLines: 1,
                          ),
                          subhead: article.byline,
                          supportingText: article.leadParagraph,
                          image: AppImage.network(article.imageUrl),
                          onTap: () {
                            context.push(
                              context.namedLocation(
                                'news-details',
                                params: {
                                  'articleId': article.id,
                                },
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
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
