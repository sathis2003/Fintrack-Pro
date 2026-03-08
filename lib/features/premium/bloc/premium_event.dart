import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class PremiumEvent extends Equatable {
  const PremiumEvent();

  @override
  List<Object?> get props => [];
}

class PremiumCheckStatus extends PremiumEvent {}

class PremiumFetchOfferings extends PremiumEvent {}

class PremiumPurchaseRequested extends PremiumEvent {
  final Package package;
  const PremiumPurchaseRequested(this.package);

  @override
  List<Object?> get props => [package];
}

class PremiumRestoreRequested extends PremiumEvent {}
