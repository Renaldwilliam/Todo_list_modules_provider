import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/modules/taks/taks_create_controller.dart';
import 'package:todo_list_provider/app/modules/taks/widgets/calendar_button.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreateTaskPage extends StatefulWidget {
  final TaksCreateController _controller;

  TaskCreateTaskPage({Key? key, required TaksCreateController controller})
      : _controller = controller,
        super(key: key);

  @override
  State<TaskCreateTaskPage> createState() => _TaskCreateTaskPageState();
}

class _TaskCreateTaskPageState extends State<TaskCreateTaskPage> {
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(
      changenotifier: widget._controller,
    ).listener(
      context: context,
      successCallBack: (notifier, listenerNotifier) {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: context.primaryColor,
          onPressed: () {
            final formValid = _formKey.currentState?.validate() ?? false;
            if (formValid) {
              widget._controller.save(_descriptionEC.text);
            }
          },
          label: const Text(
            'Salvar Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close, color: Colors.black),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Criar Atividade',
                  style: context.titleStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              TodoListField(
                label: '',
                controller: _descriptionEC,
                validator: Validatorless.required('Descrição obrigatoria'),
              ),
              const SizedBox(height: 20),
              CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}
