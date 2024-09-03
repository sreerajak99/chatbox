import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timechatbox/model/lighttheam/apptext.dart';
import 'package:timechatbox/model/lighttheam/drawerdata.dart';
import 'package:timechatbox/view/chatscreen/chatscreen.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 100,
        backgroundColor: Colors.green,
        elevation: 0,
      title: AppText(teXt: 'Chat Box',color: Colors.white,),
      ),
      drawer: Drawercontent(name: 'sreeraj'),
      body:StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("user").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No users found"));
                }

                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser == null) {
                  return const Center(child: Text("No user logged in"));
                }

                final allUsers = snapshot.data!.docs;
                final filteredUsers = allUsers
                    .where((doc) => doc.id != currentUser.uid)
                    .toList();

                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: ListView.separated(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final userDoc = filteredUsers[index];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Chatscreen(
                              receverid: userDoc['user_id'],
                                receivername: userDoc['user_name']),
                          ));
                        },
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        title: Text(userDoc["user_name"]),
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 4);
                    },
                  ),
                );

        },
      ),
    );
  }
}
