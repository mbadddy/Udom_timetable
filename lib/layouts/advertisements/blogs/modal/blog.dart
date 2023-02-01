
// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
  String author_url;
  String blog_url;
  String title;
  String body;
  String date;
  String venue;
  Blog({
    required this.author_url,
    required this.blog_url,
    required this.title,
    required this.body,
    required this.date,
    required this.venue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author_url': author_url,
      'blog_url': blog_url,
      'title': title,
      'body': body,
      'date': date,
      'venue': venue,
    };
  }

  static Blog fromMap(Map<String, dynamic> map) {
    return Blog(
      author_url: map['author_url'] as String,
      blog_url: map['blog_url'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      date: map['date'] as String,
      venue: map['venue'] as String,
    );
  }

}
