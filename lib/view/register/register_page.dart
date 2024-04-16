import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timechatbox/view/loginpage/loginpage.dart';
import 'package:timechatbox/view/register/registercubit_cubit.dart';
import '../../model/app_button.dart';
import '../../model/app_textfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider(
  create: (context) => RegistercubitCubit(context),
  child: BlocBuilder<RegistercubitCubit, RegistercubitState>(
  builder: (context, state) {
    final cubitRegister=context.read<RegistercubitCubit>();

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            child: AppTextfield(hinTText: "Email", controllerName: cubitRegister.email),
          ),
          AnimatedPadding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
            duration: Duration(seconds: 4),
            child: AppTextfield(hinTText: "Password", controllerName:cubitRegister.password),
          ),
          AnimatedPadding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
            duration: Duration(seconds: 4),
            child: AppTextfield(
                hinTText: "Confirm Password", controllerName: cubitRegister.conformpassword),
          ),
          AppButton(
            text: "Login",
            Ontap: () {
              cubitRegister.register();
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
      );
  },
),
),
    );
  }
}
