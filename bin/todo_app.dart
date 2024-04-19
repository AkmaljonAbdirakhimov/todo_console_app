import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:todo_app/models/task.dart';

void main(List<String> arguments) async {
  File file = File("database/todos.json");

  // OneTimeTask oneTimeTask = OneTimeTask(
  //   id: 2,
  //   title: "hello",
  //   date: DateTime.now(),
  // );
  // // String jsonTask = jsonEncode();
  // List<Map<String, dynamic>> list = [
  //   oneTimeTask.toJson(),
  //   oneTimeTask.toJson()
  // ];
  // await file.writeAsString(jsonEncode(list));

  String todosText = await file.readAsString();
  List<dynamic> todos = jsonDecode(todosText);
  List<Map<String, dynamic>> todos2 = todos.cast<Map<String, dynamic>>();
  print(todos2);

  List<OneTimeTask> tasks = [];
  todos2.forEach((todo) {
    tasks.add(OneTimeTask.fromJson(todo));
  });
  print("");
  // tasks.forEach((element) {
  //   element.display();
  // });

  // remind(tasks[0]);

  ReceivePort receivePort = ReceivePort();

  await Isolate.spawn(remind, [tasks, receivePort.sendPort]);

  receivePort.listen((message) {
    print(message);

    // receivePort.close();
  });
}

void remind(List messages) {
  List<Task> tasks = messages[0];
  SendPort sendPort = messages[1];

  tasks.forEach((task) {
    Duration waitSeconds = task.date.difference(DateTime.now());
    Future.delayed(waitSeconds, () {
      sendPort.send(
        "Bolajon sen mana bu ishni (${task.title}) tezroq bajarashing kerak!",
      );
    });
  });
}
