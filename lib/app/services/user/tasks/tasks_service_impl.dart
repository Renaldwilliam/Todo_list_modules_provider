import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/repositories/user/tasks/tasks_repository.dart';

import '../../../models/week_task_model.dart';
import './tasks_service.dart';

class TasksServiceImpl extends TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _tasksRepository.findyPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrpwData = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findyPeriod(tomorrpwData, tomorrpwData);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(
      today.year,
      today.month,
      today.day,
      0,
      0,
    );
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }

    endFilter = startFilter.add(const Duration(days: 7));
    final tasks = await _tasksRepository.findyPeriod(startFilter, endFilter);

    return WeekTaskModel(
      startDate: startFilter,
      endData: endFilter,
      taks: tasks,
    );
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel taskModel) =>
      _tasksRepository.checkOrUncheckTask(taskModel);
}
