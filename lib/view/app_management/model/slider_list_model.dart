import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_and_r_quiz_admin_panel/utills/datetime/nk_date_utils.dart';

class SliderListModel {
  String? sliderId;
  String? sliderContentType;
  String? sliderMode;
  String? image;
  String? createAt;
  SliderListModel({this.sliderId, this.image, this.createAt, this.sliderContentType, this.sliderMode});

  SliderListModel.fromJson(Map<String, dynamic> json) {
    sliderContentType = json['sliderContentType'];
    sliderMode = json['sliderMode'];
    sliderId = json['sliderId'].toString();
    image = json['image'];
    createAt = json['createdAt'] is Timestamp ? NKDateUtils.appDisplayDate((json['createdAt'] as Timestamp).toDate()) : json['createdAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sliderId'] = sliderId;
    data['sliderContentType'] = sliderContentType;
    data['sliderMode'] = sliderMode;
    data['image'] = image;
    data['createdAt'] = createAt;
    return data;
  }
}