import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_boilerplate/features/chat/presentation/viewmodels/chat_list_view_model.dart';

void main() {
  test('ChatListViewModel loads rooms on build', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Initial state
    expect(
      container.read(chatListViewModelProvider).rooms.isLoading,
      isTrue,
    );

    // Wait for async load
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final state = container.read(chatListViewModelProvider);
    expect(state.rooms.hasValue, isTrue);
    expect(state.rooms.value!.length, equals(4));

    // Test search filter
    container.read(chatListViewModelProvider.notifier).setSearchQuery('Alex');
    final searchedState = container.read(chatListViewModelProvider);
    expect(searchedState.filteredRooms.length, equals(1));
    expect(searchedState.filteredRooms.first.name, equals('Alex Vance'));
  });
}
