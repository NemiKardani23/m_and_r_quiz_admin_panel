import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

class FileTypeOptionSelectWidget extends StatefulWidget {
  final void Function(String? id, FileTypeData? fileType)? onValueChanged;
  final String? value;
  const FileTypeOptionSelectWidget(
      {super.key, this.onValueChanged, this.value});

  @override
  State<FileTypeOptionSelectWidget> createState() =>
      _FileTypeOptionSelectWidgetState();
}

class _FileTypeOptionSelectWidgetState
    extends State<FileTypeOptionSelectWidget> {
  DataHandler<List<FileTypeData>> fileTypeDataHandler = DataHandler();

  @override
  void initState() {
    getMediaTypeData();
    super.initState();
  }

  void getMediaTypeData() async {
    TempDataStore.getFileTypeList.then(
      (value) {
        if (value != null) {
          setState(() {
            fileTypeDataHandler.onSuccess(value);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return fileTypeDataHandler.when(
        context: context,
        successBuilder: (fileTypeList) {
          return CupertinoSlidingSegmentedControl<String>(
            onValueChanged: (value) {
              widget.onValueChanged?.call(
                  value,
                  fileTypeList
                      .firstWhere((element) => element.id.toString() == value));
            },
            groupValue: widget.value ?? fileTypeList.first.id.toString(),
            children: _fileTypeOptions(fileTypeList),
          );
        });
  }

  Map<String, Widget> _fileTypeOptions(List<FileTypeData> fileTypeList) {
    Map<String, Widget> fileTypeMap = {};
    for (int i = 0; i < fileTypeList.length; i++) {
      fileTypeMap[fileTypeList[i].id.toString()] = MyRegularText(
        label: fileTypeList[i].typeName!,
        fontSize: NkFontSize.smallFont,
      );
    }
    return fileTypeMap;
  }
}
