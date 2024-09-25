import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_regular_text.dart';
import 'package:m_and_r_quiz_admin_panel/utills/font_size/nk_font_size.dart';

class MyLearningCategoryOptionSelectWidget extends StatelessWidget {
  final  void Function(String?)? onValueChanged;
  final String? value;
  const MyLearningCategoryOptionSelectWidget({super.key,  this.onValueChanged, this.value});

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
      "Free": MyRegularText(label:"Free",fontSize: NkFontSize.smallFont,),
      "Paid": MyRegularText(label: "Paid",fontSize: NkFontSize.smallFont,),
      "Both": MyRegularText(label: "Both",fontSize: NkFontSize.smallFont,),
      
    };
  }
}