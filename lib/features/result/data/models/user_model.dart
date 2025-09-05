import 'package:nu_result/features/result/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.stdId,
    required super.regNo,
    required super.admissionRoll,
    required super.name,
    required super.fatherName,
    required super.motherName,
    required super.acSession,
    required super.acSessionExpire,
    required super.degreeCode,
    required super.degreeGroupCode,
    required super.collegeCode,
    required super.subjectCode,
    required super.examCode,
    required super.email,
    required super.mobile,
    required super.username,
    required super.passResetCode,
    required super.studentType,
    required super.gender,
    required super.photoUrl,
    required super.admissionScore,
    required super.meritPosition,
    required super.lock,
    required super.status,
    required super.createdBy,
    required super.updatedBy,
    required super.deletedBy,
    required super.active,
    required super.selectedCourseCode,
    required super.studentAcademicInfo,
    required super.college,
    required super.degree,
    required super.degreeGroup,
    required super.studentTypes,
    required super.subject,
    required super.subjects,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      stdId: json['std_id'] ?? '',
      regNo: json['reg_no'] ?? '',
      admissionRoll: json['admission_roll'] ?? '',
      name: json['name'] ?? '',
      fatherName: json['father_name'] ?? '',
      motherName: json['mother_name'] ?? '',
      acSession: json['ac_session'] ?? '',
      acSessionExpire: json['ac_session_expire'] ?? '',
      degreeCode: json['degree_code'] ?? '',
      degreeGroupCode: json['degree_group_code'] ?? '',
      collegeCode: json['college_code'] ?? '',
      subjectCode: json['subject_code'] ?? '',
      examCode: json['exam_code'],
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? "Phone number not found",
      username: json['username'] ?? '',
      passResetCode: json['pass_reset_code'],
      studentType: json['student_type'] ?? '',
      gender: json['gender'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      admissionScore: json['admission_score'],
      meritPosition: json['merit_position'],
      lock: json['lock'] ?? '',
      status: json['status'] ?? '',
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      active: json['active'],
      selectedCourseCode: json['selected_course_code'],
      studentAcademicInfo:
          List<dynamic>.from(json['student_academic_info'] ?? []),
      college: CollegeModel.fromJson(json['college'] ?? {}),
      degree: DegreeModel.fromJson(json['degree'] ?? {}),
      degreeGroup: DegreeGroupModel.fromJson(json['degree_group'] ?? {}),
      studentTypes: StudentTypesModel.fromJson(json['student_types'] ?? {}),
      subject: SubjectModel.fromJson(json['subject'] ?? {}),
      subjects: List<dynamic>.from(json['subjects'] ?? []),
    );
  }
}

class CollegeModel extends College {
  CollegeModel({
    required super.id,
    required super.collegeCode,
    required super.collegeEiin,
    required super.collegeName,
    required super.collegeType,
    required super.mgtType,
    required super.acSession,
    required super.email,
    required super.mobile,
    required super.phone,
    required super.fax,
    required super.webUrl,
    required super.address,
    required super.division,
    required super.district,
    required super.thana,
    required super.postCode,
    required super.districts,
  });

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return CollegeModel(
      id: json['id'] ?? 0,
      collegeCode: json['college_code'] ?? '',
      collegeEiin: json['college_eiin'] ?? '',
      collegeName: json['college_name'] ?? '',
      collegeType: json['college_type'] ?? '',
      mgtType: json['mgt_type'] ?? '',
      acSession: json['ac_session'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      phone: json['phone'],
      fax: json['fax'] ?? '',
      webUrl: json['web_url'] ?? '',
      address: json['address'] ?? '',
      division: json['division'] ?? '',
      district: json['district'] ?? '',
      thana: json['thana'] ?? '',
      postCode: json['post_code'] ?? '',
      districts: DistrictsModel.fromJson(json['districts'] ?? {}),
    );
  }
}

class DistrictsModel extends Districts {
  DistrictsModel({
    required super.id,
    required super.districtId,
    required super.divisionId,
    required super.districtCode,
    required super.districtOldCode,
    required super.districtName,
    required super.districtNameBn,
    required super.lock,
    required super.status,
    required super.createdBy,
    required super.updatedBy,
    required super.deletedBy,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required super.active,
  });

  factory DistrictsModel.fromJson(Map<String, dynamic> json) {
    return DistrictsModel(
      id: json['id'] ?? 0,
      districtId: json['district_id'] ?? '',
      divisionId: json['division_id'] ?? '',
      districtCode: json['district_code'] ?? '',
      districtOldCode: json['district_old_code'],
      districtName: json['district_name'] ?? '',
      districtNameBn: json['district_name_bn'] ?? '',
      lock: json['lock'] ?? '',
      status: json['status'] ?? '',
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
      deletedAt: json['deleted_at'],
      active: json['active'] ?? '',
    );
  }
}

class DegreeModel extends Degree {
  DegreeModel({
    required super.id,
    required super.degreeCode,
    required super.degreeName,
    required super.degreeDisplayName,
  });

  factory DegreeModel.fromJson(Map<String, dynamic> json) {
    return DegreeModel(
      id: json['id'] ?? 0,
      degreeCode: json['degree_code'] ?? '',
      degreeName: json['degree_name'] ?? '',
      degreeDisplayName: json['degree_display_name'] ?? '',
    );
  }
}

class DegreeGroupModel extends DegreeGroup {
  DegreeGroupModel({
    required super.id,
    required super.degreeCode,
    required super.degreeGroupCode,
    required super.degreeGroupName,
    required super.degreeGroupTitle,
    required super.degreeGroupDisplayName,
  });

  factory DegreeGroupModel.fromJson(Map<String, dynamic> json) {
    return DegreeGroupModel(
      id: json['id'] ?? 0,
      degreeCode: json['degree_code'] ?? '',
      degreeGroupCode: json['degree_group_code'] ?? '',
      degreeGroupName: json['degree_group_name'] ?? '',
      degreeGroupTitle: json['degree_group_title'],
      degreeGroupDisplayName: json['degree_group_display_name'] ?? '',
    );
  }
}

class StudentTypesModel extends StudentTypes {
  StudentTypesModel({
    required super.id,
    required super.studentType,
  });

  factory StudentTypesModel.fromJson(Map<String, dynamic> json) {
    return StudentTypesModel(
      id: json['id'] ?? 0,
      studentType: json['student_type'] ?? '',
    );
  }
}

class SubjectModel extends Subject {
  SubjectModel({
    required super.id,
    required super.subjectCode,
    required super.subjectName,
    required super.degreeCode,
    required super.degreeGroupCode,
    required super.displayName,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] ?? 0,
      subjectCode: json['subject_code'] ?? '',
      subjectName: json['subject_name'] ?? '',
      degreeCode: json['degree_code'] ?? '',
      degreeGroupCode: json['degree_group_code'] ?? '',
      displayName: json['display_name'] ?? '',
    );
  }
}
