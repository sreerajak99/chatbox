import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  const AppTextfield(
      {super.key, required this.hinTText, required this.controllerName,this.iconname});

  final String hinTText;
  final TextEditingController controllerName;
final Icon? iconname;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerName,
      decoration: InputDecoration(suffixIcon: iconname,
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hinTText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
    );
  }
}
