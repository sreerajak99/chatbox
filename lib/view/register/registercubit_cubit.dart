import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:timechatbox/view/homepage/homepage.dart';

part 'registercubit_state.dart';

class RegistercubitCubit extends Cubit<RegistercubitState> {
  RegistercubitCubit(this.registercontext) : super(RegistercubitInitial());
  BuildContext registercontext;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformpassword = TextEditingController();

  register() async {
    if (password.text == conformpassword.text) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim())
            .then((value)async {
          await FirebaseFirestore.instance.collection("user").add({
            "name":email.text
          });
          Navigator.of(registercontext).push(MaterialPageRoute(
            builder: (context) => Homepage(),
          ));
            },);

      } catch (error) {}
    } else {
      ScaffoldMessenger.of(registercontext)
          .showSnackBar(SnackBar(content: Text("password error ")));
    }
  }
}
