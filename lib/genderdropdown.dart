import 'package:flutter/material.dart';

const List<String> list = <String>['Male', 'Female'];

class GenderDropDown extends StatefulWidget {
  const GenderDropDown({super.key});

  @override
  State<GenderDropDown> createState() => _GenderDropDownMenu();
}

class _GenderDropDownMenu extends State<GenderDropDown> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
