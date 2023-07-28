import 'package:intl/intl.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

import './tasks_repository.dart';

class TasksRepositoryImpl extends TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final coon = await _sqliteConnectionFactory.openConnection();
    // DateTime formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date) as DateTime;
    
    coon.insert('todo', {
      'descricao': description,
      'data_hora': null,
      'finalizado': 0,
    });
  }
}
