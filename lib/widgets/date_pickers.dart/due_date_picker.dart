import 'package:hanouty/local_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components.dart';

class SelectDueDate extends ConsumerWidget {
  const SelectDueDate({Key? key}) : super(key: key);

  void selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: ref.read(pickedDueDateTime.state).state,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
      // initialEntryMode: DatePickerEntryMode.input,
    ))!;
    if (picked != DateTime.now()) {
      ref.read(pickedDueDateTime.state).state = picked;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final pickedDate = ref.watch(pickedDueDateTime);
    return SizedBox(
        width: 140,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: const [],
          ),
          child: Row(
            children: [
              SizedBox(
                height: 45,
                width: 45,
                child: IconButton(
                  onPressed: () {
                    selectDate(context, ref);
                  },
                  icon: const Icon(
                    CupertinoIcons.calendar,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Text(
                  pickedDate.ddmmyyyy(),
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ),
            ],
          ),
        ));
  }
}
