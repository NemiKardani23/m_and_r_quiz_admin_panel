import 'package:flutter_quill/flutter_quill.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class QuizAddEditorModel {
  final QuillController controller;
  String? hint;
  final FocusNode focusNode = FocusNode();

  QuizAddEditorModel({required this.controller, this.hint});
}

class QuizAddQustionEditorModel  {
  final QuizAddEditorModel questionController;
  final int questionType;
   Duration? qustionCompletionTime;
  List<QuizQuestionOptionsEditorModel>? options;
  QuizQuestionOptionsEditorModel? currentOption;
  QuizAddQustionEditorModel( {required this.questionController,  this.questionType=1,this.qustionCompletionTime, this.options, this.currentOption});
}

class QuizQuestionOptionsEditorModel  {
  final QuizAddEditorModel optionController;
  QuizQuestionOptionsEditorModel({required this.optionController});
}
