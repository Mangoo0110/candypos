// ignore_for_file: public_member_api_docs, sort_constructors_first


class Unit {
  static List<Unit> units = [
    Unit.pcs(),
    Unit.gm(),
    Unit.kg(),
    Unit.litre(),
  ];
  final String shortName;
  
  final String longName;
  
  final bool weightItem;

  Unit({
    required this.shortName,
    required this.longName,
    required this.weightItem,
  });

  int get fieldCount => 3;


  factory Unit.kg(){
    return Unit(
        shortName: "kg", 
        longName: "Kilogram", 
        weightItem: true
      );
  }

  factory Unit.gm(){
    return Unit(
        shortName: "gm", 
        longName: "Gram", 
        weightItem: true
      );
  }

  factory Unit.litre(){
    return Unit(
        shortName: "litre", 
        longName: "Litre", 
        weightItem: true
      );
  }

  factory Unit.pcs(){
    return Unit(
        shortName: "pcs", 
        longName: "Pieces", 
        weightItem: false
      );
  }

  Unit copyWith({
    String? shortName,
    String? longName,
    bool? weightItem,
  }) {
    return Unit(
      shortName: shortName ?? this.shortName,
      longName: longName ?? this.longName,
      weightItem: weightItem ?? this.weightItem,
    );
  }


  @override
  String toString() => 'Unit(shortName: $shortName, longName: $longName, weightItem: $weightItem)';


  @override
  bool operator ==(covariant Unit other) {
    if (identical(this, other)) return true;
  
    return 
      other.shortName == shortName &&
      other.longName == longName &&
      other.weightItem == weightItem;
  }

  @override
  int get hashCode => shortName.hashCode ^ longName.hashCode ^ weightItem.hashCode;
}
