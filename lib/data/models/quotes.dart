class Quote {
  Quote({
    required this.quote,
    required this.author,
    required this.category,
  });
  late final String quote;
  late final String author;
  late final String category;

  Quote.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['quote'] = quote;
    _data['author'] = author;
    _data['category'] = category;
    return _data;
  }
}
