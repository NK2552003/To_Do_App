import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/model/todo_model.dart';

class ToDoService{
  final todoCollection = FirebaseFirestore.instance.collection('ToDo_App');

  //Creating the new task
  void addNewTask(ToDoModel model){
    todoCollection.add(model.toMap());
  }

  //updating the radio button and tasks
  void updateTask(String? docID,bool? valueUpdate){
    todoCollection.doc(docID).update({
      'isDone' :valueUpdate, 
    });
  }
  void deleteTask(String? docID){
    todoCollection.doc(docID).delete();
  }
}