import 'package:bloc_crud/modules/list_of_posts/state_management/list_of_posts_bloc.dart';
import 'package:bloc_crud/modules/save_or_edit_post/state_management/save_or_edit_post_bloc.dart';
import 'package:bloc_crud/modules/save_or_edit_post/state_management/save_or_edit_post_event.dart';
import 'package:bloc_crud/shared/database/database_helper.dart';
import 'package:bloc_crud/shared/models/post_model.dart';
import 'package:bloc_crud/shared/widgets/custom_photo_modal/custom_photo_modal.dart';
import 'package:bloc_crud/shared/widgets/custom_snackbar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GlobalController {
  final DatabaseHelper databaseHelper;

  GlobalController({required this.databaseHelper});

  ///// Blocs /////
  late final listOfPostsBloc = ListOfPostsBloc(
    databaseHelper: databaseHelper,
  );
  late final saveOrEditBloc = SaveOrEditPostBloc(
    databaseHelper: databaseHelper,
  );
  ///// Blocs /////

  ///// Text Form /////
  final titleTextFormController = TextEditingController();
  final descriptionTextFormController = TextEditingController();
  ///// Text Form /////

  ///// Modelo de Post que vai ser salvo (ou atualizado) /////
  PostModel? postModel;
  ///// Modelo de Post que vai ser salvo (ou atualizado) /////

  ///// Image Picker //////
  final imagePicker = ImagePicker();
  XFile? imagePost;
  ///// Image Picker //////

  ///// Métodos //////
  void getPosts() {
    listOfPostsBloc.add(VoidCallback);
  }

  void saveOrEditPost({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) {
    if (formKey.currentState!.validate()) {
      if (postModel!.id == null) {
        postModel = postModel!.copyWith(
          creationDate: DateTime.now().toString(),
          photoUrl: imagePost != null ? imagePost!.path : '',
        );
      } else {
        postModel = postModel!.copyWith(
          photoUrl: imagePost!.path,
        );
      }

      if (postModel!.id == null) {
        saveOrEditBloc.add(
          SavePostEvent(postModel: postModel!),
        );
      } else {
        saveOrEditBloc.add(UpdatePostEvent(postModel: postModel!));
      }

      getPosts();

      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        CustomSnackBar(
          textContent: 'Salvo com sucesso!',
        ),
      );
    }
  }

  void deletePost(BuildContext context) {
    saveOrEditBloc.add(DeletePostEvent(postModel: postModel!));

    getPosts();

    Navigator.pop(context);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      CustomSnackBar(
        textContent: 'Deletado com sucesso!',
      ),
    );
  }

  void openPhotoModal({required BuildContext context}) {
    CustomSelectPhotoModal.showModal(
      context: context,
      openCamera: openCamera,
      openGallery: openGallery,
    );
  }

  void openCamera() async {
    imagePost = await imagePicker.pickImage(source: ImageSource.camera);
    saveOrEditBloc.add(ChangePhotoPostEvent());
  }

  void openGallery() async {
    imagePost = await imagePicker.pickImage(source: ImageSource.gallery);
    saveOrEditBloc.add(ChangePhotoPostEvent());
  }

  void onFormChange({String? title, String? description}) {
    postModel = postModel!.copyWith(
      title: title,
      description: description,
    );
  }

  void clearForm() {
    titleTextFormController.text = '';
    descriptionTextFormController.text = '';

    postModel = null;

    imagePost = null;
  }

  void initializePostFields({PostModel? existingPostModel}) {
    if (existingPostModel != null) {
      titleTextFormController.text = existingPostModel.title!;
      descriptionTextFormController.text = existingPostModel.description!;
      postModel = existingPostModel;
      imagePost = XFile(
        existingPostModel.photoUrl!,
      );
    } else {
      postModel = PostModel();
    }
  }
  ///// Métodos //////

}
