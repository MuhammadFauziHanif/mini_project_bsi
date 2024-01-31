import 'package:mini_project_bsi_chat/data/repositories/chat_repository.dart';
import 'package:mini_project_bsi_chat/domain/entities/room.dart';

class CreateRoom {
  var repository = ChatRepository();

  Future<String> execute(Rooms room) {
    return repository.postRoomData(room);
  }
}
