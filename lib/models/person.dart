// ignore_for_file: public_member_api_docs, sort_constructors_first

class Person {
  final String name;
  final String? imageUrl;
  final String characterName;
  const Person({
    required this.name,
    this.imageUrl,
    required this.characterName,
  });

  Person copyWith({
    String? name,
    String? imageUrl,
    String? characterName,
  }) {
    return Person(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      characterName: characterName ?? this.characterName,
    );
  }

  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      name: (map["name"] ?? '') as String,
      imageUrl: map['profile_path'],
      characterName: map['character'],
    );
  }
}
