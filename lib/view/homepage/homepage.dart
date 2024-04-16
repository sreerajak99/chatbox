import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timechatbox/view/chatscreen/chatscreen.dart';

import 'homepage_cubit.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => HomepageCubit(context),
        child: BlocBuilder<HomepageCubit, HomepageState>(
          builder: (context, state) {
            final cubitHomepage = context.read<HomepageCubit>();
            return StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("user").snapshots(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: ListView.separated(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Chatscreen(),
                                  ));
                                },
                                child: ListTile(
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                  title:
                                      Text(snapshot.data!.docs[index]["name"]),
                                  leading: CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 4,
                              );
                            },
                          ),
                        );
                });
          },
        ),
      ),
    );
  }
}
