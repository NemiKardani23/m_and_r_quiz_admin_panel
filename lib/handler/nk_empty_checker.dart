
class NKEmptyChecker {
  static bool checkListISNotEmpty(List? list, {Function()? onEmptyData}) {
    if (list?.isEmpty == true || list == null) {
      onEmptyData?.call();
      return false;
    } else {
      return true;
    }
  }

  // ************************************** API VALIDATIONS **************************************

  /// NOTE: This is used for ADD/EDIT/DELETE/CHANGE STATUS
  // static bool isApiCRUDValidation(CrudResponse? crudResponse) {
  //   if (crudResponse == null) {
  //     return false;
  //   } else if (crudResponse.error == true || crudResponse.user == null) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  static bool checkApiOBJTisNotEmpty(Map<String, dynamic>? jsonOBJ,
      {Function()? onEmptyData}) {
    if (jsonOBJ?.isEmpty == true || jsonOBJ == null) {
      return false;
    } else if (jsonOBJ['error'] == true) {
      return false;
    } else if (jsonOBJ['data'] == null) {
      onEmptyData?.call();
      return false;
    } else {
      if (jsonOBJ['data'] is List) {
        return checkListISNotEmpty(jsonOBJ['data'], onEmptyData: onEmptyData);
      } else {
        return true;
      }
    }
  }
}
