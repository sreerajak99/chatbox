import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:timechatbox/view/homepage/homepage.dart';
part 'authlogin_state.dart';

class AuthloginCubit extends Cubit<AuthloginState> {
  AuthloginCubit(this.authcontext) : super(AuthloginInitial());
  BuildContext authcontext;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  loginservices() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      // Navigator.of(authcontext).push(MaterialPageRoute(
      //   builder: (context) => Homepage(),
      // ));
    } catch (error) {
      ScaffoldMessenger.of(authcontext)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      print("error");
    }

  }
}
