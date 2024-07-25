import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_and_r_quiz_admin_panel/utills/datetime/nk_date_utils.dart';

class SubjectListModel {
  String? subjectName;
  String? standardId;
  String? subjectId;
  String? boardId;
  String? image;
  String? createAt;
  SubjectListModel(
      {this.boardId,
      this.standardId,
      this.subjectName,
      this.image,
      this.createAt});

  SubjectListModel.fromJson(Map<String, dynamic> json) {
    subjectName = json['subjectName'].toString();
    standardId = json['standardId'].toString();
    subjectId = json['subjectId'].toString();
    boardId = json['boardId'].toString();
    image = json['image'];
    createAt = json['createdAt'] is Timestamp ? NKDateUtils.appDisplayDate((json['createdAt'] as Timestamp).toDate()) : json['createdAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectName'] = subjectName;
    data['subjectId'] = subjectId;
    data['standardId'] = standardId;
    data['boardId'] = boardId;
    data['image'] = image;
    data['createdAt'] = createAt;
    return data;
  }
}
