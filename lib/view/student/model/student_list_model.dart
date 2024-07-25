import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_and_r_quiz_admin_panel/utills/datetime/nk_date_utils.dart';

class StudentListModel {
  String? studentName;
  String? studentNumber;
  String? numberCountryCode;
  String? studentCity;
  String? studentState;
  String? boardId;
  String? standardId;
  String? studentId;
  String? createdAt;
  String? image;
  String? fcmTocken;
  String? deviceName;
  String? deviceId;

  StudentListModel({
    this.studentName,
    this.studentNumber,
    this.numberCountryCode,
    this.studentCity,
    this.studentState,
    this.boardId,
    this.standardId,
    this.studentId,
    this.createdAt,
  });

  StudentListModel.fromJson(Map<String, dynamic> json) {
    studentName = json['studentName'] as String?;
    studentNumber = json['studentNumber'] as String?;
    numberCountryCode = json['numberCountryCode'] as String?;
    studentCity = json['studentCity'] as String?;
    studentState = json['studentState'] as String?;
    boardId = json['boardId'] as String?;
    standardId = json['standardId'] as String?;
    studentId = json['studentId'] as String?;
    createdAt = json['createdAt'] is Timestamp
        ? NKDateUtils.appDisplayDate((json['createdAt'] as Timestamp).toDate())
        : json['createdAt'].toString();
    image = json['image'] as String?;

    fcmTocken = json['fcm_tocken'] as String?;
    deviceName = json['device_name'] as String?;
    deviceId = json['device_id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['studentName'] = studentName;
    json['studentNumber'] = studentNumber;
    json['numberCountryCode'] = numberCountryCode;
    json['studentCity'] = studentCity;
    json['studentState'] = studentState;
    json['boardId'] = boardId;
    json['standardId'] = standardId;
    json['studentId'] = studentId;
    json['createdAt'] = createdAt;
    json['image'] = image;
    json['fcm_tocken'] = fcmTocken;
    json['device_name'] = deviceName;
    json['device_id'] = deviceId;
    return json;
  }
}
