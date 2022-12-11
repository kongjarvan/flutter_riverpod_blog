import 'package:blog/domain/post/post.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageViewModel = StateNotifierProvider<HomePageViewModel, List<Post>>((ref) {
  AuthProvider ap = ref.read(authProvider);
  return HomePageViewModel([], ap);
});

class HomePageViewModel extends StateNotifier<List<Post>> {
  AuthProvider ap;
  HomePageViewModel(super.state, this.ap);
}
