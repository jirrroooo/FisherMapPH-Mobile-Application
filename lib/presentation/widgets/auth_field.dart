import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  AuthField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordMatch = RegExp(r'.*Password.*');
    final nameMatch = RegExp(r'.*Name.*');
    final emailMatch = RegExp(r'.*Email.*');
    final birthdayMatch = RegExp(r'.*Birthday.*');
    final contactMatch = RegExp(r'.*Contact.*');
    final addressMatch = RegExp(r'.*Address.*');

    bool isPass = passwordMatch.hasMatch(hintText);
    bool isName = nameMatch.hasMatch(hintText);
    bool isEmail = emailMatch.hasMatch(hintText);
    bool isBirthday = birthdayMatch.hasMatch(hintText);
    bool isContact = contactMatch.hasMatch(hintText);
    bool isAddress = addressMatch.hasMatch(hintText);

    TextInputType inputType = isPass
        ? TextInputType.visiblePassword
        : isName
            ? TextInputType.name
            : isEmail
                ? TextInputType.emailAddress
                : isBirthday
                    ? TextInputType.datetime
                    : isContact
                        ? TextInputType.phone
                        : isAddress
                            ? TextInputType.multiline
                            : TextInputType.text;

    return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Material(
            elevation: 5.0,
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: defaultFormat(inputType, isPass, controller, hintText)));
  }

  Widget defaultFormat(inputType, isPass, controller, hinText) {
    return TextFormField(
      keyboardType: inputType,
      obscureText: isPass,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(52, 51, 67, 1),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(172, 76, 42, 0.612),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hintText,
      ),
    );
  }
}
