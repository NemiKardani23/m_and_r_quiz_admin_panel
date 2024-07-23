import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_and_r_quiz_admin_panel/utills/datetime/nk_date_utils.dart';

class StandardListModel {
  String? standardName;
  String? standardId;
  String? boardId;
  String? image;
  String? createAt;
  StandardListModel(
      {this.boardId,
      this.standardId,
      this.standardName,
      this.image,
      this.createAt});

  StandardListModel.fromJson(Map<String, dynamic> json) {
    standardName = json['standardName'].toString();
    standardId = json['standardId'].toString();
    boardId = json['boardId'].toString();
    image = json['image'];
    createAt =
        NKDateUtils.appDisplayDate((json['createdAt'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['standardName'] = standardName;
    data['standardId'] = standardId;
    data['boardId'] = boardId;
    data['image'] = image;

    return data;
  }
}
