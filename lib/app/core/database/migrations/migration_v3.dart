import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';

class MigrationV3 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table todo(
        id INTEGER primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime,
        finalizado INTEGER
      )
    ''');
  }

  @override
  void update(Batch batch) {
    batch.execute('''
      create table teste3(
        id INTEGER primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime,
        finalizado INTEGER
      )
    ''');
  }
}
