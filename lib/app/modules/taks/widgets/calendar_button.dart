import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/taks/taks_create_controller.dart';

class CalendarButton extends StatelessWidget {
  CalendarButton({super.key});

  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(const Duration(days: 15 * 365));

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lastDate,
        );

         context.read<TaksCreateController>().selectedDate = selectedDate;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Selector<TaksCreateController, DateTime?>(
              selector: (context, controller) {
                return controller.selectDate;
              },
              builder: (_, selectDate, __) {
                if (selectDate != null) {
                  return Text(
                    dateFormat.format(selectDate),
                    style: context.titleStyle,
                  );
                } else {
                  return const Text('Selecione uma data');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
