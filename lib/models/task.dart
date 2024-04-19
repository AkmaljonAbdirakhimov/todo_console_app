import 'dart:convert';

abstract class Task {
  int id;
  String title;
  DateTime date;
  bool isComplete;

  Task({
    required this.id,
    required this.title,
    required this.date,
    this.isComplete = false,
  });

  void display();
  void toJson();
}

class OneTimeTask extends Task {
  int id;
  String title;
  DateTime date;
  bool isComplete;

  OneTimeTask({
    required this.id,
    required this.title,
    required this.date,
    this.isComplete = false,
  }) : super(
          id: id,
          title: title,
          date: date,
          isComplete: isComplete,
        );

  @override
  void display() {
    print("""
ID: $id
Vazifa: $title
Kuni: $date
Statusi: ${isComplete ? "Bajarilgan" : "Bajarilmagan"}
""");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "date": date.toIso8601String(),
      "isComplete": isComplete,
    };
  }

  factory OneTimeTask.fromJson(Map<String, dynamic> mapData) {
    OneTimeTask oneTimeTask = OneTimeTask(
      id: mapData['id'],
      title: mapData['title'],
      date: DateTime.parse(mapData['date']),
      isComplete: mapData['isComplete'],
    );

    return oneTimeTask;
  }
}
