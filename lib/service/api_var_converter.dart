class ApiVarConverter {
  static int convertDeviceTypeToNumber({required String type}) {
    switch (type.toLowerCase()) {
      case "android" || "1":
        return 1;
      case "ios" || "0":
        return 0;
      default:
        return 1;
    }
  }
}
