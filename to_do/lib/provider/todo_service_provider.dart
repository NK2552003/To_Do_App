import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/model/todo_model.dart';
import 'package:to_do/services/todo_service.dart';

final serviceProvider = StateProvider<ToDoService>((ref) {
  return ToDoService();
});

final fetchStreamProvider = StreamProvider<List<ToDoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('todoApp')
      .snapshots()
      .map((event) => event.docs.map((snapshot) => ToDoModel.fromSnapshot(snapshot)).toList()); 
  yield* getData;
});
