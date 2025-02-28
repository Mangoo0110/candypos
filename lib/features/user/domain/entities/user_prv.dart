// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/common/enums/common_enums.dart';

class UserPrv {
  final String id;
  String email;
  String country;
  String contactNo;
  String fullName;
  Gender? gender;
  DateTime? birthdate;
  final DateTime? joinedAt;
  late Reference _imageUrl;
  String about;

  UserPrv({
    required this.id,
    required this.email,
    required this.country,
    required this.contactNo,
    required this.fullName,
    required this.gender,
    required this.birthdate,
    required this.joinedAt,
    required Reference? imageUrl,
    required this.about,
  }){
      imageUrl ??= FirebaseStorage.instance.ref().child("stores/images/$id");
      _imageUrl = imageUrl;
    }

  Reference get imageUrl => _imageUrl;

  @override
  String toString() {
    return 'UserPrv(docId: $id, email: $email, country: $country, contactNo: $contactNo, fullName: $fullName, gender: $gender, birthdate: $birthdate, joinedAt: $joinedAt, imageUrl: $imageUrl, about: $about)';
  }

  UserPrv copyWith({
    String? id,
    String? email,
    String? country,
    String? contactNo,
    String? fullName,
    Gender? gender,
    DateTime? birthdate,
    DateTime? joinedAt,
    Reference? imageUrl,
    String? about,
  }) {
    return UserPrv(
      id: id ?? this.id,
      email: email ?? this.email,
      country: country ?? this.country,
      contactNo: contactNo ?? this.contactNo,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      birthdate: birthdate ?? this.birthdate,
      joinedAt: joinedAt ?? this.joinedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      about: about ?? this.about,
    );
  }

  @override
  bool operator ==(covariant UserPrv other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.country == country &&
      other.contactNo == contactNo &&
      other.fullName == fullName &&
      other.gender == gender &&
      other.birthdate == birthdate &&
      other.joinedAt == joinedAt &&
      other.imageUrl == imageUrl &&
      other.about == about;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      country.hashCode ^
      contactNo.hashCode ^
      fullName.hashCode ^
      gender.hashCode ^
      birthdate.hashCode ^
      joinedAt.hashCode ^
      imageUrl.hashCode ^
      about.hashCode;
  }
}
