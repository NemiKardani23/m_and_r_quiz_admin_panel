import 'package:flutter_quill/flutter_quill.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/question_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_question_response.dart';

class QuizAddEditorModel {
  final QuillController controller;
  String? initalValue;
  GlobalKey<EditorState> editorKey = GlobalKey<EditorState>();
  String? hint;
  final FocusNode focusNode = FocusNode();

  QuizAddEditorModel({
    required this.controller,
    this.initalValue,
    this.hint,
  });
}

class QuizAddQustionEditorModel {
  bool isEditable = false;
  bool isNewData = true;
  String? marks;
  final QuizAddEditorModel questionController;
  QuestionTypeData? questionType;
  Duration? qustionCompletionTime;
  QuizQuestionOptionsEditorModel? description;
  List<QuizQuestionOptionsEditorModel>? options;
  QuizQuestionOptionsEditorModel? ansOption;
  QuizQuestionData? quizData;
  String? initalValue;
  QuizAddQustionEditorModel(
      {required this.questionController,
      this.questionType,
      this.quizData,
      this.description,
      this.isEditable = false,
      this.isNewData = true,
      this.initalValue,
      this.marks,
      this.qustionCompletionTime,
      this.options,
      this.ansOption});
}

class QuizQuestionOptionsEditorModel {
  final QuizAddEditorModel optionController;
  QuizQuestionOptionsEditorModel({required this.optionController});
}
