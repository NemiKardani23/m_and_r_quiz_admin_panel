class ChapterListModel {
  String? chapterName;
  String? chapterId;
  String? standardId;
  String? subjectId;
  String? boardId;
  String? image;
  String? createAt;

  ChapterListModel(
      {this.chapterName, this.chapterId, this.image, this.createAt});

  ChapterListModel.fromJson(Map<String, dynamic> json) {
    chapterName = json['chapterName'];
    chapterId = json['chapterId'];
    standardId = json['standardId'];
    subjectId = json['subjectId'];
    boardId = json['boardId'];
    image = json['image'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapterName'] = chapterName;
    data['chapterId'] = chapterId;
    data['standardId'] = standardId;
    data['subjectId'] = subjectId;
    data['boardId'] = boardId;
    data['image'] = image;
    data['createAt'] = createAt;
    return data;
  }
}
