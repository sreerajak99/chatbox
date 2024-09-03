import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timechatbox/view/chatscreen/provider.dart';
import 'package:timechatbox/view/loginpage/loginpage.dart';
import '../../model/app_button.dart';
import '../../model/app_textfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final registerdata=Provider.of<Chatboxprovider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150,),
                AnimatedPadding(
                    duration: Duration(seconds: 2),
                    padding: EdgeInsets.all(50),
                    child: Image.asset(
                        "assets/chatbox-high-resolution-logo-transparent.png")),
                Text(
                  "Lets create a Account for You ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary, fontSize: 17),
                ),
                AnimatedPadding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                  duration: Duration(seconds: 4),
                  child: AppTextfield(hinTText: "user_name", controllerName: registerdata.username),
                ),
                AnimatedPadding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                  duration: Duration(seconds: 4),
                  child: AppTextfield(hinTText: "email", controllerName:registerdata.email),
                ),
                AnimatedPadding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                  duration: Duration(seconds: 4),
                  child: AppTextfield(
                      hinTText: "password", controllerName: registerdata.password)
                ),
                AppButton(
                  text: "Register",
                  Ontap: () {
                    registerdata.Register(context);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Alredy have a Account?",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Loginpage(),
                        ));
                      },
                      child: Text(
                        "Login Now..!!",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
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
