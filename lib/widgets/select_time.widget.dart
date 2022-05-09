import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectTimeWidget extends StatelessWidget {
  DateTime? time;
  String? label;
  Function? selectedTime;
  String? field;
  bool onlyDate;
  SelectTimeWidget(
      {this.label,
      this.time,
      this.selectedTime,
      this.field,
      this.onlyDate = false});
  @override
  Widget build(BuildContext context) {
    var _time = ValueNotifier<DateTime?>(time);
    return ValueListenableBuilder<DateTime?>(
        valueListenable: _time,
        builder: (_context, value, _widget) {
          var controller = TextEditingController(text: value.toString());
          return Container(
            height: 45,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            child: DateTimePicker(
                type: onlyDate
                    ? DateTimePickerType.date
                    : DateTimePickerType.dateTime,
                dateMask: onlyDate ? 'dd/MM/yyyy' : 'dd/MM/yyyy HH:mm',
                controller: controller,
                firstDate: DateTime(1959),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event, color: Colors.grey),
                dateLabelText: label,
                timeLabelText: 'Giờ',
                selectableDayPredicate: (date) {
                  return true;
                },
                
                style: TextStyle(height: 0.8, fontSize: 14),
                decoration: InputDecoration(
                    hintText: label,
                    icon: Icon(Icons.event, color: Colors.grey, size: 20),
                    border: InputBorder.none),
                onChanged: (val) {
                  _time.value = DateTime.parse(val.toString());
                  selectedTime!(_time.value, field);
                }),
          );
        });
  }
}
