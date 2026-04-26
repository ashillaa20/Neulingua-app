import 'dart:convert';
import 'package:http/http.dart' as http;

class GravityService {
  static const String baseUrl = 'https://your-gravity-backend.com/api';

  static Map<String, String> _h({String? token}) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  static Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    final r = await http.post(Uri.parse('$baseUrl/auth/login'),
        headers: _h(),
        body: jsonEncode({'email': email, 'password': password}));
    return _ok(r);
  }

  static Future<Map<String, dynamic>> register(
      {required String name,
      required String email,
      required String password}) async {
    final r = await http.post(Uri.parse('$baseUrl/auth/register'),
        headers: _h(),
        body: jsonEncode({'name': name, 'email': email, 'password': password}));
    return _ok(r);
  }

  // ── Translate
  static Future<Map<String, dynamic>> translate({
    required String text,
    required String sourceLang,
    required String targetLang,
  }) async {
    final r = await http.post(Uri.parse('$baseUrl/translate'),
        headers: _h(),
        body: jsonEncode({
          'text': text,
          'source_lang': sourceLang,
          'target_lang': targetLang
        }));
    return _ok(r);
  }

  // ── Vocabulary
  static Future<List<dynamic>> getVocabulary(
      {String? token, String? language}) async {
    final q = language != null ? '?language=$language' : '';
    final r = await http.get(Uri.parse('$baseUrl/vocabulary$q'),
        headers: _h(token: token));
    return _ok(r)['data'] as List<dynamic>;
  }

  // ── Quiz
  static Future<List<dynamic>> getQuiz(
      {required String token, required String language}) async {
    final r = await http.get(Uri.parse('$baseUrl/quiz?language=$language'),
        headers: _h(token: token));
    return _ok(r)['questions'] as List<dynamic>;
  }

  static Future<Map<String, dynamic>> submitQuiz(
      {required String token,
      required List<Map<String, dynamic>> answers}) async {
    final r = await http.post(Uri.parse('$baseUrl/quiz/submit'),
        headers: _h(token: token), body: jsonEncode({'answers': answers}));
    return _ok(r);
  }

  // ── Progress
  static Future<Map<String, dynamic>> getProgress(String token) async {
    final r = await http.get(Uri.parse('$baseUrl/user/progress'),
        headers: _h(token: token));
    return _ok(r);
  }

  static Future<Map<String, dynamic>> updateProgress({
    required String token,
    required String lessonId,
    required int score,
    required bool completed,
  }) async {
    final r = await http.post(Uri.parse('$baseUrl/user/progress'),
        headers: _h(token: token),
        body: jsonEncode(
            {'lesson_id': lessonId, 'score': score, 'completed': completed}));
    return _ok(r);
  }

  static Map<String, dynamic> _ok(http.Response r) {
    final body = jsonDecode(r.body) as Map<String, dynamic>;
    if (r.statusCode >= 200 && r.statusCode < 300) return body;
    throw Exception('${r.statusCode}: ${body['message']}');
  }
}
