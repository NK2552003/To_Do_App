import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoModel {
  String? docID;
  final String titleTask;
  final String description;
  final String taskDate;
  final String taskTime;
  final String Category;
  final bool isDone;
  ToDoModel(
      {required this.titleTask,
      required this.description,
      required this.taskDate,
      required this.taskTime,
      required this.Category, 
      required this.isDone,
      this.docID});

Map<String, dynamic> toMap(){
  return <String, dynamic>{
    'docID' : docID,
    'titleTask' : titleTask,
    'description' : description,
    'taskDate' : taskDate,
    'taskTime' : taskTime,
    'Category' : Category,
    'isDone' : isDone,
  };
}
factory ToDoModel.fromMap(Map<String, dynamic> map){
  return ToDoModel(
    docID:map['docID'] != null ? map['docID'] as String:null,
    titleTask: map['titleTask'] as String, 
    description: map['description'] as String,
    taskDate: map['taskDate'] as String,
    taskTime: map['taskTime'] as String,
    Category: map['Category'] as String,
    isDone: map['isDone'] as bool,
    );
}
factory ToDoModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> doc){
  return ToDoModel(
    titleTask: doc['titleTask'],
    description: doc['description'],
    taskDate: doc['taskDate'],
    taskTime: doc['taskTime'],
    Category: doc['Category'],
    isDone:  doc['isDone'],
    );
}
}