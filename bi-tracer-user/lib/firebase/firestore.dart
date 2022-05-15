import 'package:bi_tracker_user/models/baby_model.dart';
import 'package:bi_tracker_user/models/doctor_model.dart';
import 'package:bi_tracker_user/models/mother_model.dart';
import 'package:bi_tracker_user/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FireStoreHelper {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static createBaby(Baby baby, String uid) {
    firestore.collection("babies").doc(uid).set(baby.toMap());
  }

  static linkMotherToDoctor(Doctor doctor, Mother mother) {
    firestore
        .collection("mothers")
        .doc(mother.uid)
        .update({"doctor": doctor.toMap()});
  }

  static Stream<QuerySnapshot> getBabysforMother(String uid) {
    //var newMother = mother.copyWith(doctor: null);
    return firestore
        .collection('babies')
        .where("mother.uid", isEqualTo: uid)
        .snapshots();
  }

  static Future<DocumentSnapshot> getDoctor(Doctor doctor) {
    return firestore.collection('mothers').doc(uid).get().then((value) {
      return doctor = value.data()!['doctor'];
    });
  }

  static Stream<QuerySnapshot> getCollection(String collectionName) {
    return firestore.collection(collectionName).snapshots();
  }

  static Stream<DocumentSnapshot> getBabyDataById(String babyId) {
    return FirebaseFirestore.instance
        .collection('babies')
        .doc(babyId)
        .snapshots();
  }

  static showOrNot(babyid, field, bool value) {
    firestore.collection('babies').doc(babyid).update({field: value});
  }

  static Stream<QuerySnapshot> getMotherFiltered(Doctor doctor) {
    return firestore
        .collection("mothers")
        .where("doctor", isNotEqualTo: doctor.toMap())
        .snapshots();
  }

  static Stream<DocumentSnapshot> getMother() {
    return firestore.collection("mothers").doc(uid).snapshots();
  }


}
