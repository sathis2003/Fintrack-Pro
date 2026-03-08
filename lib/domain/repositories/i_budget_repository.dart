import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../entities/budget.dart';

abstract class IBudgetRepository {
  Stream<List<Budget>> watchByMonth(String userId, String month);
  Future<Either<Failure, Unit>> setBudget(Budget budget);
  Future<Either<Failure, Unit>> deleteBudget(String uuid);
}
