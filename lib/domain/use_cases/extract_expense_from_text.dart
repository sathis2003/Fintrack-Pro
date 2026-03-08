import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/extracted_expense.dart';
import '../repositories/i_ai_repository.dart';
import '../../core/errors/failures.dart';

@injectable
class ExtractExpenseFromText {
  final IAiRepository _repo;
  const ExtractExpenseFromText(this._repo);

  Future<Either<Failure, ExtractedExpense>> call(String text) =>
      _repo.extractExpense(text.trim());
}
