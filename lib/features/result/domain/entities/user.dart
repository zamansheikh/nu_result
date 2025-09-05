class User {
  int id;
  String stdId;
  String regNo;
  String admissionRoll;
  String name;
  String fatherName;
  String motherName;
  String acSession;
  String acSessionExpire;
  String degreeCode;
  String degreeGroupCode;
  String collegeCode;
  String subjectCode;
  dynamic examCode;
  String email;
  String mobile;
  String username;
  dynamic passResetCode;
  String studentType;
  String gender;
  String photoUrl;
  dynamic admissionScore;
  dynamic meritPosition;
  String lock;
  String status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic active;
  dynamic selectedCourseCode;
  List<dynamic> studentAcademicInfo;
  College college;
  Degree degree;
  DegreeGroup degreeGroup;
  StudentTypes studentTypes;
  Subject subject;
  List<dynamic> subjects;

  User({
    required this.id,
    required this.stdId,
    required this.regNo,
    required this.admissionRoll,
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.acSession,
    required this.acSessionExpire,
    required this.degreeCode,
    required this.degreeGroupCode,
    required this.collegeCode,
    required this.subjectCode,
    required this.examCode,
    required this.email,
    required this.mobile,
    required this.username,
    required this.passResetCode,
    required this.studentType,
    required this.gender,
    required this.photoUrl,
    required this.admissionScore,
    required this.meritPosition,
    required this.lock,
    required this.status,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.active,
    required this.selectedCourseCode,
    required this.studentAcademicInfo,
    required this.college,
    required this.degree,
    required this.degreeGroup,
    required this.studentTypes,
    required this.subject,
    required this.subjects,
  });
}

class College {
  int id;
  String collegeCode;
  String collegeEiin;
  String collegeName;
  String collegeType;
  String mgtType;
  String acSession;
  String email;
  String mobile;
  dynamic phone;
  String fax;
  String webUrl;
  String address;
  String division;
  String district;
  String thana;
  String postCode;
  Districts districts;

  College({
    required this.id,
    required this.collegeCode,
    required this.collegeEiin,
    required this.collegeName,
    required this.collegeType,
    required this.mgtType,
    required this.acSession,
    required this.email,
    required this.mobile,
    required this.phone,
    required this.fax,
    required this.webUrl,
    required this.address,
    required this.division,
    required this.district,
    required this.thana,
    required this.postCode,
    required this.districts,
  });
}

class Districts {
  int id;
  String districtId;
  String divisionId;
  String districtCode;
  dynamic districtOldCode;
  String districtName;
  String districtNameBn;
  String lock;
  String status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String active;

  Districts({
    required this.id,
    required this.districtId,
    required this.divisionId,
    required this.districtCode,
    required this.districtOldCode,
    required this.districtName,
    required this.districtNameBn,
    required this.lock,
    required this.status,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.active,
  });
}

class Degree {
  int id;
  String degreeCode;
  String degreeName;
  String degreeDisplayName;

  Degree({
    required this.id,
    required this.degreeCode,
    required this.degreeName,
    required this.degreeDisplayName,
  });
}

class DegreeGroup {
  int id;
  String degreeCode;
  String degreeGroupCode;
  String degreeGroupName;
  dynamic degreeGroupTitle;
  String degreeGroupDisplayName;

  DegreeGroup({
    required this.id,
    required this.degreeCode,
    required this.degreeGroupCode,
    required this.degreeGroupName,
    required this.degreeGroupTitle,
    required this.degreeGroupDisplayName,
  });
}

class StudentTypes {
  int id;
  String studentType;

  StudentTypes({
    required this.id,
    required this.studentType,
  });
}

class Subject {
  int id;
  String subjectCode;
  String subjectName;
  String degreeCode;
  String degreeGroupCode;
  String displayName;

  Subject({
    required this.id,
    required this.subjectCode,
    required this.subjectName,
    required this.degreeCode,
    required this.degreeGroupCode,
    required this.displayName,
  });
}
