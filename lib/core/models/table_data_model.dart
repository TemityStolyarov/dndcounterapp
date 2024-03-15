class TableDataModel {
  final String name;
  final String description;
  final String image;
  final bool visibleForSelect;
  final String data;

  TableDataModel({
    required this.name,
    required this.description,
    required this.image,
    required this.visibleForSelect,
    required this.data,
  });

  toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'visible_for_select': visibleForSelect,
      'data': data,
    };
  }

  factory TableDataModel.fromJson(Map<String, dynamic> json) {
    return TableDataModel(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      visibleForSelect: json['visible_for_select'],
      data: json['data'],
    );
  }
}
