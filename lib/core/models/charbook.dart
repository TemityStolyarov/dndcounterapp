import 'package:dndcounterapp/core/models/character.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'charbook.g.dart';

@HiveType(typeId: 3)
class CharBook extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Character> chars;

  CharBook({
    required this.name,
    required this.chars,
  });

  CharBook.empty({
    this.name = '',
    this.chars = const [],
  });

  CharBook copyWith({
    String? name,
    List<Character>? chars,
  }) =>
      CharBook(
        name: name ?? this.name,
        chars: chars ?? this.chars,
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'charBook': chars,
    };
  }

  factory CharBook.fromJson(Map<String, dynamic> json) {
    var charsJson = json['charBook'] as List<dynamic>?;
    List<Character> chars = charsJson != null
        ? charsJson.map((char) => Character.fromJson(char)).toList()
        : [];

    return CharBook(
      name: json['name'],
      chars: chars,
    );
  }
}
