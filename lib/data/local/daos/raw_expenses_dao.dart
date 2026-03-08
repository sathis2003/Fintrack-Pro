import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import '../database/app_database.dart';
import '../tables/raw_expenses_table.dart';

part 'raw_expenses_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [RawExpenses])
class RawExpensesDao extends DatabaseAccessor<AppDatabase>
    with _$RawExpensesDaoMixin {
  RawExpensesDao(AppDatabase db) : super(db);

  Future<int> insertRaw(RawExpensesCompanion entry) =>
      into(rawExpenses).insert(entry);

  Future<List<RawExpenseData>> getAllPending(String userId) =>
      (select(rawExpenses)..where((t) => t.userId.equals(userId))).get();

  Future<void> deleteRaw(int id) =>
      (delete(rawExpenses)..where((t) => t.id.equals(id))).go();
}
