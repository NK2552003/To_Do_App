import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:to_do/Pages/card_widget.dart';
import 'package:to_do/Pages/new_task.dart';
import 'package:to_do/provider/todo_service_provider.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 245, 185, 185),
            radius: 22,
            child: Image.asset('assets/profile_pic.png'),
          ),
          title: Text(
            'Hello I\'m',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          subtitle: const Text(
            "Nitish Kumar",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today\'s Task",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text("Friday, 8 March",
                          style: TextStyle(color: Colors.grey.shade700)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD5E8FA),
                        foregroundColor: Colors.blue.shade800,
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      context: context,
                      builder: (context) => NewTask(),
                    ),
                    child: const Text("+ New Task"),
                  ),
                ],
              ),
              const Gap(12),
              //List of task Shown here
              ListView.builder(
                  itemCount:todoData.value?.length??0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      CardWidget(getIndex: index,)),
            ],
          ),
        ),
      ),
    );
  }
}
