


import '../../../../core/common/enums/common_enums.dart';
import '../../../../core/common/functions/formatting.dart';
import '../../domain/entities/user_prv.dart';
import '../../domain/entities/user_pub.dart';

class UserPubModel extends UserPub {
  UserPubModel({
    required super.id,
    required super.fullName,
    required super.imageUrl,
    required super.about, 
    required super.birthdate,
    required super.gender,
    required super.country,
  });

  factory UserPubModel.fromEntity(UserPub user) {
    return UserPubModel(
      id: user.id,
      country: user.country,
      fullName: user.fullName,
      about: user.about, 
      gender: user.gender,
      birthdate: user.birthdate,
      imageUrl: user.imageUrl,
    );
  }

  factory UserPubModel.fromPrivateEntity(UserPrv user) {
    return UserPubModel(
      id: user.id,
      country: user.country,
      fullName: user.fullName,
      about: user.about, 
      gender: user.gender,
      birthdate: user.birthdate,
      imageUrl: user.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'country': country,
      'fullName': fullName,
      'imageUrl': imageUrl.fullPath,
      'about': about,
      'gender':gender?.name, 
      "birthdate": birthdate
    };
  }

  factory UserPubModel.fromMap(Map<String, dynamic> map) {
    return UserPubModel(
      id: map['id'] ?? map['id'] ?? '',
      country: map['country'] ?? '',
      fullName: map['fullName'] ?? '',
      gender: map['gender'] == null ? null
              : map['gender'] == Gender.male.name ? Gender.male
              : map['gender'] == Gender.female.name ? Gender.female
              : map['gender'] == Gender.other.name ? Gender.other
              : null,
      birthdate: parseDateTime(map['birthdate'] as dynamic),
      imageUrl: parseStorageReference(map["imageUrl"] as String),
      about: map["about"] ?? '',
    );
  }

  @override
  bool operator ==(covariant UserPubModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.country == country &&
      other.fullName == fullName &&
      other.imageUrl == imageUrl &&
      other.gender == gender &&
      other.birthdate == birthdate &&
      other.about == about;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      country.hashCode ^
      fullName.hashCode ^
      imageUrl.hashCode ^
      gender.hashCode ^
      birthdate.hashCode ^
      about.hashCode;
  }

}