import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Widget customTextFormField({
  required BuildContext context,
  required String hint,
  required bool isPassword,
  required controller,
  IconData? suffixIcon,
  suffixPressed,
  required prefixIcon,
}) {
  OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.blue,
      ));
  return TextFormField(
    toolbarOptions: ToolbarOptions(copy: true, paste: true),
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(  
      filled: true,
      fillColor: Colors.blueGrey[50],
      suffixIcon: IconButton(
        icon: Icon(suffixIcon),
        onPressed: suffixPressed,
      ),
      prefixIcon: Icon(prefixIcon),
      hintText: hint,
      border: borderStyle,
      enabledBorder: borderStyle,
      enabled: true,
    ),
  );
}

void toastMessage(String val, BuildContext context) {
  if (val == "Email") {
    return Toast.show("Email is required", context, duration: 2);
  } else if (val == "Password") {
    return Toast.show("Password must be at least 8 chars", context,
        duration: 3);
  } else if (val == "username") {
    return Toast.show("UserName is required", context, duration: 2);
  } else if (val == "phone") {
    return Toast.show("Enter Correct phone number", context, duration: 2);
  } else {
    return Toast.show("The password isn\'t matched !", context, duration: 2);
  }
}
