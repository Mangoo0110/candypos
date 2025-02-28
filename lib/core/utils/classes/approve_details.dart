// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApproveDetails {
  /// Uid of the user
  final String approvedBy;
  final bool approved = true;
  final DateTime approvedAt;

  ApproveDetails({
    required this.approvedBy,
    required this.approvedAt,
  });




  ApproveDetails copyWith({
    String? approvedBy,
    DateTime? approvedAt,
  }) {
    return ApproveDetails(
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'approvedBy': approvedBy,
      'approved': approved,
      'approvedAt': approvedAt.toUtc().toIso8601String(),
    };
  }

  factory ApproveDetails.fromMap(Map<String, dynamic> map) {
    return ApproveDetails(
      approvedBy: map['approvedBy'] as String,
      approvedAt: DateTime.parse(map['approvedAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproveDetails.fromJson(String source) => ApproveDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApproveDetails(approvedBy: $approvedBy, approved: $approved, approvedAt: $approvedAt)';

  @override
  bool operator ==(covariant ApproveDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.approvedBy == approvedBy &&
      other.approved == approved &&
      other.approvedAt == approvedAt;
  }

  @override
  int get hashCode => approvedBy.hashCode ^ approved.hashCode ^ approvedAt.hashCode;
}
