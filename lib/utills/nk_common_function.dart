import 'package:country_code_picker/country_code_picker.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkCommonFunction {
  static Widget passwordIcon(bool isShow) {
    if (isShow) {
      return const Icon(Icons.visibility);
    } else {
      return const Icon(Icons.visibility_off);
    }
  }

  static Widget selectCountryCode(
      {void Function(CountryCode)? onChanged,
      String? initialSelection,
      required BuildContext context}) {
    return CountryCodePicker(
      onChanged: onChanged,
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: initialSelection ?? '+91',
      favorite: const ['+91'],
      // optional. Shows only country name and flag
      showCountryOnly: false,
      // optional. Shows only country name and flag when popup is closed.
      showOnlyCountryWhenClosed: false,
      // optional. aligns the flag and the Text left
      alignLeft: false,
    );
  }
}
