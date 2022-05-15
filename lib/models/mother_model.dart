import 'dart:convert';

import 'package:bi_tracker_user/models/doctor_model.dart';

class Mother {
  String? name;
  String? fatherName;
  String? motherPhone;
  String? fatherPhone;
  String? email;
  String? password;
  String? uid;
  Doctor? doctor;
  String? notes;
  Mother({
    this.name,
    this.fatherName,
    this.motherPhone,
    this.fatherPhone,
    this.email,
    this.password,
    this.uid,
    this.doctor,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fatherName': fatherName,
      'motherPhone': motherPhone,
      'fatherPhone': fatherPhone,
      'email': email,
      'password': password,
      'uid': uid,
      'doctor': doctor?.toMap(),
      'notes': notes,
    };
  }

  factory Mother.fromMap(Map<String, dynamic> map) {
    return Mother(
      name: map['name'],
      fatherName: map['fatherName'],
      motherPhone: map['motherPhone'],
      fatherPhone: map['fatherPhone'],
      email: map['email'],
      password: map['password'],
      uid: map['uid'],
      doctor: map['doctor'] != null ? Doctor.fromMap(map['doctor']) : null,
      notes: map['notes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Mother.fromJson(String source) => Mother.fromMap(json.decode(source));

  Mother copyWith({
    String? name,
    String? fatherName,
    String? motherPhone,
    String? fatherPhone,
    String? email,
    String? password,
    String? uid,
    Doctor? doctor,
    String? notes,
  }) {
    return Mother(
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      motherPhone: motherPhone ?? this.motherPhone,
      fatherPhone: fatherPhone ?? this.fatherPhone,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      doctor: doctor ?? this.doctor,
      notes: notes ?? this.notes,
    );
  }
}
