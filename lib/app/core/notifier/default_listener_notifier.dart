import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier changenotifier;

  DefaultListenerNotifier({
    required this.changenotifier,
  });

  void listener(
      {required BuildContext context,
      SuccessVoidCallBack? successCallBack,
      ErrorVoidCallBack? errorVoidCallBack}) {
    changenotifier.addListener(() {
      if (changenotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changenotifier.hasError) {
        if (errorVoidCallBack != null) {
          errorVoidCallBack(changenotifier, this);
        }
        Messages.of(context).showError(changenotifier.error ?? "Erro interno");
      } else if (changenotifier.isSuccess) {
        if (successCallBack != null) {
          successCallBack(changenotifier, this);
        }
      }
    });
  }
}

typedef SuccessVoidCallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);

typedef ErrorVoidCallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);
