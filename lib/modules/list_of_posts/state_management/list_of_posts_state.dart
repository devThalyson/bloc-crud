import 'package:bloc_crud/shared/models/post_model.dart';

abstract class ListOfPostsState {}

class ListOfPostsIsLoaded implements ListOfPostsState {
  final List<PostModel> posts;

  const ListOfPostsIsLoaded({required this.posts});
}

class ListOfPostsContainsError implements ListOfPostsState {
  final String message;

  const ListOfPostsContainsError({required this.message});
}

class ListOfPostsIsLoading implements ListOfPostsState {
  const ListOfPostsIsLoading();
}
