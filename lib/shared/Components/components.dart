import 'package:flutter/material.dart';

Widget defualtButoon({
  bool upperCase = true,
  double width = 250,
  double height = 60,
  double borderRadius = 15,
  Color background = Colors.green,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          upperCase ? text.toUpperCase() : text,
          style: const TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.w200),
        ),
      ),
    );

Widget loginButton({
  bool uppercase = true,
  Color color = Colors.teal,
  double width = double.infinity,
  double height = 45,
  required Function() func,
  required String text,
}) =>
    Container(
      height: height,
      width: double.infinity,
      color: color,
      child: MaterialButton(
        onPressed: func,
        child: Text(
          uppercase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextFormField({
  required String? Function(String?) validate,
  required TextEditingController controller,
  void Function(String)? onChange,
  void Function(String)? onPress,
  required String labelText,
  required TextInputType textType,
  required IconData prefixIcon,
  bool isPassword = false,
  IconData? suffixIcon,
  Function()? suffexPressed,
  Function()? onTap,
}) =>
    TextFormField(
      onTap: onTap,
      validator: validate,
      controller: controller,
      keyboardType: textType,
      obscureText: isPassword,
      decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon),
          suffixIcon:
              IconButton(onPressed: suffexPressed, icon: Icon(suffixIcon))),
      onFieldSubmitted: (String x) {},
      onChanged: onChange,
    );

Widget BuildTaskItems({
  required String title,
  required String date,
  required String time,
}) =>
    Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 40,
            child: Text(
              "$time",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$title",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
              Text(
                "$date",
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
