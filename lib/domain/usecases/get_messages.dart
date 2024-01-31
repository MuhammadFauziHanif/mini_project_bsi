import 'package:mini_project_bsi_chat/data/repositories/chat_repository.dart';
import 'package:mini_project_bsi_chat/domain/entities/chat_message.dart';
import 'package:mini_project_bsi_chat/domain/entities/message.dart';

class GetMessage {
  var repository = ChatRepository();

  Future<ChatMessage> execute(room_id) async {
    try {
      return repository.getMessageChat(room_id);
    } on Exception catch (e) {
      print('Unknown exception: $e');
      return ChatMessage(users: [], messages: []);
    } catch (e) {
      // No specified type, handles all
      print('Something really unknown: $e');
      Message message = Message(username: null, text: null, timestamp: 0);
      return ChatMessage(users: [], messages: [message]);
    }
  }
}
