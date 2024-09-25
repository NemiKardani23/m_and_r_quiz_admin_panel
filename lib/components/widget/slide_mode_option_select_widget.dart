import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_regular_text.dart';
import 'package:m_and_r_quiz_admin_panel/utills/font_size/nk_font_size.dart';

class SlideOptionSelectWidget extends StatelessWidget {
  final  void Function(String?)? onValueChanged;
  final String? value;
  const SlideOptionSelectWidget({super.key,  this.onValueChanged, this.value});

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<String>(onValueChanged: (value) { 
      onValueChanged?.call(value);
     },
     groupValue: value,

    children: _mediaTypeOptions(),);
  }


  Map<String, Widget> _mediaTypeOptions() {
    return {
      "Ad": MyRegularText(label:"Ad",fontSize: NkFontSize.smallFont,),
      "Normal": MyRegularText(label: "Normal",fontSize: NkFontSize.smallFont,),
      "Announcement": MyRegularText(label: "Announcement",fontSize: NkFontSize.smallFont,),
      "Offer": MyRegularText(label: "Offer",fontSize: NkFontSize.smallFont,),
    };
  }
}