import 'package:bloc_crud/modules/save_or_edit_post/state_management/save_or_edit_post_event.dart';
import 'package:bloc_crud/modules/save_or_edit_post/state_management/save_or_edit_post_state.dart';
import 'package:bloc_crud/shared/database/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveOrEditPostBloc
    extends Bloc<SaveOrEditPostEvent, SaveOrEditPostState> {
  final DatabaseHelper databaseHelper;

  SaveOrEditPostBloc({
    required this.databaseHelper,
  }) : super(SaveOrEditPostIsLoaded());

  @override
  Stream<SaveOrEditPostState> mapEventToState(
      SaveOrEditPostEvent event) async* {
    yield const SaveOrEditPostIsLoading();

    try {
      if (event is SavePostEvent) {
        await databaseHelper.insertPost(event.postModel);
      } else if (event is UpdatePostEvent) {
        await databaseHelper.updatePost(event.postModel);
      } else if (event is DeletePostEvent) {
        await databaseHelper.deletePost(event.postModel.id!);
      } else {
        print('atualizando estado para foto');
      }

      yield SaveOrEditPostIsLoaded();
    } catch (e) {
      yield const SaveOrEditPostContainsError(
          message: 'Erro ao realizar operação');
    }
  }
}
