import 'package:atomsbox/atomsbox.dart';
import 'package:json_annotation/json_annotation.dart';

import '../extensions/extensions.dart';
import 'author.dart';

part 'article.g.dart';

enum NewsCategory {
  @JsonValue('economy')
  economy,
  @JsonValue('politics')
  politics,
  @JsonValue('entertainment')
  entertainment,
  @JsonValue('sport')
  sport
}

@JsonSerializable()
class Article {
  const Article({
    required this.id,
    required this.author,
    required this.headline,
    required this.leadParagraph,
    required this.supportingParagraph,
    required this.imageUrl,
    this.createdAt,
    this.modifiedAt,
    this.category,
    this.isBreakingNews = false,
    this.isPopular = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  static const empty = Article(
    id: '',
    author: Author.empty,
    headline: AppConstants.text12,
    leadParagraph: AppConstants.text96,
    supportingParagraph: [
      AppConstants.text96,
      AppConstants.text96,
      AppConstants.text96,
    ],
    imageUrl: '',
  );

  /// A unique identifier for the Article
  final String id;

  /// The details about the author of the article
  final Author author;

  /// The title of the news article
  final String headline;

  /// Beginning of the article, briefly answers the questions “who”, “what”, “when”, “why”, “where”, and “how”
  final String leadParagraph;

  /// More content to develop the ideas introduced by the lead and give more information
  final List<String> supportingParagraph;

  /// The main image of the article
  final String imageUrl;

  /// The date/time at which the article was created
  final DateTime? createdAt;

  /// The date/time at which the article was last modified
  final DateTime? modifiedAt;

  /// The news category of the article
  final NewsCategory? category;

  /// Whether the article is one of the latest news in the app
  final bool isBreakingNews;

  /// Whether the article is among the most popular on the news app or not
  final bool isPopular;

  /// This line tells who is writing the article
  String get byline => '${author.name}, ${createdAt!.formattedDateTime()}';

  static List<Article> articles = [
    Article(
      id: '1',
      author: const Author(id: '1', name: 'Massimo', surname: 'D.'),
      headline: AppConstants.text12,
      leadParagraph: AppConstants.text96,
      supportingParagraph: [
        AppConstants.text96,
        AppConstants.text96,
        AppConstants.text96,
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1523292562811-8fa7962a78c8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      isBreakingNews: true,
      isPopular: true,
      category: NewsCategory.politics,
    ),
    Article(
      id: '2',
      author: const Author(id: '1', name: 'Massimo', surname: 'D.'),
      headline: AppConstants.text12,
      leadParagraph: AppConstants.text96,
      supportingParagraph: [
        AppConstants.text96,
        AppConstants.text96,
        AppConstants.text96,
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1678005102553-8d583f536691?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      isBreakingNews: true,
      isPopular: true,
      category: NewsCategory.economy,
    ),
    Article(
      id: '3',
      author: const Author(id: '1', name: 'Massimo', surname: 'D.'),
      headline: AppConstants.text12,
      leadParagraph: AppConstants.text96,
      supportingParagraph: [
        AppConstants.text96,
        AppConstants.text96,
        AppConstants.text96,
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1523995462485-3d171b5c8fa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1335&q=80',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      isBreakingNews: true,
      isPopular: true,
      category: NewsCategory.politics,
    ),
    Article(
      id: '4',
      author: const Author(id: '1', name: 'Massimo', surname: 'D.'),
      headline: AppConstants.text12,
      leadParagraph: AppConstants.text96,
      supportingParagraph: [
        AppConstants.text96,
        AppConstants.text96,
        AppConstants.text96,
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1678005102553-8d583f536691?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      isBreakingNews: false,
      isPopular: true,
      category: NewsCategory.economy,
    ),
    Article(
      id: '5',
      author: const Author(id: '1', name: 'Massimo', surname: 'D.'),
      headline: AppConstants.text12,
      leadParagraph: AppConstants.text96,
      supportingParagraph: [
        AppConstants.text96,
        AppConstants.text96,
        AppConstants.text96,
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1555848962-6e79363ec58f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1733&q=80',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      isBreakingNews: false,
      isPopular: true,
      category: NewsCategory.politics,
    ),
    Article(
      id: '6',
      author: const Author(id: '1', name: 'Massimo', surname: 'D.'),
      headline: AppConstants.text12,
      leadParagraph: AppConstants.text96,
      supportingParagraph: [
        AppConstants.text96,
        AppConstants.text96,
        AppConstants.text96,
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1678005102553-8d583f536691?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      isBreakingNews: false,
      isPopular: true,
      category: NewsCategory.economy,
    )
  ];
}
