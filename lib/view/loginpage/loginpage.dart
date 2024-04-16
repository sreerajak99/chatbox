import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timechatbox/model/app_button.dart';
import 'package:timechatbox/model/app_textfield.dart';
import '../register/register_page.dart';
import 'authlogin_cubit.dart';


class Loginpage extends StatelessWidget {
  Loginpage({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: BlocProvider(
  create: (context) => AuthloginCubit(context),
  child: BlocBuilder<AuthloginCubit, AuthloginState>(
  builder: (context, state) {
    final logCubit=context.read<AuthloginCubit>();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedPadding(
              duration: Duration(seconds: 2),
              padding: EdgeInsets.all(50),
              child: Image.asset(
                  "assets/chatbox-high-resolution-logo-transparent.png")),
          Text(
            "Welcome Back",
            style: TextStyle(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary, fontSize: 17),
          ),
          AnimatedPadding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
            duration: Duration(seconds: 4),
            child: AppTextfield(hinTText: "Email", controllerName: logCubit.email),
          ),
          AnimatedPadding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
            duration: Duration(seconds: 4),
            child: AppTextfield(hinTText: "Password", controllerName: logCubit.password),
          ),
          AppButton(
            text: "Login",
            Ontap: () {
              logCubit.loginservices();
            },
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member ?",
                style: TextStyle(color: Theme
                    .of(context)
                    .colorScheme
                    .primary),
              ),
              InkWell(onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>RegisterPage(),));
              },
                child: Text(
                  "Register Now..!!",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      );
  },
),
),
    );
  }
}
