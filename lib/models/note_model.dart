import 'dart:ui';

class NoteModel {
  String title ;
  String content ;
  Color color;
NoteModel({
  required this.title ,
  required this.content,
  required this.color});



  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "content": content,
      "color": color.value,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map["title"],
      content: map["content"],
      color: Color(map["color"]),
    );
  }
}