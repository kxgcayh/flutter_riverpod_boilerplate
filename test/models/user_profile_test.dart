import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/profile/data/models/user_profile.dart';

void main() {
  group('UserProfile Freezed Model', () {
    test('supports value equality and json serialization', () {
      const user = UserProfile(
        id: 'u_1',
        name: 'Kautsar Albana',
        username: '@kautsar',
        email: 'kautsar@kineticastudios.com',
        bio: 'Senior Flutter Dev',
        status: 'Available',
        isOnline: true,
      );

      final json = user.toJson();
      expect(json['name'], equals('Kautsar Albana'));
      expect(json['email'], equals('kautsar@kineticastudios.com'));

      final fromJson = UserProfile.fromJson(json);
      expect(fromJson, equals(user));

      final updated = user.copyWith(bio: 'Lead Engineer');
      expect(updated.bio, equals('Lead Engineer'));
    });
  });
}
