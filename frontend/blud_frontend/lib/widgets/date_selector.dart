// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/material.dart';
// import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';

class DateofBirthTextField extends StatefulWidget {
  DateofBirthTextField(
      {super.key,
      required this.textEditingController,
      required this.displaytext});
  TextEditingController textEditingController = TextEditingController();
  String displaytext;

  @override
  State<DateofBirthTextField> createState() => _DateofBirthTextFieldState();
}

class _DateofBirthTextFieldState extends State<DateofBirthTextField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    widget.textEditingController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.displaytext,
        labelStyle: const TextStyle(color: Color(0xff700606)),
        filled: true,
        fillColor: const Color(0xFFFFE3E3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff700606))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff700606))),
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light()
                        .copyWith(primary: const Color(0xFFFF4040))),
                child: child!,
              );
            });

        if (picked != null) {
          setState(() {
            _selectedDate = picked;
            widget.textEditingController.text =
                DateFormat('yyyy-MM-dd').format(picked);
          });
        }
      },
    );
  }
}
