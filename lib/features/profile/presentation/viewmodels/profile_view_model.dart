import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/network/network_result.dart';
import '../../data/models/user_profile.dart';
import '../../data/repositories/user_repository_impl.dart';

/// ViewModel managing user profile data and updates
class ProfileViewModel extends Notifier<AsyncValue<UserProfile>> {
  @override
  AsyncValue<UserProfile> build() {
    Future.microtask(() => _loadProfile());
    return const AsyncValue.loading();
  }

  Future<void> _loadProfile() async {
    state = const AsyncValue.loading();
    final repository = ref.read(userRepositoryProvider);
    final result = await repository.getCurrentUser();

    switch (result) {
      case Success<UserProfile>(data: final user):
        state = AsyncValue.data(user);
      case Failure<UserProfile>(failure: final failure):
        state = AsyncValue.error(failure.message, StackTrace.current);
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String bio,
    required String status,
  }) async {
    final repository = ref.read(userRepositoryProvider);
    final result = await repository.updateProfile(
      name: name,
      bio: bio,
      status: status,
    );

    return switch (result) {
      Success<UserProfile>(data: final user) => () {
          state = AsyncValue.data(user);
          return true;
        }(),
      Failure<UserProfile>() => false,
    };
  }
}

final profileViewModelProvider =
    NotifierProvider<ProfileViewModel, AsyncValue<UserProfile>>(
  ProfileViewModel.new,
);
