import 'package:chirp/constants/table_constants.dart';
import 'package:chirp/data/profile/dtos/profile_user_dto.dart';
import 'package:chirp/error/app_errors.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatsRepository {
  final Supabase _supabase;
  final Socket _socketIO;

  ChatsRepository({
    required Supabase supabase,
    required Socket socketIO,
  })  : _supabase = supabase,
        _socketIO = socketIO;

  Future<void> createRoom(
    String ourUserId,
    String opponentUserId,
  ) async {
    _socketIO.emit(
      "create-room",
      "${ourUserId}_$opponentUserId}",
    );
  }

  Future<void> listeningRoomInfo(Function(dynamic data) callback) async {
    _socketIO.on(
      "info",
      callback,
    );
  }

  Stream<List<ProfileUserDto>> getContacts(
    String userId,
    List<String> contactIds,
  ) async* {
    yield* _supabase.client
        .from(TableConstants.USER_PROFILE_TABLE)
        .stream()
        .execute()
        .map(
          (results) => results
              .map(
                (data) => ProfileUserDto.fromJson(data),
              )
              .where((data) => data.userId != userId)
              .toList(),
        )
        .handleError((error) {
      throw AppError(error.toString());
    });
  }
}
