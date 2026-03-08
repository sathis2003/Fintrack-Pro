import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton
class SupabaseBudgetSource {
  final SupabaseClient _client;

  SupabaseBudgetSource(this._client);

  Future<void> upsert(Map<String, dynamic> budgetMap) async {
    await _client.from('budgets').upsert(budgetMap, onConflict: 'uuid');
  }

  Future<void> delete(String uuid) async {
    await _client.from('budgets').delete().eq('uuid', uuid);
  }
}
