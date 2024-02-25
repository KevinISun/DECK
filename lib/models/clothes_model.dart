class Clothes{
  final int? id;
  final String name;
  final String color;
  final int warmthLevel;
  final String type;

  const Clothes({this.id, required this.name, required this.color, required this.warmthLevel, required this.type});
  factory Clothes.fromMap(Map<String, dynamic> json) => Clothes(
    id: json['id'],
    name: json['name'],
    color: json['color'],
    warmthLevel: json['warmth_level'],
    type: json['type'],
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'color': color,
    'warmth_level': warmthLevel,
    'type': type,
  };
}