import 'package:file_picker/file_picker.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_web_video_player/nk_web_video_player.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/null_check_oprations.dart';

class NkPickerWithPlaceHolder extends StatefulWidget {
  final String? imageUrl;
  final FileType? pickType;
  final String fileType;
  final String? lableText;
  final void Function(Uint8List? imageBytes, String? imageName)? onFilePicked;

  const NkPickerWithPlaceHolder({
    super.key,
    this.onFilePicked,
    this.imageUrl,
    this.lableText,
    this.pickType,
    required this.fileType,
  });

  @override
  State<NkPickerWithPlaceHolder> createState() =>
      _NkPickerWithPlaceHolderState();
}

class _NkPickerWithPlaceHolderState extends State<NkPickerWithPlaceHolder> {
  Uint8List? _fileBytes;
  String? _fileName;
  String? initalFileUrl;
  FileType _initialFileType = FileType.any;
  List<String>? allowedExtensions;

  @override
  void initState() {
    initalFileUrl = widget.imageUrl;
    _initialFileType = widget.pickType ?? FileType.any;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickFile() async {
    _initialFileType = widget.pickType ?? FileType.any;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: _initialFileType, allowedExtensions: allowedExtensions);

    if (result != null && result.files.first.bytes != null) {
      _handleFileType(result.files.first.name);
      setState(() {
        initalFileUrl = null;
        widget.onFilePicked
            ?.call(result.files.first.bytes, result.files.first.name);
        _fileBytes = result.files.first.bytes;
        _fileName = result.files.first.name;
      });
    }
  }

  void _removeFile() {
    setState(() {
      initalFileUrl = widget.imageUrl;
      widget.onFilePicked?.call(null, null);
      _fileBytes = null;
      _fileName = null;
    });
  }

  Widget _buildFilePreview() {
    if (_fileBytes == null) {
      if (!CheckNullData.checkNullOrEmptyString(initalFileUrl) &&
          widget.fileType == "image") {
        return MyNetworkImage(
          imageUrl: initalFileUrl ?? "",
          appHeight: context.height * 0.2,
          appWidth: context.height * 0.2,
        );
      } else if (!CheckNullData.checkNullOrEmptyString(initalFileUrl) &&
          widget.fileType == "video") {
        return NkWebVideoPlayer(
          networkUrl: initalFileUrl ?? "",
          id: UniqueKey().toString(),
          mimeType: _fileName!.split('.').last,
        );
      } else {
        if (widget.fileType == "image") {
          return Icon(Icons.image, size: context.height * 0.2);
        } else {
          return Icon(Icons.insert_drive_file, size: context.height * 0.2);
        }
      }
    } else {
      if (_initialFileType == FileType.image) {
        return Image.memory(
          _fileBytes!,
          height: context.height * 0.2,
          width: context.height * 0.2,
          fit: BoxFit.cover,
        );
      } else if (_initialFileType == FileType.video) {
        return ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: context.height * 0.25, maxWidth: context.width * 0.5),
          child: NkWebVideoPlayer(
            bytes: _fileBytes!,
            id: UniqueKey().toString(),
            mimeType: _fileName!.split('.').last,
          ),
        );
      } else {
        // For other document types
        return Icon(Icons.insert_drive_file, size: context.height * 0.2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _pickFile,
          child: _buildFilePreview(),
        ),
        if (_fileBytes != null) ...[
          TextButton.icon(
            onPressed: _removeFile,
            label: MyRegularText(label: _fileName ?? ''),
            icon: const Icon(Icons.remove_circle, color: Colors.red),
          )
        ] else if (!CheckNullData.checkNullOrEmptyString(initalFileUrl)) ...[
          TextButton.icon(
            onPressed: _pickFile,
            label: const MyRegularText(label: 'Edit File'),
            icon: const Icon(Icons.edit, color: primaryIconColor),
          )
        ],
        if (widget.lableText != null)
          MyRegularText(
              label: widget.lableText ?? '', fontSize: NkFontSize.smallFont),
      ],
    );
  }

  void _handleFileType(String fileName) {
    switch (fileName.split('.').last) {
      case "jpg" ||
            "jpeg" ||
            "png" ||
            "JPG" ||
            "JPEG" ||
            "PNG" ||
            "WEBp" ||
            "webp":
        setState(() {
          allowedExtensions = [
            "jpg",
            "jpeg",
            "png",
            "JPG",
            "JPEG",
            "PNG",
            "WEBp",
            "webp"
          ];
          _initialFileType = FileType.image;
        });
        break;
      case "mp4" ||
            "MP4" ||
            "mov" ||
            "MOV" ||
            "mkv" ||
            "MKV" ||
            "webm" ||
            "WEBM" ||
            "avi" ||
            "AVI":
        setState(() {
          allowedExtensions = [
            "mp4",
            "MP4",
            "mov",
            "MOV",
            "mkv",
            "MKV",
            "webm",
            "WEBM",
            "avi",
            "AVI"
          ];
          _initialFileType = FileType.video;
        });
        break;
      case "pdf" ||
            "PDF" ||
            "doc" ||
            "docx" ||
            "DOC" ||
            "DOCX" ||
            "ppt" ||
            "pptx" ||
            "PPT" ||
            "PPTX" ||
            "xls" ||
            "XLS" ||
            "xlsx" ||
            "XLSX" ||
            "txt" ||
            "TXT":
        setState(() {
          allowedExtensions = [
            "pdf",
            "PDF",
            "doc",
            "docx",
            "DOC",
            "DOCX",
            "ppt",
            "pptx",
            "PPT",
            "PPTX",
            "xls",
            "XLS",
            "xlsx",
            "XLSX",
            "txt",
            "TXT"
          ];
          _initialFileType = FileType.custom;
        });
        break;
      default:
        break;
    }
  }
}
