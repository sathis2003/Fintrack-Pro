import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../services/revenue_cat_service.dart';
import 'premium_event.dart';
import 'premium_state.dart';

@injectable
class PremiumBloc extends Bloc<PremiumEvent, PremiumState> {
  final RevenueCatService _revenueCatService;

  PremiumBloc(this._revenueCatService) : super(PremiumInitial()) {
    on<PremiumCheckStatus>((event, emit) async {
      final isPro = await _revenueCatService.isPro();
      emit(PremiumStatusLoaded(isPro));
    });

    on<PremiumFetchOfferings>((event, emit) async {
      emit(PremiumLoading());
      final isPro = await _revenueCatService.isPro();
      final packages = await _revenueCatService.getOfferings();
      emit(PremiumOfferingsLoaded(packages: packages, isPro: isPro));
    });

    on<PremiumPurchaseRequested>((event, emit) async {
      emit(PremiumLoading());
      final success = await _revenueCatService.purchasePackage(event.package);
      if (success) {
        emit(PremiumSuccess());
        add(PremiumCheckStatus());
      } else {
        emit(const PremiumError('Purchase failed or cancelled'));
        add(PremiumFetchOfferings());
      }
    });

    on<PremiumRestoreRequested>((event, emit) async {
      emit(PremiumLoading());
      await _revenueCatService.restorePurchases();
      add(PremiumCheckStatus());
    });
  }
}
