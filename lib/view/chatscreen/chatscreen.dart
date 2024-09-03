import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timechatbox/model/chatTextfiled.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:timechatbox/view/chatscreen/provider.dart';

class Chatscreen extends StatelessWidget {
  Chatscreen({Key? key, required this.receivername, required this.receverid}) : super(key: key);

  final String receivername;
  final String receverid;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ScrollController scrollController = ScrollController();

  String generateDocReferenceId(String userId, String receiverId) {
    List<String> ids = [userId, receiverId];
    ids.sort();
    return ids.join('_');
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatdata = Provider.of<Chatboxprovider>(context);
    final String userid = auth.currentUser!.uid;
    final String docreferenceid = generateDocReferenceId(userid, receverid);

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.call))],
        backgroundColor: Colors.green,
        toolbarHeight: 70,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
          ),
        ),
        title: Text(
          receivername,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("message")
                  .doc(docreferenceid)
                  .collection("messages")
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());

                return ListView.separated(
                  controller: scrollController,
                  itemCount: snapshot.data!.docs.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  itemBuilder: (context, index) {
                    var messageData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    return BubbleSpecialThree(delivered: false,


                      text: messageData['content'] as String? ?? 'No content',
                      color: messageData['sender'] == userid
                          ? Color(0xFF1B97F3)
                          : Color(0xFF1B97F3),
                      tail: false,
                      isSender: messageData['sender'] == userid,
                      textStyle: TextStyle(
                        color: messageData['sender'] == userid
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 4),
                );
              },
            ),
          ),
          ChatTextfield(
            receiver: receverid,
            dociddata: docreferenceid,
            controllername: chatdata.messagesender,
          ),
        ],
      ),
    );
  }
}