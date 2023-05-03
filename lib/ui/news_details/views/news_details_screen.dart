import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/news_repository.dart';
import '../blocs/news_details/news_details_bloc.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.articleId});

  final String articleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsDetailsBloc(newsRepository: context.read<NewsRepository>())
            ..add(NewsDetailsStarted(articleId)),
      child: const NewsDetailsView(),
    );
  }
}

class NewsDetailsView extends StatelessWidget {
  const NewsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        actions: [
          AppIconButton(
            onPressed: () {},
            child: const Icon(Icons.bookmark),
          ),
          AppIconButton(
            onPressed: () {},
            child: const Icon(Icons.share),
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      extendBody: true,
      body: BlocBuilder<NewsDetailsBloc, NewsDetailsState>(
        builder: (context, state) {
          if (state.status == NewsDetailsStatus.initial ||
              state.status == NewsDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == NewsDetailsStatus.loaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppConstants.borderRadius),
                      child: AppImage.network(
                        state.article.imageUrl,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    AppText.bodySmall(
                      state.article.category?.name ?? '',
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    AppText.bodyLarge(
                      state.article.headline,
                      maxLines: 2,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 4.0),
                    AppText.bodySmall(state.article.byline),
                    const SizedBox(height: 8.0),
                    AppText.bodyMedium(state.article.leadParagraph),
                    const SizedBox(height: 8.0),
                    ...state.article.supportingParagraph.map((paragraph) {
                      return Column(
                        children: [
                          AppText.bodyMedium(state.article.leadParagraph),
                          const SizedBox(height: 8.0)
                        ],
                      );
                    }),
                    const SizedBox(height: 60.0),
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
