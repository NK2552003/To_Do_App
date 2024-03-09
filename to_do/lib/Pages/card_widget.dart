import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:to_do/provider/todo_service_provider.dart';

class CardWidget extends ConsumerWidget {
  const CardWidget({
    super.key,
    required this.getIndex,
  });
  final int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
        data: (todoData) {
          Color categoryColor = Colors.white;
          final getCategory = todoData[getIndex].Category;
          switch (getCategory) {
            case "Study":
              categoryColor = Colors.green;
              break;
            case "Work":
              categoryColor = Colors.blue;
              break;
            case "Other":
              categoryColor = Colors.redAccent;
              break;
          }
          return Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: IconButton(icon:Icon(Icons.delete),onPressed: () { return ref.read(serviceProvider).deleteTask(todoData[getIndex].docID);  
                          },),
                          contentPadding: EdgeInsets.zero,
                          title: Text(todoData[getIndex].titleTask,
                              maxLines: 1,
                              style: TextStyle(
                                  decoration: todoData[getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),),
                          subtitle: Text(
                            todoData[getIndex].description,
                            maxLines: 1,
                            style: TextStyle(
                                  decoration: todoData[getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                          ),
                          trailing: Transform.scale(
                            scale: 1.4,
                            child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              value: todoData[getIndex].isDone,
                              onChanged: (value) => ref
                                  .read(serviceProvider)
                                  .updateTask(todoData[getIndex].docID, value),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -10),
                          child: Container(
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 1.5,
                                  color: Colors.grey.shade300,
                                ),
                                Row(
                                  children: [
                                    Text("Today"),
                                    const Gap(12),
                                    Text(todoData[getIndex].taskTime),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text("Error")),
        loading: () => Center(
              child: CircularProgressIndicator(),
            ));
  }
}
