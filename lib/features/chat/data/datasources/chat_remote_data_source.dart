import 'dart:async';
import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/logging/app_logger.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';

abstract interface class ChatRemoteDataSource {
  Future<List<ChatRoom>> getChatRooms();
  Future<List<ChatMessage>> getMessages(String roomId);
  Future<ChatMessage> sendMessage({
    required String roomId,
    required String message,
  });
  Stream<ChatMessage> get messageStream;
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl({
    required this.dio,
    this.enablePeriodicSimulation = false,
  }) {
    if (enablePeriodicSimulation) {
      _startSimulatedIncomingMessages();
    }
  }

  final Dio dio;
  final bool enablePeriodicSimulation;
  final _messageStreamController = StreamController<ChatMessage>.broadcast();
  Timer? _simulationTimer;

  // In-memory data store with mock seed data for demo & offline capability
  final List<ChatRoom> _inMemoryRooms = [
    ChatRoom(
      id: 'room_1',
      name: 'Flutter Architecture Guild',
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      lastMessage: 'Let\'s ensure 120 FPS rendering on Impeller!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
      isOnline: true,
      participantIds: const ['user_1', 'user_2', 'user_me'],
    ),
    ChatRoom(
      id: 'room_2',
      name: 'Alex Vance',
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      lastMessage: 'Are we using freezed with Dart 3 sealed classes?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 24)),
      unreadCount: 0,
      isOnline: true,
      participantIds: const ['user_alex', 'user_me'],
    ),
    ChatRoom(
      id: 'room_3',
      name: 'Sarah Connor',
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      lastMessage: 'The new design tokens look incredible in dark mode.',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      unreadCount: 1,
      isOnline: false,
      participantIds: const ['user_sarah', 'user_me'],
    ),
    ChatRoom(
      id: 'room_4',
      name: 'Mobile Core Engineering',
      avatarUrl: 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=150',
      lastMessage: 'PR merged: Added go_router typed routes!',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isOnline: true,
      participantIds: const ['user_core_1', 'user_core_2', 'user_me'],
    ),
  ];

  final Map<String, List<ChatMessage>> _inMemoryMessages = {
    'room_1': [
      ChatMessage(
        id: 'msg_1_1',
        roomId: 'room_1',
        senderId: 'user_1',
        senderName: 'David K.',
        message: 'Hey team, welcome to the Flutter Boilerplate! 🚀',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        status: MessageStatus.read,
        isMine: false,
      ),
      ChatMessage(
        id: 'msg_1_2',
        roomId: 'room_1',
        senderId: 'user_me',
        senderName: 'Me',
        message: 'Excited! The MVVM architecture and riverpod setup are clean.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
        status: MessageStatus.read,
        isMine: true,
      ),
      ChatMessage(
        id: 'msg_1_3',
        roomId: 'room_1',
        senderId: 'user_2',
        senderName: 'Elena Rostova',
        message: 'Let\'s ensure 120 FPS rendering on Impeller!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        status: MessageStatus.read,
        isMine: false,
      ),
    ],
    'room_2': [
      ChatMessage(
        id: 'msg_2_1',
        roomId: 'room_2',
        senderId: 'user_alex',
        senderName: 'Alex Vance',
        message: 'Hey! Quick question about model generation.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        status: MessageStatus.read,
        isMine: false,
      ),
      ChatMessage(
        id: 'msg_2_2',
        roomId: 'room_2',
        senderId: 'user_alex',
        senderName: 'Alex Vance',
        message: 'Are we using freezed with Dart 3 sealed classes?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 24)),
        status: MessageStatus.read,
        isMine: false,
      ),
    ],
  };

  void _startSimulatedIncomingMessages() {
    _simulationTimer = Timer.periodic(const Duration(seconds: 25), (timer) {
      final newMessage = ChatMessage(
        id: 'sim_${DateTime.now().millisecondsSinceEpoch}',
        roomId: 'room_1',
        senderId: 'user_2',
        senderName: 'Elena Rostova',
        message: 'Real-time ping: Kinetic architecture running smoothly! ⚡️',
        timestamp: DateTime.now(),
        status: MessageStatus.delivered,
        isMine: false,
      );

      _inMemoryMessages['room_1']?.add(newMessage);
      _messageStreamController.add(newMessage);
    });
  }

  @override
  Stream<ChatMessage> get messageStream => _messageStreamController.stream;

  @override
  Future<List<ChatRoom>> getChatRooms() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      return List.unmodifiable(_inMemoryRooms);
    } catch (e, stack) {
      AppLogger.error('Failed to get chat rooms', e, stack);
      throw const ServerException(message: 'Failed to fetch chat rooms');
    }
  }

  @override
  Future<List<ChatMessage>> getMessages(String roomId) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      return List.unmodifiable(_inMemoryMessages[roomId] ?? []);
    } catch (e, stack) {
      AppLogger.error('Failed to get messages for room: $roomId', e, stack);
      throw ServerException(message: 'Failed to fetch messages for room $roomId');
    }
  }

  @override
  Future<ChatMessage> sendMessage({
    required String roomId,
    required String message,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final sentMessage = ChatMessage(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        roomId: roomId,
        senderId: 'user_me',
        senderName: 'Me',
        message: message,
        timestamp: DateTime.now(),
        status: MessageStatus.sent,
        isMine: true,
      );

      final roomList = _inMemoryMessages.putIfAbsent(roomId, () => []);
      roomList.add(sentMessage);

      final roomIndex = _inMemoryRooms.indexWhere((r) => r.id == roomId);
      if (roomIndex != -1) {
        final currentRoom = _inMemoryRooms[roomIndex];
        _inMemoryRooms[roomIndex] = currentRoom.copyWith(
          lastMessage: message,
          lastMessageTime: sentMessage.timestamp,
        );
      }

      return sentMessage;
    } catch (e, stack) {
      AppLogger.error('Failed to send message to room: $roomId', e, stack);
      throw const ServerException(message: 'Failed to send message');
    }
  }

  void dispose() {
    _simulationTimer?.cancel();
    _messageStreamController.close();
  }
}
