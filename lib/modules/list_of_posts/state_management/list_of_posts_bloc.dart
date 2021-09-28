import 'package:bloc_crud/shared/database/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_of_posts_state.dart';

class ListOfPostsBloc extends Bloc<void, ListOfPostsState> {
  final DatabaseHelper databaseHelper;

  ListOfPostsBloc({
    required this.databaseHelper,
  }) : super(
          ListOfPostsIsLoaded(
            posts: [],
          ),
        );

  @override
  Stream<ListOfPostsState> mapEventToState(void event) async* {
    yield const ListOfPostsIsLoading();
    try {
      final response = await databaseHelper.getPosts();

      yield ListOfPostsIsLoaded(
        posts: response,
      );
    } catch (e) {
      yield const ListOfPostsContainsError(message: 'Erro ao carregar posts');
    }
  }
}
