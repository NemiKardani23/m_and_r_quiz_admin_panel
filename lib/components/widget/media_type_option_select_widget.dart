import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_regular_text.dart';
import 'package:m_and_r_quiz_admin_panel/utills/font_size/nk_font_size.dart';

class MediaTypeOptionSelectWidget extends StatelessWidget {
  final  void Function(String?)? onValueChanged;
  final String? value;
  const MediaTypeOptionSelectWidget({super.key,  this.onValueChanged, this.value});

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
      "Image":  MyRegularText(label:"Image",fontSize: NkFontSize.smallFont,),
      "Video": MyRegularText(label: "Video",fontSize: NkFontSize.smallFont,),
      "Gif": MyRegularText(label: "Gif",fontSize: NkFontSize.smallFont,),
      "Lottie": MyRegularText(label: "Lottie",fontSize: NkFontSize.smallFont,),
    };
  }
}