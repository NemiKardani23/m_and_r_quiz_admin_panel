import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_and_r_quiz_admin_panel/utills/datetime/nk_date_utils.dart';

class BoardListModel {
  String? boardName;
  String? boardId;
  String? image;
  String? createAt;
  BoardListModel({this.boardId, this.boardName, this.image, this.createAt});

  BoardListModel.fromJson(Map<String, dynamic> json) {
    boardName = json['boardName'];
    boardId = json['boardId'].toString();
    image = json['image'];
    createAt =
        NKDateUtils.appDisplayDate((json['createdAt'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['boardName'] = boardName;
    data['boardId'] = boardId;
    data['image'] = image;
    data['createdAt'] = createAt;
    return data;
  }
}
