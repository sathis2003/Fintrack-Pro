import 'package:fpdart/fpdart.dart';
import '../entities/expense.dart';
import '../../core/errors/failures.dart';

abstract interface class IExpenseRepository {
  Stream<List<Expense>> watchByMonth(String userId, DateTime month);
  Future<Either<Failure, Expense>> add(Expense expense);
  Future<Either<Failure, Unit>> update(Expense expense);
  Future<Either<Failure, Unit>> softDelete(String uuid);
}
