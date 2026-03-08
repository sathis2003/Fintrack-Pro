import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class PremiumState extends Equatable {
  const PremiumState();

  @override
  List<Object?> get props => [];
}

class PremiumInitial extends PremiumState {}

class PremiumStatusLoaded extends PremiumState {
  final bool isPro;
  const PremiumStatusLoaded(this.isPro);

  @override
  List<Object?> get props => [isPro];
}

class PremiumOfferingsLoaded extends PremiumState {
  final List<Package> packages;
  final bool isPro;
  const PremiumOfferingsLoaded({required this.packages, required this.isPro});

  @override
  List<Object?> get props => [packages, isPro];
}

class PremiumLoading extends PremiumState {}

class PremiumSuccess extends PremiumState {}

class PremiumError extends PremiumState {
  final String message;
  const PremiumError(this.message);

  @override
  List<Object?> get props => [message];
}
