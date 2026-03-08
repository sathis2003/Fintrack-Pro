import 'package:equatable/equatable.dart';

enum ProfileSetupStep { income, date, currency }

class ProfileSetupState extends Equatable {
  final ProfileSetupStep step;
  final double income;
  final int incomeDay;
  final String currency;
  final bool isSaving;
  final bool isDone;

  const ProfileSetupState({
    this.step = ProfileSetupStep.income,
    this.income = 0,
    this.incomeDay = 1,
    this.currency = 'INR',
    this.isSaving = false,
    this.isDone = false,
  });

  ProfileSetupState copyWith({
    ProfileSetupStep? step,
    double? income,
    int? incomeDay,
    String? currency,
    bool? isSaving,
    bool? isDone,
  }) {
    return ProfileSetupState(
      step: step ?? this.step,
      income: income ?? this.income,
      incomeDay: incomeDay ?? this.incomeDay,
      currency: currency ?? this.currency,
      isSaving: isSaving ?? this.isSaving,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props =>
      [step, income, incomeDay, currency, isSaving, isDone];
}
