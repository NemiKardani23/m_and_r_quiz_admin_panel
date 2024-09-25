import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api/state_city_api.dart';
import 'package:country_state_city/country_state_city.dart' as cs;

Widget showStateDialog(BuildContext context,
    {String? selectedState, void Function(cs.State? state)? onTap}) {
  return SearchAnchor(
    builder: (BuildContext context, SearchController controller) {
      if (selectedState != null) {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: transparent,
                side: const BorderSide(color: textFieldBorderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: NkGeneralSize.nkCommonBorderRadius,
                )),
            onPressed: () {
              controller.openView();
            },
            child: MyRegularText(label: selectedState));
      } else {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: transparent,
                side: const BorderSide(color: textFieldBorderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: NkGeneralSize.nkCommonBorderRadius,
                )),
            onPressed: () {
              controller.openView();
            },
            child: const MyRegularText(label: "$selectStr $stateStr"));
      }
    },
    suggestionsBuilder:
        (BuildContext context, SearchController controller) async {
      if (controller.text.isEmpty) {
        return (await StateCityApi.getStateList()).toList().map(
              (e) => InkWell(
                  onTap: () {
                    onTap?.call(e);
                    controller.closeView("");
                  },
                  child: MyRegularText(
                      label: e.name,
                      color: selectedState == e.name
                          ? Colors.blue
                          : Colors.black)),
            );
      } else {
        return (await StateCityApi.getStateList())
            .toList()
            .where((e) =>
                e.name.toLowerCase().contains(controller.text.toLowerCase()))
            .map(
              (e) => InkWell(
                  onTap: () {
                    onTap?.call(e);
                    controller.closeView("");
                  },
                  child: MyRegularText(
                    label: e.name,
                    color: selectedState == e.name ? Colors.blue : Colors.black,
                  )),
            );
      }
    },
  );
}

Widget showCityDialog(BuildContext context,
    {String? selectedCity,
    required String state,
    void Function(cs.City? city)? onTap}) {
  return SearchAnchor(
    builder: (BuildContext context, SearchController controller) {
      if (selectedCity != null) {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: transparent,
                side: const BorderSide(color: textFieldBorderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: NkGeneralSize.nkCommonBorderRadius,
                )),
            onPressed: () {
              controller.openView();
            },
            child: MyRegularText(label: selectedCity));
      } else {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: transparent,
                side: const BorderSide(color: textFieldBorderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: NkGeneralSize.nkCommonBorderRadius,
                )),
            onPressed: () {
              controller.openView();
            },
            child: const MyRegularText(label: "$selectStr $cityStr"));
      }
    },
    suggestionsBuilder:
        (BuildContext context, SearchController controller) async {
      var stateData = (await StateCityApi.getStateList())
          .firstWhere((element) => element.name == state);
      if (controller.text.isEmpty) {
        return (await StateCityApi.getCityList(
          stateData.countryCode,stateData.isoCode
        ))
            .toList()
            .map(
              (e) => InkWell(
                  onTap: () {
                    onTap?.call(e);
                    controller.closeView("");
                  },
                  child: MyRegularText(
                      label: e.name,
                      color: selectedCity == e.name
                          ? Colors.blue
                          : Colors.black)),
            );
      } else {
        return (await StateCityApi.getCityList(
                stateData.countryCode,stateData.isoCode))
            .toList()
            .where((e) => e.name
                .toLowerCase()
                .contains(controller.text.toLowerCase()))
            .map(
              (e) => InkWell(
                  onTap: () {
                    onTap?.call(e);
                    controller.closeView("");
                  },
                  child: MyRegularText(
                    label: e.name ,
                    color: selectedCity == e.name
                        ? Colors.blue
                        : Colors.black,
                  )),
            );
      }
    },
  );
}
