class QuizQuestionResponse {
  QuizQuestionResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
    required this.timestamp,
  });

  final bool? status;
  final String? message;
  final List<QuizQuestionData> data;
  final List<dynamic> errors;
  final DateTime? timestamp;

  QuizQuestionResponse copyWith({
    bool? status,
    String? message,
    List<QuizQuestionData>? data,
    List<dynamic>? errors,
    DateTime? timestamp,
  }) {
    return QuizQuestionResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
      errors: errors ?? this.errors,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory QuizQuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuizQuestionResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<QuizQuestionData>.from(
              json["data"]!.map((x) => QuizQuestionData.fromJson(x))),
      errors: json["errors"] == null
          ? []
          : List<dynamic>.from(json["errors"]!.map((x) => x)),
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
        "errors": errors.map((x) => x).toList(),
        "timestamp": timestamp?.toIso8601String(),
      };

  @override
  String toString() {
    return "$status, $message, $data, $errors, $timestamp, ";
  }
}

class QuizQuestionData {
  QuizQuestionData({
    required this.questionId,
    required this.sequence,
    required this.testId,
    required this.questionTypeId,
    required this.questionText,
    required this.optionsList,
    required this.marks,
    required this.duration,
    required this.correctAnswer,
    required this.answerDescription,
    required this.questionImage,
    required this.status,
    required this.updatedTest,
  });

  final int? questionId;
  final num? sequence;
  final String? testId;
  final String? questionTypeId;
  final String? questionText;
  final List<String> optionsList;
  final String? marks;
  final String? duration;
  final String? correctAnswer;
  final String? answerDescription;
  final dynamic questionImage;
  final String? status;
  final QuizQuestionUpdatedTest? updatedTest;

  QuizQuestionData copyWith({
    int? questionId,
    num? sequence,
    String? testId,
    String? questionTypeId,
    String? questionText,
    List<String>? optionsList,
    String? marks,
    String? duration,
    String? correctAnswer,
    String? answerDescription,
    dynamic questionImage,
    String? status,
    QuizQuestionUpdatedTest? updatedTest,
  }) {
    return QuizQuestionData(
      questionId: questionId ?? this.questionId,
      sequence: sequence ?? this.sequence,
      testId: testId ?? this.testId,
      questionTypeId: questionTypeId ?? this.questionTypeId,
      questionText: questionText ?? this.questionText,
      optionsList: optionsList ?? this.optionsList,
      marks: marks ?? this.marks,
      duration: duration ?? this.duration,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      answerDescription: answerDescription ?? this.answerDescription,
      questionImage: questionImage ?? this.questionImage,
      status: status ?? this.status,
      updatedTest: updatedTest ?? this.updatedTest,
    );
  }

  factory QuizQuestionData.fromJson(Map<String, dynamic> json) {
    return QuizQuestionData(
      questionId: json["question_id"],
      sequence: json["sequence"],
      testId: json["test_id"]?.toString(),
      questionTypeId: json["question_type_id"].toString(),
      questionText: json["question_text"],
      optionsList: json["options_list"] == null
          ? []
          : List<String>.from(json["options_list"]!.map((x) => x)),
      marks: json["marks"],
      duration: json["duration"].toString(),
      correctAnswer: json["correct_answer"],
      answerDescription: json["answer_description"],
      questionImage: json["question_image"],
      status: json["status"],
      updatedTest: json["updated_test"] == null
          ? null
          : QuizQuestionUpdatedTest.fromJson(json["updated_test"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "sequence": sequence,
        "test_id": testId,
        "question_type_id": questionTypeId,
        "question_text": questionText,
        "options_list": optionsList.map((x) => x).toList(),
        "marks": marks,
        "duration": duration,
        "correct_answer": correctAnswer,
        "answer_description": answerDescription,
        "question_image": questionImage,
        "status": status,
        "updated_test": updatedTest?.toJson(),
      };

  @override
  String toString() {
    return "$questionId, $sequence, $testId, $questionTypeId, $questionText, $optionsList, $marks, $duration, $correctAnswer, $answerDescription, $questionImage, $status, $updatedTest, ";
  }
}

class QuizQuestionUpdatedTest {
  QuizQuestionUpdatedTest({
    required this.totalQuestions,
    required this.totalMarks,
    required this.totalDuration,
  });

  final num? totalQuestions;
  final num? totalMarks;
  final num? totalDuration;

  QuizQuestionUpdatedTest copyWith({
    num? totalQuestions,
    num? totalMarks,
    num? totalDuration,
  }) {
    return QuizQuestionUpdatedTest(
      totalQuestions: totalQuestions ?? this.totalQuestions,
      totalMarks: totalMarks ?? this.totalMarks,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }

  factory QuizQuestionUpdatedTest.fromJson(Map<String, dynamic> json) {
    return QuizQuestionUpdatedTest(
      totalQuestions: json["total_questions"],
      totalMarks: json["total_marks"],
      totalDuration: json["total_duration"],
    );
  }

  Map<String, dynamic> toJson() => {
        "total_questions": totalQuestions,
        "total_marks": totalMarks,
        "total_duration": totalDuration,
      };

  @override
  String toString() {
    return "$totalQuestions, $totalMarks, $totalDuration, ";
  }
}
