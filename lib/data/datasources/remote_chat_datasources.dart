import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteChatDataSource {
  static const URL = 'http://127.0.0.1:8080';

  Future<String> getUserData(String username) async {
    var response = await http.get(Uri.parse('${URL}/api/user/${username}'));
    return response.body;
  }

  Future<String> getChatData(String id) async {
    var response = await http.get(Uri.parse('${URL}/api/chat/${id}'));
    return response.body;
  }

  Future<String> getRoomData(String username) async {
    var response = await http.get(Uri.parse('${URL}/api/room/${username}'));
    return response.body;
  }

  Future<String> postRoomData(Map<String, dynamic> room) async {
    var response = await http.post(Uri.parse('${URL}/api/room'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'from': room['from'], 'to': room['to']}));
    return response.body;
  }

  Future<String> postChatData(Map<String, dynamic> chat) async {
    var response = await http.post(Uri.parse('${URL}/api/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': chat['id'],
          'from': chat['username'],
          'text': chat['text']
        }));
    return response.body;
  }
}
