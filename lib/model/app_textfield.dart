import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  const AppTextfield(
      {super.key, required this.hinTText, required this.controllerName});

  final String hinTText;
  final TextEditingController controllerName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerName,
      decoration: InputDecoration(
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
