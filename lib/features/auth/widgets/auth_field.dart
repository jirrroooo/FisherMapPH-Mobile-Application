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
    final civilStatus = RegExp(r'.*Civil.*');

    bool isPass = passwordMatch.hasMatch(hintText);
    bool isName = nameMatch.hasMatch(hintText);
    bool isEmail = emailMatch.hasMatch(hintText);
    bool isBirthday = birthdayMatch.hasMatch(hintText);
    bool isContact = contactMatch.hasMatch(hintText);
    bool isAddress = addressMatch.hasMatch(hintText);
    bool isCivilStatus = civilStatus.hasMatch(hintText);

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

    Icon icon = isPass
        ? Icon(Icons.vpn_key)
        : isName
            ? Icon(Icons.person)
            : isEmail
                ? Icon(Icons.email)
                : isBirthday
                    ? Icon(Icons.perm_contact_calendar)
                    : isContact
                        ? Icon(Icons.call)
                        : isAddress
                            ? Icon(Icons.location_on)
                            : isCivilStatus
                                ? Icon(Icons.assignment)
                                : Icon(Icons.directions_boat);

    return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: isPass
            ? passwordType(inputType, isPass, controller, hintText, icon)
            : defaultFormat(inputType, isPass, controller, hintText, icon));
  }

  Widget defaultFormat(inputType, isPass, controller, hinText, icon) {
    return TextFormField(
      keyboardType: inputType,
      obscureText: isPass,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        contentPadding: const EdgeInsets.all(25),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(59, 58, 69, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.498),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hintText,
      ),
    );
  }

  Widget passwordType(inputType, isPass, controller, hinText, icon) {
    bool _isHide = true;

    return TextFormField(
      keyboardType: inputType,
      obscureText: _isHide,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () => {_isHide = !_isHide}),
        contentPadding: const EdgeInsets.all(25),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(59, 58, 69, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.498),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hintText,
      ),
    );
  }
}
