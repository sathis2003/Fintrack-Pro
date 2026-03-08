// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:fintrack_pro/core/di/injection.dart' as _i1030;
import 'package:fintrack_pro/core/network/connectivity_service.dart' as _i379;
import 'package:fintrack_pro/core/theme/theme_notifier.dart' as _i848;
import 'package:fintrack_pro/data/local/daos/achievements_dao.dart' as _i755;
import 'package:fintrack_pro/data/local/daos/budgets_dao.dart' as _i92;
import 'package:fintrack_pro/data/local/daos/expenses_dao.dart' as _i310;
import 'package:fintrack_pro/data/local/daos/financial_profile_dao.dart'
    as _i518;
import 'package:fintrack_pro/data/local/daos/gemma_insight_dao.dart' as _i543;
import 'package:fintrack_pro/data/local/daos/insights_dao.dart' as _i786;
import 'package:fintrack_pro/data/local/daos/raw_expenses_dao.dart' as _i1056;
import 'package:fintrack_pro/data/local/daos/recurring_dao.dart' as _i226;
import 'package:fintrack_pro/data/local/daos/sms_import_dao.dart' as _i823;
import 'package:fintrack_pro/data/local/daos/sync_queue_dao.dart' as _i789;
import 'package:fintrack_pro/data/local/database/app_database.dart' as _i959;
import 'package:fintrack_pro/data/remote/groq_ai_source.dart' as _i845;
import 'package:fintrack_pro/data/remote/supabase_budget_source.dart' as _i995;
import 'package:fintrack_pro/data/remote/supabase_expense_source.dart' as _i924;
import 'package:fintrack_pro/data/repositories/ai_repository_impl.dart'
    as _i977;
import 'package:fintrack_pro/data/repositories/auth_repository_impl.dart'
    as _i821;
import 'package:fintrack_pro/data/repositories/budget_repository_impl.dart'
    as _i50;
import 'package:fintrack_pro/data/repositories/expense_repository_impl.dart'
    as _i183;
import 'package:fintrack_pro/data/repositories/gemma_repository_impl.dart'
    as _i25;
import 'package:fintrack_pro/data/repositories/insights_repository_impl.dart'
    as _i211;
import 'package:fintrack_pro/domain/repositories/i_ai_repository.dart' as _i437;
import 'package:fintrack_pro/domain/repositories/i_auth_repository.dart'
    as _i34;
import 'package:fintrack_pro/domain/repositories/i_budget_repository.dart'
    as _i189;
import 'package:fintrack_pro/domain/repositories/i_expense_repository.dart'
    as _i1023;
import 'package:fintrack_pro/domain/repositories/i_gemma_repository.dart'
    as _i479;
import 'package:fintrack_pro/domain/repositories/i_insights_repository.dart'
    as _i1003;
import 'package:fintrack_pro/domain/use_cases/add_expense.dart' as _i880;
import 'package:fintrack_pro/domain/use_cases/check_budget_alerts.dart'
    as _i1041;
import 'package:fintrack_pro/domain/use_cases/extract_expense_from_text.dart'
    as _i278;
import 'package:fintrack_pro/domain/use_cases/generate_ai_insight.dart' as _i11;
import 'package:fintrack_pro/domain/use_cases/get_monthly_summary.dart'
    as _i391;
import 'package:fintrack_pro/domain/use_cases/set_budget.dart' as _i949;
import 'package:fintrack_pro/features/auth/bloc/auth_bloc.dart' as _i105;
import 'package:fintrack_pro/features/budget/bloc/budget_bloc.dart' as _i600;
import 'package:fintrack_pro/features/chat/bloc/chat_bloc.dart' as _i800;
import 'package:fintrack_pro/features/dashboard/bloc/dashboard_bloc.dart'
    as _i628;
import 'package:fintrack_pro/features/export/bloc/export_bloc.dart' as _i295;
import 'package:fintrack_pro/features/history/bloc/history_bloc.dart' as _i93;
import 'package:fintrack_pro/features/import/bloc/import_bloc.dart' as _i292;
import 'package:fintrack_pro/features/insights/bloc/insights_bloc.dart'
    as _i1000;
import 'package:fintrack_pro/features/onboarding/bloc/onboarding_bloc.dart'
    as _i162;
import 'package:fintrack_pro/features/premium/bloc/premium_bloc.dart' as _i116;
import 'package:fintrack_pro/features/profile/bloc/profile_bloc.dart' as _i946;
import 'package:fintrack_pro/features/profile_setup/bloc/profile_setup_bloc.dart'
    as _i280;
import 'package:fintrack_pro/features/recurring/bloc/recurring_bloc.dart'
    as _i68;
