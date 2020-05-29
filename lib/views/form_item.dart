import 'package:flutter/material.dart';

Widget    formItem(BuildContext context, String title, String hint, validator,
    TextEditingController controller,
    { obscureText = false }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 20),),
      Text(
        title.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Padding(padding: EdgeInsets.all(5),),
      TextFormField(
        obscureText: obscureText,
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        validator: ((value) {
          return (validator(value));
        }),
        onFieldSubmitted: ((v) {
          FocusScope.of(context).nextFocus();
        }),
      ),
    ],
  );
}