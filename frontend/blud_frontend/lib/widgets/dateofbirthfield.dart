import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';

class DateofBirthTextField extends StatefulWidget {
  const DateofBirthTextField({super.key});

  @override
  State<DateofBirthTextField> createState() => _DateofBirthTextFieldState();
}

class _DateofBirthTextFieldState extends State<DateofBirthTextField> {
  DateTime? _selectedDate;
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.text = '';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        labelStyle: TextStyle(color: Color(0xFF700606)),
        filled: true,
        fillColor: const Color(0xFFFFE3E3),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF700606)),
          borderRadius: BorderRadius.circular(8.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
          borderSide: BorderSide(color: Color(0xFF700606))
        )
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
                colorScheme: ColorScheme.light().copyWith(primary: Color(0xFFFF4040))
              ),
              child: child!,
            );
          }
        );
        if(picked!=null) {
          setState(() {
            _selectedDate = picked;
            _textEditingController.text = DateFormat('yyyy-MM-dd').format(picked);
          });
        }
      },

    );
  }
}
