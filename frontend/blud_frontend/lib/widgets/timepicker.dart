import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerTextField extends StatefulWidget {
  const TimePickerTextField({super.key});

  @override
  State<TimePickerTextField> createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {
  TimeOfDay? _selectedTime;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text ='';
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
        labelText: 'Select Due Time',
        labelStyle: TextStyle(color: Color(0xFF700606)),
        filled: true,
        fillColor: Color(0xFFFFE3E3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
        suffixIcon: Icon(Icons.access_time),

      ),
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light().copyWith(
                  primary: Color(0xFFFF4040)
                )
              ),
              child: child!,
            );
          }
        );
        if(picked!=null) {
          setState(() {
            _selectedTime = picked;
            String formattedTime = DateFormat('hh:mm a').format(DateTime(picked.hour, picked.minute));
            int hour = _selectedTime!.hour;
            _textEditingController.text = '${hour.toString().padLeft(2, '0')}00';
          });
        }
      },
    );
  }
}
