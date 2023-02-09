class Todo {
  int id;
  DateTime date;
  int done;
  String data;

  Todo({
    required this.id,
    required this.date,
    required this.done,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'year': date.year,
      'month': date.month,
      'day': date.day,
      'done': done,
      'data': data,
    };
  }
}
