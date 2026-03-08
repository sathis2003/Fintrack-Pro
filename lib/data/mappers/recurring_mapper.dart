import 'package:drift/drift.dart';
import '../../domain/entities/recurring_expense.dart';
import '../local/database/app_database.dart' as db;

class RecurringMapper {
  static RecurringExpense fromRow(db.RecurringExpensesTableData row) {
    return RecurringExpense(
      uuid: row.uuid,
      userId: row.userId,
      category: row.category,
      description: row.description,
      averageAmount: row.averageAmount,
      dayOfMonth: row.dayOfMonth,
      frequency: row.frequency,
      isActive: row.isActive,
      reminderEnabled: row.reminderEnabled,
      reminderDaysBefore: row.reminderDaysBefore,
      lastOccurrence: DateTime.parse(row.lastOccurrence),
      nextExpectedDate: DateTime.parse(row.nextExpectedDate),
    );
  }

  static db.RecurringExpensesTableCompanion toCompanion(
    RecurringExpense entity,
    String userId,
  ) {
    return db.RecurringExpensesTableCompanion(
      uuid: Value(entity.uuid),
      userId: Value(userId),
      category: Value(entity.category),
      description: Value(entity.description),
      averageAmount: Value(entity.averageAmount),
      dayOfMonth: Value(entity.dayOfMonth),
      frequency: Value(entity.frequency),
      isActive: Value(entity.isActive),
      reminderEnabled: Value(entity.reminderEnabled),
      reminderDaysBefore: Value(entity.reminderDaysBefore),
      lastOccurrence: Value(entity.lastOccurrence.toIso8601String()),
      nextExpectedDate: Value(entity.nextExpectedDate.toIso8601String()),
    );
  }
}

extension RecurringDomainToCompanion on RecurringExpense {
  db.RecurringExpensesTableCompanion toCompanion(String userId) {
    return RecurringMapper.toCompanion(this, userId);
  }
}

extension RecurringRowToDomain on db.RecurringExpensesTableData {
  RecurringExpense toDomain() {
    return RecurringMapper.fromRow(this);
  }
}
