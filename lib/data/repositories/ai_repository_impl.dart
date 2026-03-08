import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/extracted_expense.dart';
import '../../domain/repositories/i_ai_repository.dart';
import '../../core/errors/failures.dart';
import '../remote/groq_ai_source.dart';

@Injectable(as: IAiRepository)
class AiRepositoryImpl implements IAiRepository {
  final GroqAISource _source;
  AiRepositoryImpl(this._source);

  GroqAISource get source => _source;

  @override
  Future<Either<Failure, ExtractedExpense>> extractExpense(
      String userText) async {
    try {
      final json = await _source.extractExpense(userText);
      final extracted = ExtractedExpense.fromJson(json);

      if (extracted.errorCode == 'rate_limited') {
        return const Left(RateLimitFailure());
      }
      if (extracted.errorCode == 'network') {
        return const Left(NetworkFailure());
      }
      if (extracted.errorCode == 'not_authenticated') {
        return const Left(AuthFailure());
      }

      return Right(extracted);
    } catch (e) {
      return Left(AIFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExtractedExpense>> scanReceipt(
      String base64Image) async {
    try {
      final json = await _source.scanReceipt(base64Image);
      final extracted = ExtractedExpense.fromJson(json);
      if (extracted.errorCode == 'rate_limited') {
        return const Left(RateLimitFailure());
      }
      if (extracted.errorCode == 'not_a_receipt') {
        return const Left(ParseFailure('not_a_receipt'));
      }
      if (extracted.errorCode == 'network') {
        return const Left(NetworkFailure());
      }
      if (extracted.errorCode == 'not_authenticated') {
        return const Left(AuthFailure());
      }
      return Right(extracted);
    } catch (e) {
      return Left(AIFailure(e.toString()));
    }
  }
}
