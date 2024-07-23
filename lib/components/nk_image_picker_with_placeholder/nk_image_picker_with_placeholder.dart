import 'package:file_picker/file_picker.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_network_image.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/null_check_oprations.dart';

class NkImagePickerWithPlaceHolder extends StatefulWidget {
  final String? imageUrl;
  final void Function(Uint8List? imageBytes, String? imageName)? onImagePicked;
  const NkImagePickerWithPlaceHolder(
      {super.key, this.onImagePicked, this.imageUrl});

  @override
  State<NkImagePickerWithPlaceHolder> createState() =>
      _NkImagePickerWithPlaceHolderState();
}

class _NkImagePickerWithPlaceHolderState
    extends State<NkImagePickerWithPlaceHolder> {
  Uint8List? _imageBytes;
  String? initalImageUrl;
  String? _imageName;

  @override
  void initState() {
    initalImageUrl = widget.imageUrl;
    super.initState();
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.first.bytes != null) {
      setState(() {
        initalImageUrl = null;
        widget.onImagePicked
            ?.call(result.files.first.bytes, result.files.first.name);
        _imageBytes = result.files.first.bytes;
        _imageName = result.files.first.name;
      });
    }
  }

  void _removeImage() {
    setState(() {
      initalImageUrl = widget.imageUrl;
      widget.onImagePicked?.call(null, null);
      _imageBytes = null;
      _imageName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: _imageBytes == null
              ? CheckNullData.checkNullOrEmptyString(initalImageUrl)
                  ? Icon(Icons.add_photo_alternate, size: context.height * 0.2)
                  : MyNetworkImage(
                      imageUrl: initalImageUrl ?? "",
                      appHeight: context.height * 0.2,
                      appWidth: context.height * 0.2,
                    )
              : Image.memory(
                  _imageBytes!,
                  height: context.height * 0.2,
                  width: context.height * 0.2,
                  fit: BoxFit.cover,
                ),
        ),
        if (_imageBytes != null) ...[
          TextButton.icon(
            onPressed: _removeImage,
            label: MyRegularText(label: _imageName ?? ''),
            icon: const Icon(Icons.remove_circle, color: Colors.red),
          )
        ] else if (!CheckNullData.checkNullOrEmptyString(initalImageUrl)) ...[
          TextButton.icon(
            onPressed: _pickImage,
            label: const MyRegularText(label: 'Edit Image'),
            icon: const Icon(Icons.edit, color: primaryIconColor),
          )
        ]
      ],
    );
  }
}
