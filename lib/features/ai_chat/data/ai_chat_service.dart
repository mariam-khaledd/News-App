import 'dart:convert';

import 'package:http/http.dart' as http;

class AiChatService {
  static const String webhookUrl =
      'https://mariamkhaled123.app.n8n.cloud/webhook/news-support';

  Future<String> sendMessage({
    required String message,
    required String sessionId,
  }) async {
    final response = await http.post(
      Uri.parse(webhookUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message': message,
        'session_id': sessionId,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);

      return data['reply'] as String;
    }

    throw Exception(
      'Failed to send message: ${response.statusCode}',
    );
  }
}