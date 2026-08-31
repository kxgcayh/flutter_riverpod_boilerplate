import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_result.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';

/// Provider for [ChatRemoteDataSource]
final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return ChatRemoteDataSourceImpl(dio: dio);
});

/// Provider for [ChatRepository]
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remoteDataSource = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remoteDataSource: remoteDataSource);
});

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl({required this.remoteDataSource});

  final ChatRemoteDataSource remoteDataSource;

  @override
  Stream<ChatMessage> get messageStream => remoteDataSource.messageStream;

  @override
  Future<Result<List<ChatRoom>>> getChatRooms() async {
    try {
      final rooms = await remoteDataSource.getChatRooms();
      return Result.success(rooms);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<ChatMessage>>> getMessages(String roomId) async {
    try {
      final messages = await remoteDataSource.getMessages(roomId);
      return Result.success(messages);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<ChatMessage>> sendMessage({required String roomId, required String message}) async {
    try {
      final sentMessage = await remoteDataSource.sendMessage(roomId: roomId, message: message);
      return Result.success(sentMessage);
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString()));
    }
  }
}
