import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timechatbox/view/chatscreen/provider.dart';

class ChatTextfield extends StatelessWidget {
  const ChatTextfield({super.key, required this.controllername,required this.dociddata,required this.receiver});

  final TextEditingController controllername;
final String dociddata;
final String receiver;
  @override
  Widget build(BuildContext context) {
    final chatprovide = Provider.of<Chatboxprovider>(context);
    return TextFormField(
      controller: controllername,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                chatprovide.messagesendingservices(dociddata,receiver);
              },
              icon: const Icon(Icons.send)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: "type message..",
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
    );
  }
}
