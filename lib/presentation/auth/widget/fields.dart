import 'package:flutter/material.dart';
import 'package:sunrule/presentation/auth/login_screen.dart';

Padding fields(
    {required String hint,
    required IconData ic,
    required TextEditingController cntr,
    bool isPsw = false,
    bool isMobile = false,
    void Function()? onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextFormField(
      controller: cntr,
      keyboardType: isMobile ? TextInputType.number : null,
      cursorColor: Colors.cyan,
      obscureText: isSHow.value ? true : false,
      validator: (value) {
        if (value!.isEmpty) {
          return "*required";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
        hintText: hint,
        suffixIcon: isPsw
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(
                  isSHow.value ? Icons.lock : Icons.lock_open,
                  color: Colors.grey,
                ),
              )
            : null,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        icon: Icon(
          ic,
          color: Colors.grey,
          size: 20,
        ),
      ),
    ),
  );
}
