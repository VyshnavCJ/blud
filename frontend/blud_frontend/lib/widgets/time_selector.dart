import 'package:flutter/material.dart';

class TimePickerTextField extends StatefulWidget {
  const TimePickerTextField({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  State<TimePickerTextField> createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    widget.textEditingController.text = '';
  }

  @override
  void dispose() {
    widget.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Select Due Time',
        labelStyle: const TextStyle(color: Color(0xFF700606)),
        filled: true,
        fillColor: const Color(0xFFFFE3E3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff700606))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff700606))),
        suffixIcon: const Icon(
          Icons.access_time,
          color: Color(0xff700606),
        ),
      ),
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
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
            _selectedTime = picked;
            // String formattedTime = DateFormat('hh:mm a')
            //     .format(DateTime(picked.hour, picked.minute));

            int hour = _selectedTime!.hour;
            int minute = _selectedTime!.minute;
            widget.textEditingController.text =
                '${hour.toString().padLeft(2, '0')}${minute.toString()}';
            print(widget.textEditingController.text);
          });
        }
      },
    );
  }
}
