class Post {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String description;
  final int starsCounter;

  const Post({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
    required this.starsCounter,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    return Post(
        id: dataJson['id'],
        title: dataJson['title'],
        thumbnailUrl: dataJson['thumbnail'],
        description: dataJson['selftext'],
        starsCounter: dataJson['ups']);
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.thumbnailUrl == thumbnailUrl &&
        other.description == description &&
        other.starsCounter == starsCounter;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
