import 'dart:math';
import 'package:bi_tracker_user/firebase/auth.dart';
import 'package:bi_tracker_user/firebase/firestore.dart';
import 'package:bi_tracker_user/models/baby_model.dart';
import 'package:bi_tracker_user/models/mother_model.dart';
import 'package:bi_tracker_user/screens/babies_details.dart';
import 'package:bi_tracker_user/screens/login.dart';
import 'package:bi_tracker_user/shared/constants.dart';
import 'package:bi_tracker_user/shared/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BabyData extends StatelessWidget {
  BabyData({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreHelper.getBabysforMother(uid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          // TODO: do something with the data
          final list = snapshot.data!.docs
              .map((e) => Baby.fromMap(e.data() as Map<String, dynamic>))
              .toList();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Title'),
              actions: [
                IconButton(
                    onPressed: () {
                      Auth.logout(navigateReplacement(
                          context: context, route: const LogIn()));
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.signOutAlt,
                      size: 20,
                    ))
              ],
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    onTap: () {
                      navigate(
                          context: context,
                          route: BabyDetails(baby: list[index]));
                    },
                    leading: CircleAvatar(
                      backgroundColor:
                          Colors.primaries[min(list[index].name!.length, 17)],
                      child: Text(list[index].name![0].toUpperCase()),
                    ),
                    title: Text(list[index].name!),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .75,
                    child: const Divider(
                      thickness: 1.5,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // TODO: do something with the error
          return Text(snapshot.error.toString());
        }
        // TODO: the data is not ready, show a loading indicator
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
