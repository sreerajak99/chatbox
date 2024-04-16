import 'package:flutter/material.dart';

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: CircleAvatar(maxRadius:5 ,
            child: Icon(Icons.person),
          ),
        ),
        title: Text("username"),
      ),
    );
  }
}
