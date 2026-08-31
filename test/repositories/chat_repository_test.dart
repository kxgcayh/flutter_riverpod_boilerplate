import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/core/network/network_result.dart';
import 'package:flutter_boilerplate/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:flutter_boilerplate/features/chat/data/repositories/chat_repository_impl.dart';

void main() {
  late ChatRemoteDataSource dataSource;
  late ChatRepositoryImpl repository;

  setUp(() {
    dataSource = ChatRemoteDataSourceImpl(dio: Dio());
    repository = ChatRepositoryImpl(remoteDataSource: dataSource);
  });

  group('ChatRepositoryImpl', () {
    test('getChatRooms returns success with list of rooms', () async {
      final result = await repository.getChatRooms();

      expect(result.isSuccess, isTrue);
      final rooms = (result as Success).data;
      expect(rooms.isNotEmpty, isTrue);
    });

    test('getMessages returns messages for valid roomId', () async {
      final result = await repository.getMessages('room_1');

      expect(result.isSuccess, isTrue);
      final msgs = (result as Success).data;
      expect(msgs.isNotEmpty, isTrue);
    });

    test('sendMessage appends new message and returns success', () async {
      final result = await repository.sendMessage(
        roomId: 'room_1',
        message: 'Test automated message',
      );

      expect(result.isSuccess, isTrue);
      final sent = (result as Success).data;
      expect(sent.message, equals('Test automated message'));
      expect(sent.isMine, isTrue);
    });
  });
}