import 'package:fintrack_pro/services/achievement_service.dart' as _i70;
import 'package:fintrack_pro/services/budget_alert_service.dart' as _i279;
import 'package:fintrack_pro/services/chat_context_builder.dart' as _i179;
import 'package:fintrack_pro/services/notification_service.dart' as _i611;
import 'package:fintrack_pro/services/revenue_cat_service.dart' as _i1013;
import 'package:fintrack_pro/services/sync_service.dart' as _i677;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i162.OnboardingBloc>(() => _i162.OnboardingBloc());
    gh.singleton<_i454.SupabaseClient>(() => registerModule.supabase);
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.singleton<_i959.AppDatabase>(() => registerModule.database);
    gh.singleton<_i611.NotificationService>(() => _i611.NotificationService());
    gh.lazySingleton<_i848.ThemeNotifier>(() => _i848.ThemeNotifier());
    gh.lazySingleton<_i1013.RevenueCatService>(
        () => _i1013.RevenueCatService());
    gh.lazySingleton<_i755.AchievementsDao>(
        () => _i755.AchievementsDao(gh<_i959.AppDatabase>()));
    gh.lazySingleton<_i92.BudgetsDao>(
        () => _i92.BudgetsDao(gh<_i959.AppDatabase>()));
    gh.lazySingleton<_i518.FinancialProfileDao>(
        () => _i518.FinancialProfileDao(gh<_i959.AppDatabase>()));
    gh.lazySingleton<_i543.GemmaInsightDao>(
        () => _i543.GemmaInsightDao(gh<_i959.AppDatabase>()));
    gh.lazySingleton<_i786.InsightsDao>(
        () => _i786.InsightsDao(gh<_i959.AppDatabase>()));
    gh.lazySingleton<_i1056.RawExpensesDao>(
        () => _i1056.RawExpensesDao(gh<_i959.AppDatabase>()));
    gh.lazySingleton<_i226.RecurringDao>(
        () => _i226.RecurringDao(gh<_i959.AppDatabase>()));
    gh.singleton<_i310.ExpensesDao>(
        () => registerModule.expensesDao(gh<_i959.AppDatabase>()));
    gh.singleton<_i789.SyncQueueDao>(
        () => registerModule.syncQueueDao(gh<_i959.AppDatabase>()));
    gh.factory<_i823.SmsImportDao>(
        () => _i823.SmsImportDao(gh<_i959.AppDatabase>()));
    gh.factory<_i189.IBudgetRepository>(() => _i50.BudgetRepositoryImpl(
          gh<_i92.BudgetsDao>(),
          gh<_i789.SyncQueueDao>(),
        ));
    gh.factory<_i479.IGemmaRepository>(
        () => _i25.GemmaRepositoryImpl(gh<_i543.GemmaInsightDao>()));
    gh.factory<_i845.GroqAISource>(
        () => _i845.GroqAISource(gh<_i454.SupabaseClient>()));
    gh.factory<_i116.PremiumBloc>(
        () => _i116.PremiumBloc(gh<_i1013.RevenueCatService>()));
    gh.factory<_i68.RecurringBloc>(() => _i68.RecurringBloc(
          gh<_i226.RecurringDao>(),
          gh<_i310.ExpensesDao>(),
          gh<_i454.SupabaseClient>(),
        ));
    gh.factory<_i292.ImportBloc>(() => _i292.ImportBloc(
          gh<_i823.SmsImportDao>(),
          gh<_i310.ExpensesDao>(),
          gh<_i454.SupabaseClient>(),
        ));
    gh.factory<_i379.ConnectivityService>(
        () => _i379.ConnectivityService(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i995.SupabaseBudgetSource>(
        () => _i995.SupabaseBudgetSource(gh<_i454.SupabaseClient>()));
    gh.factory<_i924.SupabaseExpenseSource>(
        () => _i924.SupabaseExpenseSource(gh<_i454.SupabaseClient>()));
    gh.factory<_i949.SetBudget>(
        () => _i949.SetBudget(gh<_i189.IBudgetRepository>()));
    gh.lazySingleton<_i34.IAuthRepository>(
        () => _i821.AuthRepositoryImpl(gh<_i454.SupabaseClient>()));
    gh.factory<_i600.BudgetBloc>(() => _i600.BudgetBloc(
          gh<_i189.IBudgetRepository>(),
          gh<_i949.SetBudget>(),
          gh<_i454.SupabaseClient>(),
        ));
    gh.factory<_i1003.IInsightsRepository>(() => _i211.InsightsRepositoryImpl(
          gh<_i786.InsightsDao>(),
          gh<_i361.Dio>(),
        ));
    gh.singleton<_i179.ChatContextBuilder>(
        () => registerModule.chatContextBuilder(
              gh<_i310.ExpensesDao>(),
              gh<_i92.BudgetsDao>(),
              gh<_i518.FinancialProfileDao>(),
            ));
    gh.factory<_i295.ExportBloc>(() => _i295.ExportBloc(
          gh<_i310.ExpensesDao>(),
          gh<_i518.FinancialProfileDao>(),
          gh<_i454.SupabaseClient>(),
        ));
    gh.factory<_i70.AchievementService>(() => _i70.AchievementService(
          gh<_i755.AchievementsDao>(),
          gh<_i454.SupabaseClient>(),
        ));
    gh.factory<_i1023.IExpenseRepository>(() => _i183.ExpenseRepositoryImpl(
          gh<_i310.ExpensesDao>(),
          gh<_i789.SyncQueueDao>(),
        ));
    gh.factory<_i880.AddExpense>(
        () => _i880.AddExpense(gh<_i1023.IExpenseRepository>()));
    gh.factory<_i391.GetMonthlySummary>(
        () => _i391.GetMonthlySummary(gh<_i1023.IExpenseRepository>()));
    gh.factory<_i628.DashboardBloc>(() => _i628.DashboardBloc(
          gh<_i391.GetMonthlySummary>(),
          gh<_i189.IBudgetRepository>(),
          gh<_i454.SupabaseClient>(),
          gh<_i518.FinancialProfileDao>(),
        ));
    gh.factory<_i93.HistoryBloc>(() => _i93.HistoryBloc(
          gh<_i1023.IExpenseRepository>(),
          gh<_i454.SupabaseClient>(),
        ));
    gh.lazySingleton<_i105.AuthBloc>(() => _i105.AuthBloc(
          gh<_i34.IAuthRepository>(),
          gh<_i959.AppDatabase>(),
          gh<_i1013.RevenueCatService>(),
        ));
    gh.factory<_i280.ProfileSetupBloc>(() => _i280.ProfileSetupBloc(
          gh<_i959.AppDatabase>(),
          gh<_i34.IAuthRepository>(),
        ));
    gh.factory<_i946.ProfileBloc>(() => _i946.ProfileBloc(
          gh<_i959.AppDatabase>(),
          gh<_i34.IAuthRepository>(),
          gh<_i454.SupabaseClient>(),
        ));
    gh.factory<_i437.IAiRepository>(
        () => _i977.AiRepositoryImpl(gh<_i845.GroqAISource>()));
    gh.factory<_i11.GenerateAiInsight>(() => _i11.GenerateAiInsight(
          gh<_i1003.IInsightsRepository>(),
          gh<_i391.GetMonthlySummary>(),
          gh<_i1023.IExpenseRepository>(),
        ));
    gh.factory<_i278.ExtractExpenseFromText>(
        () => _i278.ExtractExpenseFromText(gh<_i437.IAiRepository>()));
    gh.singleton<_i677.SyncService>(() => _i677.SyncService(
          gh<_i789.SyncQueueDao>(),
          gh<_i924.SupabaseExpenseSource>(),
          gh<_i995.SupabaseBudgetSource>(),
          gh<_i379.ConnectivityService>(),
          gh<_i1056.RawExpensesDao>(),
          gh<_i278.ExtractExpenseFromText>(),
          gh<_i880.AddExpense>(),
          gh<_i454.SupabaseClient>(),
        ));
    gh.factory<_i1000.InsightsBloc>(() => _i1000.InsightsBloc(
          gh<_i11.GenerateAiInsight>(),
          gh<_i1003.IInsightsRepository>(),
          gh<_i1013.RevenueCatService>(),
          gh<_i454.SupabaseClient>(),
        ));
    gh.singleton<_i279.BudgetAlertService>(() => _i279.BudgetAlertService(
          gh<_i189.IBudgetRepository>(),
          gh<_i1023.IExpenseRepository>(),
          gh<_i611.NotificationService>(),
        ));
    gh.factory<_i800.ChatBloc>(() => _i800.ChatBloc(
          gh<_i278.ExtractExpenseFromText>(),
          gh<_i437.IAiRepository>(),
          gh<_i880.AddExpense>(),
          gh<_i454.SupabaseClient>(),
          gh<_i518.FinancialProfileDao>(),
          gh<_i70.AchievementService>(),
          gh<_i310.ExpensesDao>(),
          gh<_i1056.RawExpensesDao>(),
          gh<_i179.ChatContextBuilder>(),
        ));
    gh.factory<_i1041.CheckBudgetAlerts>(
        () => _i1041.CheckBudgetAlerts(gh<_i279.BudgetAlertService>()));
    return this;
  }
}

class _$RegisterModule extends _i1030.RegisterModule {}
