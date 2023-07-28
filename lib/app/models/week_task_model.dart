import 'package:todo_list_provider/app/models/task_model.dart';

class WeekTaskModel {
  final DateTime startDate;
  final DateTime endData;
  final List<TaskModel> taks;
  WeekTaskModel({
    required this.startDate,
    required this.endData,
    required this.taks,
  });
}
