class NoticeModel {
  final String title;
  final String description;
  final String url;
  final String route;

  NoticeModel({
    required this.title,
    required this.description,
    required this.url,
    required this.route,
  });
  //fromjson
  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      route: json['route'],
    );
  }
  //tojson
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'route': route,
    };
  }
}
