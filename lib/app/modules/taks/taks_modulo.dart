import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/taks/taks_create_controller.dart';
import 'package:todo_list_provider/app/modules/taks/task_create_task_page.dart';
import 'package:todo_list_provider/app/repositories/user/tasks/tasks_repository.dart';
import 'package:todo_list_provider/app/repositories/user/tasks/tasks_repository_impl.dart';
import 'package:todo_list_provider/app/services/user/tasks/tasks_service.dart';
import 'package:todo_list_provider/app/services/user/tasks/tasks_service_impl.dart';

class TaksModulo extends TodoListModule {
  TaksModulo()
      : super(bindings: [
          Provider<TasksRepository>(
            create: (context) => TasksRepositoryImpl(
              sqliteConnectionFactory: context.read(),
            ),
          ),
          Provider<TasksService>(
            create: (context) => TasksServiceImpl(
              tasksRepository: context.read(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => TaksCreateController(
              tasksService: context.read(),
            ),
          ),
        ], routers: {
          '/task/create': (context) =>
              TaskCreateTaskPage(controller: context.read()),
        });
}
