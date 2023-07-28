import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/user/tasks/tasks_service.dart';

class TaksCreateController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TaksCreateController({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      if (_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da task não selecionada');
      }
    } on Exception catch (e, s) {
      hideLoading();
      print(e);
      print(s);
      setError('Erro ao salvar');
    }finally{
      hideLoading();
    }
  }
}
