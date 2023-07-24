import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table teste2(
        id Interger primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime,
        finalizado integer,
      )
    ''');
  }

  @override
  void update(Batch batch) {
    batch.execute('''
      create table teste2(
        id Interger primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime,
        finalizado integer,
      )
    ''');
  }
}
