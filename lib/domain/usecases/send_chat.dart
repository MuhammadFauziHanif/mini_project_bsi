import 'package:mini_project_bsi_chat/data/repositories/chat_repository.dart';
import 'package:mini_project_bsi_chat/domain/entities/chat.dart';

class SendChat {
  var repository = ChatRepository();

  Future<bool> execute(Chat message) {
    return repository.postSendMessage(message);
  }
}
