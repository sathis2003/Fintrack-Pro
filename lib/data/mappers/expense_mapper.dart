import 'package:drift/drift.dart';
import '../../domain/entities/expense.dart';
import '../local/database/app_database.dart' as db;
import '../../domain/entities/extracted_expense.dart';

class ExpenseMapper {
  // Drift Row → Domain Entity
  static Expense fromRow(db.ExpenseData row) => Expense(
        id: row.id,
        uuid: row.uuid,
        userId: row.userId,
        amount: row.amount,
        category: row.category,
        description: row.description,
        date: DateTime.fromMillisecondsSinceEpoch(row.date),
        isRecurring: row.isRecurring,
        source: row.source,
        syncStatus: row.syncStatus,
        createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
        isDeleted: row.isDeleted,
      );

  // Domain Entity → Drift Companion (for insert/update)
  static db.ExpensesCompanion toCompanion(Expense e) => db.ExpensesCompanion(
        id: e.id != null ? Value(e.id!) : const Value.absent(),
        uuid: Value(e.uuid),
        userId: Value(e.userId),
        amount: Value(e.amount),
        category: Value(e.category),
        description: Value(e.description),
        date: Value(e.date.millisecondsSinceEpoch),
        isRecurring: Value(e.isRecurring),
        source: Value(e.source),
        syncStatus: Value(e.syncStatus),
        createdAt: Value(e.createdAt.millisecondsSinceEpoch),
        updatedAt: Value(e.updatedAt.millisecondsSinceEpoch),
        isDeleted: Value(e.isDeleted),
      );

  // Domain Entity → Supabase JSON Map
  static Map<String, dynamic> toSupabaseMap(Expense e) => {
        'uuid': e.uuid,
        'user_id': e.userId,
        'amount': e.amount,
        'category': e.category,
        'description': e.description,
        'date': e.date.millisecondsSinceEpoch,
        'is_recurring': e.isRecurring,
        'source': e.source,
        'is_deleted': e.isDeleted,
        'created_at': e.createdAt.millisecondsSinceEpoch,
        'updated_at': e.updatedAt.millisecondsSinceEpoch,
      };

  // ExtractedExpense + userId → Domain Expense
  static Expense fromExtracted(
    ExtractedExpense extracted,
    String userId,
    String uuid,
  ) {
    final now = DateTime.now();
    final date = _parseDate(extracted.date);
    return Expense(
      uuid: uuid,
      userId: userId,
      amount: extracted.amount,
      category: extracted.category,
      description: extracted.description,
      date: date,
      isRecurring: extracted.isRecurring,
      source: 'chat',
      syncStatus: 'pending',
      createdAt: now,
      updatedAt: now,
    );
  }

  static DateTime _parseDate(String dateStr) {
    final today = DateTime.now();
    if (dateStr == 'today') return today;
    if (dateStr == 'yesterday') {
      return today.subtract(const Duration(days: 1));
    }
    try {
      final parts = dateStr.split('-');
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (_) {
      return today;
    }
  }
}

extension ExpenseRowToDomain on db.ExpenseData {
  Expense toDomain() => ExpenseMapper.fromRow(this);
}
