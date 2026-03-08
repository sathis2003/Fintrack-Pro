import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../core/errors/failures.dart';
import '../../services/budget_alert_service.dart';

@injectable
class CheckBudgetAlerts {
  final BudgetAlertService _service;

  CheckBudgetAlerts(this._service);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required String category,
  }) async {
    try {
      await _service.checkAlerts(userId, category);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
