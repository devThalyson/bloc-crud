import 'package:bloc_crud/shared/models/post_model.dart';

abstract class SaveOrEditPostEvent {}

class SavePostEvent implements SaveOrEditPostEvent {
  final PostModel postModel;
  const SavePostEvent({required this.postModel});
}

class UpdatePostEvent implements SaveOrEditPostEvent {
  final PostModel postModel;
  const UpdatePostEvent({required this.postModel});
}

class DeletePostEvent implements SaveOrEditPostEvent {
  final PostModel postModel;
  const DeletePostEvent({required this.postModel});
}

class ChangePhotoPostEvent implements SaveOrEditPostEvent {
  const ChangePhotoPostEvent();
}
