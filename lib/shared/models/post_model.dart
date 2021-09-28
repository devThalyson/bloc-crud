import 'dart:convert';

class PostModel {
  final int? id;
  final String? title;
  final String? description;
  final String? creationDate;
  final String? photoUrl;

  PostModel({
    this.id,
    this.title,
    this.description,
    this.creationDate,
    this.photoUrl,
  });

  PostModel copyWith({
    int? id,
    String? title,
    String? description,
    String? creationDate,
    String? photoUrl,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creationDate': creationDate,
      'photoUrl': photoUrl,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      creationDate: map['creationDate'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, description: $description, creationDate: $creationDate, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.creationDate == creationDate &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        creationDate.hashCode ^
        photoUrl.hashCode;
  }
}
