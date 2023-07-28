import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVn = ValueNotifier<String>('');
  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  },
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://portal1.iff.edu.br/desenvolvimento-institucional/imagens/avatar.jpg/@@images/image.jpeg';
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider, String>(
                      builder: (_, value, __) {
                        return Text(value);
                      },
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            'Não informado';
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Alterar nome'),
                    content: TextField(
                      onChanged: (value) {
                        nameVn.value = value;
                      },
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.red),
                          )),
                      TextButton(
                          onPressed: () async {
                            final nameValue = nameVn.value;
                            if (nameValue.isEmpty) {
                              Messages.of(context)
                                  .showError('Nome obrigatoprio');
                            } else {
                              Loader.show(context);
                              await context
                                  .read<UserService>()
                                  .updateDisplayName(nameValue);
                              Loader.hide();
                              Navigator.of(context).pop();

                            }
                          },
                          child: const Text('Alterar')),
                    ],
                  );
                },
              );
            },
            title: const Text('Altera nome'),
          ),
          ListTile(
            onTap: () => context.read<AuthProvider>().logout(),
            title: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
