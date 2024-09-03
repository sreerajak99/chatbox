import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timechatbox/model/lighttheam/icontext.dart';
import 'package:timechatbox/view/chatscreen/provider.dart';
import 'package:timechatbox/view/homepage/homepage.dart';
import 'package:timechatbox/view/register/register_page.dart';

class Drawercontent extends StatefulWidget {
  const Drawercontent({super.key, required this.name});

  final String name;

  @override
  State<Drawercontent> createState() => _DrawercontentState();
}

class _DrawercontentState extends State<Drawercontent> {
  @override
  Widget build(BuildContext context) {
    final imageprovider = Provider.of<Chatboxprovider>(context);
    return Drawer(
      surfaceTintColor: Colors.lightBlueAccent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(color: Colors.greenAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 50),
                    child: Consumer<Chatboxprovider>(
                      builder: (context, imageProvider, child) {
                        final FirebaseAuth auth= FirebaseAuth.instance;
                        // Assuming you have the user ID available (replace 'userId' with the actual user ID variable)
                        String userId =auth.currentUser!.uid;
                       // Replace with actual user ID variable

                        return FutureBuilder<String>(
                          future: imageProvider.downloadImageURL(userId),
                          // Pass the user ID to get the image URL
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return InkWell(
                                onTap: () {
                                  imageprovider.uploadImage(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child:
                                      Center(child: CircularProgressIndicator()),
                                  radius: 34,
                                ),
                              );
                            } else if (snapshot.hasError ||
                                !snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return GestureDetector(
                                onTap:() {
                                 imageprovider. uploadImage(context);
                                } ,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child:
                                      Center(child: Icon(Icons.person, size: 34)),
                                  // Default icon or image when there's an error
                                  radius: 34,
                                ),
                              );
                            } else {
                              final imageUrl =snapshot.data !;

                              return CircleAvatar(
                                backgroundImage: NetworkImage(imageUrl),
                                radius: 34,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 3),
                    child: Text(
                      'name',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            IconAndText(
              icoN: Icon(Icons.person),
              TExt: "My Profile",
              TextPressd: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Homepage(),
                ));
              },
              Onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Homepage(),
                ));
              },
            ),
            IconAndText(
              icoN: Icon(Icons.logout_outlined),
              TExt: "Logout",
              TextPressd: () {
                logoutfunction(context);
              },
              Onpressed: () {
                logoutfunction(context);
              },
            ),
            IconAndText(
              icoN: Icon(Icons.dock_outlined),
              TExt: "About Chat Box",
              TextPressd: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Homepage(),
                ));
              },
              Onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Homepage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> logoutfunction(BuildContext context) async {
  await logout(); // Call your user data clearing function here
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => RegisterPage()),
  );
}
