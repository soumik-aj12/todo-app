// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodoType {
  int id = 0;
  String title = "";
  TodoType({
    required this.id,
    required this.title,
  });

  TodoType copyWith({
    int? id,
    String? title,
  }) {
    return TodoType(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory TodoType.fromMap(Map<String, dynamic> map) {
    return TodoType(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoType.fromJson(String source) => TodoType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TodoType(id: $id, title: $title)';

  @override
  bool operator ==(covariant TodoType other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
