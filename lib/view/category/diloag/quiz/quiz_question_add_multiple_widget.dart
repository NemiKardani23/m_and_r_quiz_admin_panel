import 'package:file_picker/file_picker.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/utills/image_upload/nk_multipart.dart';

class QuizQuestionAddMultiple extends StatefulWidget {
  final String? testId;
  const QuizQuestionAddMultiple({super.key, this.testId});

  @override
  State<QuizQuestionAddMultiple> createState() =>
      _QuizQuestionAddMultipleState();
}

class _QuizQuestionAddMultipleState extends State<QuizQuestionAddMultiple> {
  (Uint8List?, String?)? _selectedFile;

  Future<void> _downloadDemoExcelSheet() async {
    // ApiWorker().downloadByCustom(ApiConstant().downloadSampleQuestionAPI,
    //     savePath: './xx.xlsx',
    //     queryParameters: {
    //       // 'access_key': ApiSecurity().$ApiAccessKey,
    //       'test_id': widget.testId
    //     },
    //     options: Options(
    //         headers: ApiSecurity().authHeader,
    //         responseType: ResponseType.bytes));
    // DioClient().getdio()
    NkCommonFunction.lunchURL(Uri.parse(
        "${ApiConstant().baseUrl}${ApiConstant().downloadSampleQuestionAPI}?test_id=${widget.testId}&access_key=${ApiSecurity().$ApiAccessKey}"));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: transparent,
      alignment: Alignment.center,
      contentPadding: 0.all,
      titlePadding: 0.all.copyWith(bottom: nkRegularPadding.bottom),
      title: Column(
        children: [
          MyCommnonContainer(
            padding: 16.horizontal,
            child: const MyAppBar(
              heading: "$addStr $multipleStr $questionStr",
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth:
                  context.isMobile ? context.width : context.width * 0.45),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return MyCommnonContainer(
      padding: 16.horizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.space,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const MyRegularText(
                label: "Demo Excel Sheet",
                fontSize: 16,
              ),
              10.space,
              MyThemeButton(
                onPressed: _downloadDemoExcelSheet,
                buttonText: "Download",
              ),
            ],
          ),
          10.space,
          NkPickerWithPlaceHolder(
            fileType: "excel",
            lableText: "Upload Excel File",
            pickType: FileType.any,
            onFilePicked: (bytes, fileName) {
              setState(() {
                _selectedFile = (bytes, fileName);
              });
              // Upload Excel sheet logic here
            },
          ),
          10.space,
          if (_selectedFile != null) ...[
            FittedBox(
              child: MyThemeButton(
                  buttonText: saveStr,
                  isLoadingButton: true,
                  onPressed: () async {
                    await ApiWorker()
                        .setMultipleQuestion(
                            testID: widget.testId.toString(),
                            file: NKMultipart.getMultipartFileBytes(
                                fileBytes: _selectedFile!.$1!,
                                name: _selectedFile!.$2!))
                        .then(
                      (value) {
                        if (value != null) {
                          Navigator.pop(context, value);
                          return;
                        }
                      },
                    );
                  }),
            )
          ]
        ],
      ),
    );
  }
}
