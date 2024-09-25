import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_and_r_quiz_admin_panel/utills/datetime/nk_date_utils.dart';

class MyLearningCategoryListModel {
  String? categoryId;
  String? categoryName;
  String? categoryRouteName;
  String? categoryMode;
  String? image;
  String? createAt;
  MyLearningCategoryListModel({this.categoryId, this.image, this.createAt,  this.categoryMode, this.categoryName, this.categoryRouteName});

  MyLearningCategoryListModel.fromJson(Map<String, dynamic> json) {
    categoryMode = json['categoryMode'].toString();
    categoryName = json['categoryName'].toString();
    categoryRouteName = json['categoryRouteName'].toString();
    categoryId = json['categoryId'].toString();
    image = json['image'];
    createAt = json['createdAt'] is Timestamp ? NKDateUtils.appDisplayDate((json['createdAt'] as Timestamp).toDate()) : json['createdAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['categoryMode'] = categoryMode;
    data['categoryRouteName'] = categoryRouteName;
    data['image'] = image;
    data['createdAt'] = createAt;
    return data;
  }
}