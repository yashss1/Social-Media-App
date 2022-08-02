import 'package:flutter/material.dart';
import 'constants.dart';

textfieldNumber2(
    {required String hint_text,
    required TextEditingController controller,
    double size = 20}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 10),
    child: TextField(
      cursorColor: Colors.white,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        contentPadding: EdgeInsets.all(20),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0.001),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0.001),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0.001),
        ),
        hintText: hint_text,
        hintStyle: myStyle(size, "Syne", color: Colors.grey),
      ),
      keyboardType: TextInputType.number,
      style: myStyle(size, "Syne", color: Colors.black),
      controller: controller,
    ),
  );
}

TextField textfield(
    {required String hint_text,
    required controller,
    double size = 20,
    TextAlign textALign = TextAlign.start}) {
  return TextField(
    textAlign: textALign,
    textCapitalization: hint_text == 'XXXX-XXXX-XXXX-XXXX'
        ? TextCapitalization.characters
        : TextCapitalization.none,
    cursorColor: Colors.white,
    onChanged: (val) {},
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(20),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      hintText: hint_text,
      hintStyle: myStyle(size, "Syne", color: Colors.grey),
    ),
    keyboardType: TextInputType.text,
    style: myStyle(size, "Syne", color: Colors.white),
    controller: controller,
  );
}

TextField textfield2(
    {required String hint_text,
    required controller,
    double size = 20,
    TextAlign textALign = TextAlign.start}) {
  return TextField(
    textAlign: textALign,
    textCapitalization: hint_text == 'XXXX-XXXX-XXXX-XXXX'
        ? TextCapitalization.characters
        : TextCapitalization.none,
    cursorColor: Colors.white,
    onChanged: (val) {},
    decoration: InputDecoration(
      fillColor: Colors.grey.shade100,
      filled: true,
      contentPadding: EdgeInsets.all(20),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.transparent, width: 5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.transparent, width: 5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.transparent, width: 5.0),
      ),
      hintText: hint_text,
      hintStyle: myStyle(size, "Syne", color: Colors.grey),
    ),
    keyboardType: TextInputType.text,
    style: myStyle(size, "Syne", color: Colors.white),
    controller: controller,
  );
}

textfieldSmall(
    {required String hint_text,
    required TextEditingController controller,
    double size = 20}) {
  return Padding(
    padding: EdgeInsets.only(top: 8, bottom: 10),
    child: TextField(
      cursorColor: Colors.white,
      onChanged: (val) {},
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        contentPadding: EdgeInsets.all(20),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0.001),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0.001),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0.001),
        ),
        hintText: hint_text,
        hintStyle: myStyle(size, "Syne", color: Colors.grey),
      ),
      keyboardType: TextInputType.text,
      style: myStyle(size, "Syne", color: Colors.black),
      controller: controller,
    ),
  );
}

textfieldSmaller(
    {required String hint_text,
    required TextEditingController controller,
    double size = 20}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 10),
    child: TextField(
      cursorColor: Colors.white,
      onChanged: (val) {},
      // maxLength: 3,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        contentPadding: EdgeInsets.all(20),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0.001),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0.001),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent, width: 0.001),
        ),
        hintText: hint_text,
        hintStyle: myStyle(size, "Syne", color: Colors.grey),
      ),
      keyboardType: TextInputType.text,
      style: myStyle(size, "Syne", color: Colors.black),
      controller: controller,
    ),
  );
}

TextField textfieldLarge(
    {required String hint_text,
    required TextEditingController controller,
    double size = 20}) {
  return TextField(
    maxLines: 10,
    cursorColor: Colors.white,
    onChanged: (val) {},
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(20),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.transparent, width: 0.001),
      ),
      hintText: hint_text,
      hintStyle: myStyle(size, "Syne", color: Colors.grey, fw: FontWeight.w600),
    ),
    keyboardType: TextInputType.text,
    style: myStyle(size, "Syne", color: Colors.black),
    controller: controller,
  );
}

ElevatedButton button({
  required void Function()? onPressed,
  required Widget? child,
}) {
  return ElevatedButton(
    child: child,
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        primary: pink,
        onPrimary: Colors.white,
        textStyle: TextStyle(
          fontFamily: "Syne",
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 22,
        ),
        fixedSize: Size(370, 67),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
  );
}
