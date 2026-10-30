class NewsArticle {
  const NewsArticle({
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
    required this.url,
  });

  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String imageUrl;
  final String publishedAt;
  final String content;
  final String url;

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    final source = json['source'];
    return NewsArticle(
      sourceName: source is Map
          ? '${source['name'] ?? 'News Source'}'
          : 'News Source',
      author: '${json['author'] ?? 'Unknown Author'}',
      title: '${json['title'] ?? 'Untitled News'}',
      description: '${json['description'] ?? 'No description available.'}',
      imageUrl: '${json['urlToImage'] ?? ''}',
      publishedAt: '${json['publishedAt'] ?? ''}',
      content: '${json['content'] ?? ''}',
      url: '${json['url'] ?? ''}',
    );
  }
}
