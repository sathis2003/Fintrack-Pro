import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';
import 'package:injectable/injectable.dart';
import '../entities/expense.dart';
import '../repositories/i_expense_repository.dart';
import '../../core/errors/failures.dart';

@injectable
class AddExpense {
  final IExpenseRepository _repo;
  const AddExpense(this._repo);

  Future<Either<Failure, Expense>> call(Expense expense) {
    final now = DateTime.now();
    final newExpense = Expense(
      uuid: expense.uuid.isNotEmpty ? expense.uuid : const Uuid().v4(),
      userId: expense.userId,
      amount: expense.amount,
      category: expense.category,
      description: expense.description,
      date: expense.date,
      isRecurring: expense.isRecurring,
      source: expense.source,
      syncStatus: 'pending',
      createdAt: now,
      updatedAt: now,
    );
    return _repo.add(newExpense);
  }
}
