// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/common/enums/common_enums.dart';

class UserPub {
  final String id;
  final String country;
  final String fullName;
  final Gender? gender;
  final DateTime? birthdate;
  late Reference _imageUrl;
  final String? about;

  UserPub({
    required this.id,
    required this.country,
    required this.fullName,
    required this.gender,
    required this.birthdate,
    required Reference? imageUrl,
    required this.about,
  }){
      imageUrl ??= FirebaseStorage.instance.ref().child("stores/images/$id");
      _imageUrl = imageUrl;
    }

  Reference get imageUrl => _imageUrl;
  

  UserPub copyWith({
    String? id,
    String? country,
    String? fullName,
    Gender? gender,
    DateTime? birthdate,
    Reference? imageUrl,
    String? about,
  }) {
    return UserPub(
      id: id ?? this.id,
      country: country ?? this.country,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      birthdate: birthdate ?? this.birthdate,
      imageUrl: imageUrl ?? this.imageUrl,
      about: about ?? this.about,
    );
  }

  @override
  String toString() {
    return 'UserPub(docId: $id, country: $country, fullName: $fullName, gender: $gender, birthdate: $birthdate, imageUrl: $imageUrl, about: $about)';
  }

  @override
  bool operator ==(covariant UserPub other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.country == country &&
      other.fullName == fullName &&
      other.gender == gender &&
      other.birthdate == birthdate &&
      other.imageUrl == imageUrl &&
      other.about == about;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      country.hashCode ^
      fullName.hashCode ^
      gender.hashCode ^
      birthdate.hashCode ^
      imageUrl.hashCode ^
      about.hashCode;
  }
}
