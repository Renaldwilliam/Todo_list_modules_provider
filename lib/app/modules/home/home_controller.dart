import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/modules/home/wisgets/task.dart';
import 'package:todo_list_provider/app/services/user/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;

  HomeController({required TasksService tasksService})
      : _tasksService = tasksService;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksModel? toDayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> alltasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? inialDateOfWeel;
  DateTime? seletectDate;
  bool showFinishingTasks = true;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek()
    ]);

    final toDayTasks = allTasks[0] as List<TaskModel>;
    final toTomorrowTasks = allTasks[1] as List<TaskModel>;
    final toweekTasks = allTasks[2] as WeekTaskModel;

    toDayTotalTasks = TotalTasksModel(
      totalTasks: toDayTasks.length,
      totalTasksFinish: toDayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: toTomorrowTasks.length,
      totalTasksFinish: toTomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTasks = TotalTasksModel(
      totalTasks: toweekTasks.taks.length,
      totalTasksFinish: toweekTasks.taks.where((task) => task.finished).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks = [];

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();
        inialDateOfWeel = weekModel.startDate;
        tasks = weekModel.taks;
        break;
      default:
    }

    filteredTasks = tasks;
    alltasks = tasks;

    if (filteredTasks == TaskFilterEnum.week) {
      if (seletectDate != null) {
        filterByDay(seletectDate!);
      }
      if (inialDateOfWeel != null) {
        filterByDay(inialDateOfWeel!);
      }
    } else {
      seletectDate = null;
    }

    if (!showFinishingTasks) {
      filteredTasks = filteredTasks.where((task) => task.finished).toList();
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    seletectDate = date;
    filteredTasks = alltasks
        .where((task) => DateUtils.isSameDay(task.dateTime, date))
        .toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();
    final taskUpdate = task.copyWith(finished: !task.finished);
    await _tasksService.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishisTaska() {
    showFinishingTasks = !showFinishingTasks;
    refreshPage();
  }
}
