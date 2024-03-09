import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Pages/date_time.dart';
import 'package:to_do/Pages/font_bold.dart';
import 'package:to_do/Pages/modified_button.dart';
import 'package:to_do/Pages/text_field.dart';
import 'package:to_do/model/todo_model.dart';
import 'package:to_do/provider/date_time_provider.dart';
import 'package:to_do/provider/radio_provider.dart';
import 'package:to_do/provider/todo_service_provider.dart';

class NewTask extends ConsumerWidget {
  NewTask({super.key});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date_Provider = ref.watch(dateProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.all(28),
        height: MediaQuery.of(context).size.height * 0.70,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text("New Task ToDo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey.shade300,
            ),
            const Gap(12),
            const Text(
              'Title Task',
              style: AppStyle.headingOne,
            ),
            const Gap(6),
            TextFieldWidget(
              fNode: titleFocusNode,
              hintText: "Add Task Here",
              maxLine: 1,
              txtController: titleController,
            ),
            const Gap(12),
            const Text(
              "Description",
              style: AppStyle.headingOne,
            ),
            const Gap(6),
            TextFieldWidget(
              fNode: descriptionFocusNode,
              hintText: "Add Description Here ",
              maxLine: 4,
              txtController: descriptionController,
            ),
            const Gap(12),
            const Text("Category", style: AppStyle.headingOne),
            const Gap(6),
            Row(
              children: [
                Expanded(
                  child: ModifiedRadioButton(
                    title: "Work",
                    categoryColor: Colors.green,
                    val: 1,
                    onChangeValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 1),
                  ),
                ),
                Expanded(
                  child: ModifiedRadioButton(
                    title: "Study",
                    categoryColor: Colors.blue.shade600,
                    val: 2,
                    onChangeValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 2),
                  ),
                ),
                Expanded(
                  child: ModifiedRadioButton(
                    title: "Other",
                    categoryColor: Colors.red,
                    val: 3,
                    onChangeValue: () =>
                        ref.read(radioProvider.notifier).update((state) => 3),
                  ),
                ),
              ],
            ),
      
            //Date and Time Section Here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DateTimeWidget(
                  txt: "Date",
                  icon: Icons.calendar_month,
                  valuetxt: date_Provider,
                  onTap: () async {
                    final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2026),
                    );
                    if (getValue != null) {
                      final _format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => _format.format(getValue));
                    }
                  },
                ),
                const Gap(20),
                DateTimeWidget(
                  txt: "Time",
                  icon: Icons.timer,
                  valuetxt: ref.watch(timeProvider),
                  onTap: () async {
                    final getTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (getTime != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => getTime.format(context));
                    }
                  },
                ),
              ],
            ),
            const Gap(20),
            //Button Section Here
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade700,
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: Colors.blue.shade700),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("Cancel"),
                )),
                const Gap(20),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    final getRadioValue = ref.read(radioProvider);
                    String categry = '';
                    switch (getRadioValue) {
                      case 1:
                        categry = 'Work';
                        break;
                      case 2:
                        categry = 'Study';
                        break;
                      case 3:
                        categry = 'Other';
                        break;
                    }
                    ref.read(serviceProvider).addNewTask(ToDoModel(
                        titleTask: titleController.text,
                        description: descriptionController.text,
                        taskDate: ref.read(dateProvider),
                        taskTime: ref.read(timeProvider),
                        Category: categry,
                        isDone: false,
                        ));
                    print("Data is Saving");
                    titleController.clear();
                    descriptionController.clear();
                    ref.read(radioProvider.notifier).update((state) => 0);
                    Navigator.pop(context); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("Create"),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
