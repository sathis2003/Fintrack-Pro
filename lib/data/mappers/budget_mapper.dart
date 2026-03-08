import 'package:drift/drift.dart';
import '../../domain/entities/budget.dart';
import '../local/database/app_database.dart';

class BudgetMapper {
  static Budget fromRow(BudgetData row) {
    return Budget(
      id: row.id,
      uuid: row.uuid,
      userId: row.userId,
      category: row.category,
      amount: row.amount,
      month: row.month.toString(), // Store as integer in DB for efficiency?
      // User said "YYYY-MM" format which is text, but table had IntColumn.
      // Let's check table again.
      syncStatus: row.syncStatus,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
    );
  }

  static BudgetsCompanion toCompanion(Budget entity) {
    return BudgetsCompanion(
      uuid: Value(entity.uuid),
      userId: Value(entity.userId),
      category: Value(entity.category),
      amount: Value(entity.amount),
      month: Value(int.parse(entity.month.replaceAll('-', ''))),
      // Converting "2025-04" to 202504
      syncStatus: Value(entity.syncStatus),
      updatedAt: Value(entity.updatedAt.millisecondsSinceEpoch),
    );
  }

  static Map<String, dynamic> toSupabaseMap(Budget entity) {
    return {
      'uuid': entity.uuid,
      'user_id': entity.userId,
      'category': entity.category,
      'amount': entity.amount,
      'month': entity.month,
      'updated_at': entity.updatedAt.toIso8601String(),
    };
  }
}
