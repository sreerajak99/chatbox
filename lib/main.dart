import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timechatbox/firebase_options.dart';
import 'package:timechatbox/model/lighttheam/theam.dart';
import 'package:timechatbox/view/chatscreen/provider.dart';
import 'package:timechatbox/view/homepage/homepage.dart';
import 'package:timechatbox/view/loginpage/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Chatboxprovider>(create: (context) => Chatboxprovider() ,)
      ],
      child: MaterialApp(
          title: "Chat Box",
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                return snapshot.hasData ? Homepage() : Loginpage();
              }),
          theme: lightmode),
    );
  }
}
