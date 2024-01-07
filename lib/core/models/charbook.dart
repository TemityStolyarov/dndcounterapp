import 'package:dndcounterapp/core/models/character.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'charbook.g.dart';

@HiveType(typeId: 3)
class CharBook extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Character> chars;
  @HiveField(2)
  final int? coins;

  CharBook({
    required this.name,
    required this.chars,
    required this.coins,
  });

  CharBook.empty({
    this.name = '',
    this.chars = const [],
    this.coins = 0,
  });

  CharBook copyWith({
    String? name,
    List<Character>? chars,
    int? coins,
  }) =>
      CharBook(
        name: name ?? this.name,
        chars: chars ?? this.chars,
        coins: coins ?? this.coins,
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'charBook': chars,
      'coins': coins,
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
      coins: json['coins'],
    );
  }
}
