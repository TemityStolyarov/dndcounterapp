class Table {
  final String name;
  final String description;
  final String image;
  final bool visibleForSelect;

  Table({
    required this.name,
    required this.description,
    required this.image,
    required this.visibleForSelect,
  });

  toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'visible_for_select': visibleForSelect,
    };
  }
}
