import 'package:mini_project_bsi_chat/data/repositories/chat_repository.dart';
import 'package:mini_project_bsi_chat/domain/entities/user_room.dart';

class GetRooms {
  var repository = ChatRepository();

  Future<UserRoom> execute(username) async {
    return repository.getRoom(username);
  }
}
