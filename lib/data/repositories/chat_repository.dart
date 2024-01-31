import 'dart:convert';

import 'package:mini_project_bsi_chat/data/datasources/remote_chat_datasources.dart';
import 'package:mini_project_bsi_chat/domain/entities/chat_message.dart';
import 'package:mini_project_bsi_chat/domain/entities/chat_room.dart';
import 'package:mini_project_bsi_chat/domain/entities/message.dart';
import 'package:mini_project_bsi_chat/domain/entities/user_room.dart';

import '../../domain/entities/chat.dart';

class ChatRepository {
  RemoteChatDataSource remoteChatDataSource = RemoteChatDataSource();

  Future<UserRoom> getRoom(String username) async {
    var jsonArray =
        jsonDecode(await remoteChatDataSource.getUserData(username))['data']
            ['rooms'];
    List listRoom = jsonArray;
    print(listRoom);
    listRoom.sort((a, b) => b.compareTo(a));
    print(listRoom);
    return UserRoom(username: username, room: listRoom);
  }

  Future<ChatRoom> getChat(String room_id) async {
    var jsonArrayMessages =
        jsonDecode(await remoteChatDataSource.getChatData(room_id))['data']
            ['messages'] as List;
    List<Message> listMessage =
        jsonArrayMessages.map((message) => Message.fromJson(message)).toList();
    return ChatRoom(messages: listMessage);
  }

  Future<ChatMessage> getMessageChat(String room_id) async {
    List jsonArrayUsers =
        jsonDecode(await remoteChatDataSource.getChatData(room_id))['data']
            ['users'] as List;
    var jsonArrayMessages =
        jsonDecode(await remoteChatDataSource.getChatData(room_id))['data']
            ['messages'] as List;
    List<Message> listMessage =
        jsonArrayMessages.map((message) => Message.fromJson(message)).toList();
    return ChatMessage(users: jsonArrayUsers, messages: listMessage);
  }

  Future<bool> postSendMessage(Chat chat) async {
    var response = await remoteChatDataSource.postChatData(chat.toJson());
    return jsonDecode(response)['data'];
  }

  Future<String> postRoomData(room) async {
    var response = await remoteChatDataSource.postRoomData(room.toJson());
    return jsonDecode(response)['data']['id'];
  }
}
