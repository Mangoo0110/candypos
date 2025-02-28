


import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/enums/common_enums.dart';
import '../../../../core/common/functions/formatting.dart';
import '../../domain/entities/user_prv.dart';

class UserPrvModel extends UserPrv {
  UserPrvModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.gender,
    required super.birthdate,
    required super.joinedAt,
    required super.imageUrl,
    required super.about, 
    required super.country, 
    required super.contactNo,
  });

  factory UserPrvModel.fromEntity(UserPrv user) {
    return UserPrvModel(
      id: user.id,
      email:user.email,
      country: user.country,
      contactNo: user.contactNo,
      fullName: user.fullName,
      gender: user.gender,
      birthdate: user.birthdate,
      joinedAt: user.joinedAt,
      imageUrl: user.imageUrl,
      about: user.about,
    );
  }


   

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': id,
      'email': email,
      'country': country,
      'contactNo': contactNo,
      'fullName': fullName,
      'gender': gender?.name,
      'birthdate': birthdate,
      'joinedAt': joinedAt,
      'imageUrl': imageUrl.fullPath,
      'about': about,
    };
  }

  factory UserPrvModel.fromMap(Map<String, dynamic> map) {
    return UserPrvModel(
      id: map['docId'] ?? map['id'] ?? '',
      email: map['email'] ?? '',
      country: map['country'] ?? '',
      contactNo: map['contactNo'] ?? '',
      fullName: map['fullName'] ?? '',
      gender: map['gender'] == null ? null
              : map['gender'] == Gender.male.name ? Gender.male
              : map['gender'] == Gender.female.name ? Gender.female
              : map['gender'] == Gender.other.name ? Gender.other
              : null,
      birthdate: parseDateTime(map['birthdate'] as dynamic),
      imageUrl: parseStorageReference(map["imageUrl"] as String) ?? FirebaseStorage.instance.ref().child("stores/images/${map["id"]}"),
      joinedAt:  parseDateTime(map['joinedAt'] as dynamic), 
      about: map["about"] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserPrvModel(docId: $id, email: $email, country: $country, contactNo: $contactNo, fullName: $fullName, gender: $gender, birthdate: ${birthdate == null ? 'null' : DateFormat.yMMMd().format(birthdate!)}, imageUrl: ${imageUrl.fullPath}, about: $about)';
  }

  @override
  bool operator ==(covariant UserPrvModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.country == country &&
      other.contactNo == contactNo &&
      other.fullName == fullName &&
      other.gender == gender &&
      other.birthdate == birthdate &&
      //other.joinedAt == joinedAt &&
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
      //joinedAt.hashCode ^
      imageUrl.hashCode ^
      about.hashCode;
  }

}