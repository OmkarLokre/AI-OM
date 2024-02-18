import 'dart:convert';

import 'package:ai_assistance/secrets.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:ai_assistance/secrets.dart';
import 'package:http/http.dart' as http;

class openAiService {
  final List<Map<String, String>> message = [];

  Future<String> isArtPrompt(String prompt) async {
    try {
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAPIKey',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                'role': 'user',
                'content':
                    'Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
              }
            ]
          }));
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        switch (content) {
          case 'Yes.':
          case 'yes.':
          case 'YES':
          case 'yes':
          case 'Yes':
            final res = await dallE(prompt);
            return res;
          default:
            final res = await chatGpt(prompt);
            return res;
        }
      }
      return 'An internal error occured';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGpt(String prompt) async {
    message.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAPIKey',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": message,
          }));

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        message.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occured';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallE(String prompt) async {
    message.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/images/generations'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAPIKey',
          },
          body: jsonEncode({
            'prompt': prompt,
            'n': 1,
          }));

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();
        message.add({
          'role': 'assistant',
          'content': imageUrl,
        });
        return imageUrl;
      }
      return 'An internal error occured';
    } catch (e) {
      return e.toString();
    }
  }
}

// Future<String> chatGpt(String Prompt) async {
//   return 'CHATGPT';
// }

// Future<String> dallE(String Prompt) async {
//   return 'DALL-E';
// }
