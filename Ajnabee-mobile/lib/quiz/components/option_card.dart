import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {

  final String optionText;
  final Function selectedOptionCallback;
  final int radioButtonValue;
  final int groupValue;

  const OptionCard({this.optionText, this.selectedOptionCallback, this.radioButtonValue, this.groupValue});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          optionText,
          style: TextStyle(
            color: Color(0xff524e4d),
          ),
        ),
        trailing: Radio(value: radioButtonValue, groupValue: groupValue, onChanged: selectedOptionCallback,activeColor: Color(0xffffc629),),
      ),
    );
  }
}
