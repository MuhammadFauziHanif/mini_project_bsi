import 'package:mini_project_bsi_chat/data/repositories/chat_repository.dart';
import 'package:mini_project_bsi_chat/domain/entities/chat_room.dart';

class GetChat {
  var repository = ChatRepository();

  Future<ChatRoom> execute(room_id) async {
    return repository.getChat(room_id);
  }
}
