class Clothes{
  final int? id;
  final String name;
  final String color;
  final int warmthLevel;

  const Clothes({this.id, required this.name, required this.color, required this.warmthLevel});
  factory Clothes.fromMap(Map<String, dynamic> json) => Clothes(
    id: json['id'],
    name: json['name'],
    color: json['color'],
    warmthLevel: json['warmth_level'],
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'color': color,
    'warmth_level': warmthLevel,
  };
}