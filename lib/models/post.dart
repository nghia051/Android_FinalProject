class Review {
  final String title;
  final String content;

  Review({required this.title, required this.content});
}

class Comment {
  final String user;
  final String content;

  Comment({required this.user, required this.content});
}

List<Comment> emptyList = [];

class Post {
  List getListComment() {
    return emptyList;
  }

  int getFavorite() {
    return 0;
  }

  Review getReview() {
    return Review(title: '', content: '');
  }

  DateTime getDate() {
    return DateTime(2003, 05, 28);
  }

  int getRate() {
    return 5;
  }
}
