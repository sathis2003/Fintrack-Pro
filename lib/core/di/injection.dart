import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';
import '../../data/local/database/app_database.dart';
import '../../data/local/daos/expenses_dao.dart';
import '../../data/local/daos/sync_queue_dao.dart';
import '../../data/local/daos/budgets_dao.dart';
import '../../data/local/daos/financial_profile_dao.dart';
import '../../services/chat_context_builder.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @singleton
  SupabaseClient get supabase => Supabase.instance.client;

  @singleton
  Dio get dio => Dio();

  @singleton
  Connectivity get connectivity => Connectivity();

  @singleton
  AppDatabase get database => AppDatabase();

  @singleton
  ExpensesDao expensesDao(AppDatabase db) => ExpensesDao(db);

  @singleton
  SyncQueueDao syncQueueDao(AppDatabase db) => SyncQueueDao(db);

  @singleton
  ChatContextBuilder chatContextBuilder(
    ExpensesDao expensesDao,
    BudgetsDao budgetsDao,
    FinancialProfileDao profileDao,
  ) =>
      ChatContextBuilder(expensesDao, budgetsDao, profileDao);
}
