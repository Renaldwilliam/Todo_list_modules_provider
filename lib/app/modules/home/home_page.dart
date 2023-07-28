import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/wisgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/wisgets/home_filters.dart';
import 'package:todo_list_provider/app/modules/home/wisgets/home_header.dart';
import 'package:todo_list_provider/app/modules/home/wisgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/wisgets/home_week.dart';
import 'package:todo_list_provider/app/modules/taks/taks_modulo.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeController;
  const HomePage({Key? key, required HomeController homeController})
      : _homeController = homeController,
        super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changenotifier: widget._homeController).listener(
      context: context,
      successCallBack: (notifier, listenerNotifier) {},
    );

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget._homeController.loadTotalTasks();
      widget._homeController.findTasks(filter: TaskFilterEnum.today);
    });
  }

  Future<void> _goToCreateTask(BuildContext context) async {
    // Navigator.of(context).pushNamed('/task/create');
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(microseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TaksModulo().getPage('/task/create', context);
        },
      ),
    );

    widget._homeController.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: context.primaryColor),
          backgroundColor: const Color(0xFFFAFBFE),
          elevation: 0,
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                widget._homeController.showOrHideFinishisTaska();
              },
              icon: const Icon(
                TodoListIcons.filter,
              ),
              itemBuilder: (_) => [
                PopupMenuItem<bool>(
                  value: true,
                  child: Text('${widget._homeController.showFinishingTasks ? 'Mostrar' : 'Escondet'} tarefas concluidas'),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.primaryColor,
          onPressed: () {
            _goToCreateTask(context);
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: const Color(0xFFFAFBFE),
        drawer: HomeDrawer(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(),
                        HomeFilters(),
                        HomeWeek(),
                        HomeTasks(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
