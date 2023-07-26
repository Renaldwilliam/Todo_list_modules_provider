import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/validators/validators.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPassawordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    final defaultLiostener = DefaultListenerNotifier(
        changenotifier: context.read<RegisterController>());
    defaultLiostener.listener(
      context: context,
      successCallBack: (notifier, listenerNotifier) {
        Navigator.of(context).pop();
      },
      errorVoidCallBack: (notifier, listenerNotifier) {
        print('Deu algum erro');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 15, color: context.primaryColor),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ClipOval(
              child: Container(
                  color: context.primaryColor.withAlpha(20),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 20,
                    color: context.primaryColor,
                  )),
            )),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TodoListField(
                      label: 'E-mail',
                      controller: _emailEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("E-mail obrigatório"),
                        Validatorless.email("E-mail inválido"),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TodoListField(
                      label: 'Senha',
                      controller: _passwordEC,
                      obscureText: true,
                      validator: Validatorless.multiple([
                        Validatorless.required("Senha obrigatório"),
                        Validatorless.min(
                            6, 'Senha deve ter pelo menos 6 caracteres'),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TodoListField(
                      label: 'Confirma Senha',
                      controller: _confirmPassawordEC,
                      obscureText: true,
                      validator: Validatorless.multiple([
                        Validatorless.required("Confirma senha obrigatório"),
                        Validators.compare(
                            _passwordEC, "Senha diferente de senha"),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ))),
                        onPressed: () {
                          final finalValid =
                              _formKey.currentState?.validate() ?? false;

                          if (finalValid) {
                            final email = _emailEC.text;
                            final password = _passwordEC.text;
                            context
                                .read<RegisterController>()
                                .resgisterUser(email, password);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Salvar',
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
