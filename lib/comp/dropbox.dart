import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class Dropbox extends StatefulWidget {
  final list;
  final TextEditingController inputController;

  const Dropbox(this.list, this.inputController);

  @override
  State<Dropbox> createState() => _Dropbox();
}

/// This is the private State class that goes with MyStatefulWidget.
class _Dropbox extends State<Dropbox> {
  String dropdownValue = '0';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.inputController.text,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          widget.inputController.text = newValue!;
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
