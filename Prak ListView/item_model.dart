class ItemModel {
  final int id;
  String name;
  String description;
  String image;

  ItemModel({required this.id, required this.name, required this.description, required this.image});

  //Konversi ke Map untuk disimpan ke SharePreferences
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'description': description, 'image': image};
  }

  // Konversi dari Map ke ItemModel
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'] ?? 'images/Default NCT.jpg',
    );
  }
}
