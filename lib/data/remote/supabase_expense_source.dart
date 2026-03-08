import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class SupabaseExpenseSource {
  final SupabaseClient _client;
  SupabaseExpenseSource(this._client);

  // Upsert by UUID — handles both insert and update
  Future<void> upsert(Map<String, dynamic> record) async {
    await _client.from('expenses').upsert(record, onConflict: 'uuid');
  }

  // Soft delete on cloud
  Future<void> softDelete(String uuid) async {
    await _client.from('expenses').update({
      'is_deleted': true,
      'updated_at': DateTime.now().millisecondsSinceEpoch
    }).eq('uuid', uuid);
  }

  // Pull all user expenses on login (initial sync)
  Future<List<Map<String, dynamic>>> fetchAll(String userId) async {
    final response = await _client
        .from('expenses')
        .select()
        .eq('user_id', userId)
        .eq('is_deleted', false)
        .order('date', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }
}
