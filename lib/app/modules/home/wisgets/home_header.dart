import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Selector<AuthProvider, String>(
          builder: (_, value, __) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'E ai, $value!',
                style: context.textTheme.headline5
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            );
          },
          selector: (context, authProvider) =>
              authProvider.user?.displayName ?? 'Não informado',
        ),
        
      ],
    );
  }
}
