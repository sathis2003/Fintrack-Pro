import 'package:fpdart/fpdart.dart';
import '../entities/extracted_expense.dart';
import '../../core/errors/failures.dart';

abstract interface class IAiRepository {
  Future<Either<Failure, ExtractedExpense>> extractExpense(String userText);

  // NEW — Phase 7 receipt scanning
  Future<Either<Failure, ExtractedExpense>> scanReceipt(String base64Image);
}
