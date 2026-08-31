/// REST API endpoints
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://api.example.com/v1';

  // Auth & User
  static const String me = '/users/me';
  static const String users = '/users';

  // Chat Rooms & Messages
  static const String chatRooms = '/rooms';
  static String roomMessages(String roomId) => '/rooms/$roomId/messages';
  static String sendMessage(String roomId) => '/rooms/$roomId/messages';
}
