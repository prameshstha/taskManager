class Tasks {
  final int? id;
  final String taskName;
  final String dueDate;
  final String time;
  final String priority;
  final int alarm;
  final String done;
  Tasks({
    required this.taskName,
    required this.dueDate,
    required this.time,
    required this.priority,
    required this.alarm,
    required this.done,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'task_id': id,
      'task_name': taskName,
      'due_date': dueDate,
      'time': time,
      'priority': priority,
      'alarm': alarm,
      'done': done,
    };
  }

  Map<String, dynamic> toDoneMap() {
    return {
      'task_id': id,
      'done': done,
    };
  }
}

class TaskDone {
  final int? id;
  final String done;
  TaskDone({
    required this.done,
    this.id,
  });

  Map<String, dynamic> toDoneMap() {
    return {
      'task_id': id,
      'done': done,
    };
  }
}
