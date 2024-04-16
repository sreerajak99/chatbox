

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit(this.homecontext) : super(HomepageInitial());
  BuildContext homecontext;
  // final FirebaseFirestore firestoredata = FirebaseFirestore.instance;
//   Future<Stream<List<Map<String, dynamic>>>>chatLog()  async {
// return  firestoredata.collection("Users").snapshots().map((snapshot) {
//   return snapshot.docs.map((e) {
//     final user=e.data();
//     return user;
//   },).toList();
// },);
//   }
}
