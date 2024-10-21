import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../export/___app_file_exporter.dart';

class NkCommonFunction {
  static Future<WebBrowserInfo> get webBrowserInfo async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return await deviceInfo.webBrowserInfo;
  }

  static Future lunchURL(Uri? url) async {
    if (url != null) {
        await launchUrl(url,webViewConfiguration: WebViewConfiguration(
          headers: ApiSecurity().authHeader
        ),);
    }
  }

 static Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return (bytes.isNotEmpty  ? base64Encode(bytes) : null);
}



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

  static List<String>? convertPathStringToList(String string) {
    List<String> list = [];
    list = string.split('/');
    if (list.firstOrNull == "") {
      return null;
    } else {
      return list;
    }
  }

  static List<Map<String, String>>? convertStingToMapList(String string) {
    List<Map<String, String>> map = [];
    List<String> list = [];
    if (string.isNotEmpty) {
      list = string.split(',');
      for (int i = 0; i < list.length; i++) {
        map.add({"key": list[i].split(":")[0], "value": list[i].split(":")[1]});
      }
      return map;
    } else {
      return null;
    }
  }

  static List<Map<String, String>>? convertStringJsonToList(String string) {
    List<Map<String, String>> list = [];
    if (string.isNotEmpty) {
      list = jsonDecode(string) as List<Map<String, String>>;
      return list;
    } else {
      return null;
    }
  }



  static List<Map<String, String>>? convertStringToListMap(String input) {
    if (input.isEmpty) {
      return null;
    }
    // Step 1: Prepare the string by adding quotes around keys and string values
    input = input
        .replaceAllMapped(RegExp(r'(\w+):'),
            (match) => '"${match[1]}":') // Add quotes around keys
        .replaceAllMapped(RegExp(r':\s*([^,\}\]]+)'), _temp)
        .replaceAll(",}", "}") // Handle trailing commas
        .replaceAll(",]", "]");

    // Step 2: Parse the string as JSON
    List<Map<String, dynamic>> decodedList =
        List<Map<String, dynamic>>.from(json.decode(input));

    // Step 3: Convert all map values to String
    return decodedList.map((map) {
      return map.map((key, value) => MapEntry(key, value?.toString() ?? ''));
    }).toList();
  }

  static String _temp(Match ma) {
    var value = ma[1]?.trim();
    if (value != null &&
        value.isNotEmpty &&
        value != 'null' &&
        !RegExp(r'^\d+$').hasMatch(value)) {
      return ': "$value"'; // Add quotes around string values
    }
    return ': "$value"'; // Ensure all values are strings
  }
}
