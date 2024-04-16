import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
   AppButton({super.key, required this.text,required this.Ontap});

  final String text;
 VoidCallback Ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
      child: InkWell(onTap:Ontap ,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Text(text),
            ),
          ),
        ),
      ),
    );
  }
}
