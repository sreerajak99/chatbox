
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timechatbox/model/app_button.dart';
import 'package:timechatbox/model/app_textfield.dart';
import 'package:timechatbox/view/chatscreen/provider.dart';
import '../register/register_page.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logindata=Provider.of<Chatboxprovider>(context);
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body:  SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const SizedBox(height: 150,),
                AnimatedPadding(
                    duration:const  Duration(seconds: 2),
                    padding: const EdgeInsets.all(50),
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                  duration: const Duration(seconds: 4),
                  child: AppTextfield(hinTText: "Email", controllerName: logindata.email),
                ),
                AnimatedPadding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                  duration:const  Duration(seconds: 4),
                  child: AppTextfield(hinTText: "Password", controllerName: logindata.password),
                ),
                AppButton(
                  text: "Login",
                  Ontap: () {
                    logindata.loginservices(context);
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
                      child: const Text(
                        "Register Now..!!",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),

      ),
    );
  }
}
