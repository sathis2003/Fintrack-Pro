import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../core/errors/failures.dart';
import '../entities/budget.dart';
import '../repositories/i_budget_repository.dart';

@injectable
class SetBudget {
  final IBudgetRepository _repository;

  SetBudget(this._repository);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required String category,
    required double amount,
    required String month, // "YYYY-MM"
  }) async {
    final budget = Budget(
      uuid: const Uuid().v4(),
      userId: userId,
      category: category,
      amount: amount,
      month: month,
      updatedAt: DateTime.now(),
    );
    return _repository.setBudget(budget);
  }
}
