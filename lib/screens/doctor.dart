import 'package:bi_tracker_user/firebase/auth.dart';
import 'package:bi_tracker_user/firebase/firestore.dart';
import 'package:bi_tracker_user/models/doctor_model.dart';
import 'package:bi_tracker_user/models/mother_model.dart';
import 'package:bi_tracker_user/screens/login.dart';
import 'package:bi_tracker_user/shared/constants.dart';
import 'package:bi_tracker_user/shared/navigator.dart';
import 'package:bi_tracker_user/shared/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorOfMother extends StatelessWidget {
  DoctorOfMother({
    Key? key,
  }) : super(key: key);
  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: //null,
            FireStoreHelper.getMother(),
        builder: (context, snapshot) {
          print('aaaadsfsf');
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final list =
              Mother.fromMap(snapshot.data!.data() as Map<String, dynamic>);
          return Scaffold(
            appBar: AppBar(
              title: Text("Doctor"),
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
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Card(
                              color: mainColor,
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.userMd,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    myText(
                                        "Dr. " +
                                            list.doctor!.name!.toUpperCase(),
                                        size: 30,
                                        color: Colors.white),
                                  ],
                                ),
                              ))),
                      Divider(),
                      ListTile(
                        onTap: () {
                          _makePhoneCall(list.doctor!.phoneNumber!.toString());
                        },
                        title: const Text("Doctor number"),
                        trailing: FaIcon(FontAwesomeIcons.phone),
                        subtitle: Text(list.doctor!.phoneNumber!),
                      ),
                      Divider(),
                      ListTile(
                        trailing: FaIcon(FontAwesomeIcons.envelope),
                        title: Text("Doctor Email"),
                        subtitle: Text(list.doctor!.emailAdress!),
                      ),
                      Divider(),
                      // ListTile(
                      //   trailing: FaIcon(FontAwesomeIcons.notesMedical),
                      //   title: const Text(
                      //     "Notes",
                      //     maxLines: 4,
                      //     overflow: TextOverflow.clip,
                      //   ),
                      //   subtitle: Text(list.notes ?? 'No Notes'),
                      // ),
                      // Divider(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
