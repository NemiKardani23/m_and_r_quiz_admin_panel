import 'package:flutter_quill/flutter_quill.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/question_type_response.dart';

class QuizAddEditorModel {
  final QuillController controller;
  GlobalKey<EditorState> editorKey = GlobalKey<EditorState>();
  String? hint;
  final FocusNode focusNode = FocusNode();

  QuizAddEditorModel({
    required this.controller,
    this.hint,
  });
}

class QuizAddQustionEditorModel {
  final QuizAddEditorModel questionController;
  QuestionTypeData? questionType;
  Duration? qustionCompletionTime;
  QuizQuestionOptionsEditorModel? description;
  List<QuizQuestionOptionsEditorModel>? options;
  QuizQuestionOptionsEditorModel? ansOption;
  QuizAddQustionEditorModel(
      {required this.questionController,
      this.questionType,
      this.qustionCompletionTime,
      this.options,
      this.ansOption});
}

class QuizQuestionOptionsEditorModel {
  final QuizAddEditorModel optionController;
  QuizQuestionOptionsEditorModel({required this.optionController});
}
