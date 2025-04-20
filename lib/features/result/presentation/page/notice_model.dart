import 'package:cloud_firestore/cloud_firestore.dart';

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
  //Make a static loadFromFirebase method
  static Future<List<NoticeModel>> loadFromFirebase() async {
    // Load data from Firebase
    final response = await FirebaseFirestore.instance.collection('notice').get();
    return response.docs.map((doc) => NoticeModel.fromJson(doc.data())).toList();
  }
  //Make a static saveToFirebase method
  Future<void> saveToFirebase() async {
    // Save data to Firebase
    await FirebaseFirestore.instance.collection('notice').add(toJson());
  }
}