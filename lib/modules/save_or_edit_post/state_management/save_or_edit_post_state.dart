abstract class SaveOrEditPostState {}

class SaveOrEditPostIsLoaded implements SaveOrEditPostState {
  const SaveOrEditPostIsLoaded();
}

class SaveOrEditPostContainsError implements SaveOrEditPostState {
  final String message;

  const SaveOrEditPostContainsError({required this.message});
}

class SaveOrEditPostIsLoading implements SaveOrEditPostState {
  const SaveOrEditPostIsLoading();
}
