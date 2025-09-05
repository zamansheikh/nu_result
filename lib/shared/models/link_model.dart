class LinkModel {
  final String title;
  final String baseUrl;
  final String path;
  final String subbaseUrl;
  final String regi;
  final String roll;
  final String year;
  final String exp1;
  final String sbase1;
  final String regi1;
  final String roll1;
  final String year1;
  final String exp2;
  final String sbase2;
  final String regi2;
  final String roll2;
  final String year2;
  final String exp3;
  final String sbase3;
  final String regi3;
  final String roll3;
  final String year3;
  final String exp4;
  final String sbase4;

  LinkModel({
    required this.title,
    required this.baseUrl,
    required this.path,
    required this.subbaseUrl,
    required this.regi,
    required this.roll,
    required this.year,
    required this.exp1,
    required this.sbase1,
    required this.regi1,
    required this.roll1,
    required this.year1,
    required this.exp2,
    required this.sbase2,
    required this.regi2,
    required this.roll2,
    required this.year2,
    required this.exp3,
    required this.sbase3,
    required this.regi3,
    required this.roll3,
    required this.year3,
    required this.exp4,
    required this.sbase4,
  });

  // Factory constructor to create LinkModel from JSON
  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(
      title: json['title'] as String? ?? '',
      baseUrl: json['baseUrl'] as String? ?? '',
      path: json['path'] as String? ?? '',
      subbaseUrl: json['subbaseUrl'] as String? ?? '',
      regi: json['regi'] as String? ?? '',
      roll: json['roll'] as String? ?? '',
      year: json['year'] as String? ?? '',
      exp1: json['exp1'] as String? ?? '',
      sbase1: json['sbase1'] as String? ?? '',
      regi1: json['regi1'] as String? ?? '',
      roll1: json['roll1'] as String? ?? '',
      year1: json['year1'] as String? ?? '',
      exp2: json['exp2'] as String? ?? '',
      sbase2: json['sbase2'] as String? ?? '',
      regi2: json['regi2'] as String? ?? '',
      roll2: json['roll2'] as String? ?? '',
      year2: json['year2'] as String? ?? '',
      exp3: json['exp3'] as String? ?? '',
      sbase3: json['sbase3'] as String? ?? '',
      regi3: json['regi3'] as String? ?? '',
      roll3: json['roll3'] as String? ?? '',
      year3: json['year3'] as String? ?? '',
      exp4: json['exp4'] as String? ?? '',
      sbase4: json['sbase4'] as String? ?? '',
    );
  }

  // Method to convert LinkModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'baseUrl': baseUrl,
      'path': path,
      'subbaseUrl': subbaseUrl,
      'regi': regi,
      'roll': roll,
      'year': year,
      'exp1': exp1,
      'sbase1': sbase1,
      'regi1': regi1,
      'roll1': roll1,
      'year1': year1,
      'exp2': exp2,
      'sbase2': sbase2,
      'regi2': regi2,
      'roll2': roll2,
      'year2': year2,
      'exp3': exp3,
      'sbase3': sbase3,
      'regi3': regi3,
      'roll3': roll3,
      'year3': year3,
      'exp4': exp4,
      'sbase4': sbase4,
    };
  }

  static String generateUrl(
    LinkModel linkModel,
    String regi,
    String roll,
    String year,
  ) {
    return linkModel.baseUrl +
        linkModel.path +
        linkModel.subbaseUrl +
        (linkModel.regi.isEmpty ? "" : regi) +
        (linkModel.roll.isEmpty ? "" : roll) +
        linkModel.year +
        linkModel.exp1 +
        linkModel.sbase1 +
        (linkModel.regi1.isEmpty ? "" : regi) +
        (linkModel.roll1.isEmpty ? "" : roll) +
        linkModel.year1 +
        linkModel.exp2 +
        linkModel.sbase2 +
        (linkModel.regi2.isEmpty ? "" : regi) +
        (linkModel.roll2.isEmpty ? "" : roll) +
        linkModel.year2 +
        linkModel.exp3 +
        linkModel.sbase3 +
        (linkModel.regi3.isEmpty ? "" : regi) +
        (linkModel.roll3.isEmpty ? "" : roll) +
        linkModel.year3 +
        linkModel.exp4 +
        linkModel.sbase4;
  }
}
