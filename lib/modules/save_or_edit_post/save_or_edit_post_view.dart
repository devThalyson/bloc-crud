import 'dart:io';

import 'package:bloc_crud/modules/save_or_edit_post/state_management/save_or_edit_post_bloc.dart';
import 'package:bloc_crud/modules/save_or_edit_post/state_management/save_or_edit_post_state.dart';
import 'package:bloc_crud/shared/controllers/global_controller.dart';
import 'package:bloc_crud/shared/database/database_helper.dart';
import 'package:bloc_crud/shared/models/post_model.dart';
import 'package:bloc_crud/shared/theme/app_colors.dart';
import 'package:bloc_crud/shared/theme/app_text_styles.dart';
import 'package:bloc_crud/shared/validators/validators.dart';
import 'package:bloc_crud/shared/widgets/custom_alert/custom_alert.dart';
import 'package:bloc_crud/shared/widgets/custom_snackbar/custom_snack_bar.dart';
import 'package:bloc_crud/shared/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SaveOrEditPostView extends StatefulWidget {
  final PostModel? postModel;

  SaveOrEditPostView({
    this.postModel,
  });

  @override
  _SaveOrEditPostViewState createState() => _SaveOrEditPostViewState();
}

class _SaveOrEditPostViewState extends State<SaveOrEditPostView> {
  var _globalController = GlobalController(databaseHelper: DatabaseHelper());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _globalController = context.read<GlobalController>();
    _globalController.initializePostFields(
      existingPostModel: widget.postModel,
    );
    super.initState();
  }

  @override
  void dispose() {
    _globalController.clearForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          Visibility(
            visible: widget.postModel != null,
            child: IconButton(
              onPressed: () => CustomAlert(
                title: 'Atenção',
                body: 'Deseja continuar com a deleção do Post?',
                function: () => _globalController.deletePost(context),
              ).showDialog(context),
              icon: Icon(
                Icons.delete,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(
          persistenceFunction: () => _globalController.saveOrEditPost(
                context: context,
                formKey: _formKey,
              ),
          titlePersistenceButton:
              widget.postModel != null ? 'Editar' : 'Salvar'),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilder<SaveOrEditPostBloc, SaveOrEditPostState>(
      bloc: _globalController.saveOrEditBloc,
      builder: (context, state) {
        if (state is SaveOrEditPostContainsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              textContent: state.message,
              isErrorSnackbar: true,
            ),
          );

          return _isSucess();
        }

        if (state is SaveOrEditPostIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return _isSucess(
          photoUrl: _globalController.imagePost != null
              ? _globalController.imagePost!.path
              : null,
        );
      },
    );
  }

  Widget _isSucess({String? photoUrl}) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Text(
                widget.postModel != null
                    ? 'Editar Post'
                    : 'Adicionar novo Post',
                style: AppTextStyles.primaryMessage,
              ),
            ),
            _photoComponent(
              photoUrl: photoUrl,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelTitle: 'Título',
                    inputAction: TextInputAction.next,
                    controller: context
                        .read<GlobalController>()
                        .titleTextFormController,
                    validator: Validators.requiredField,
                    onChanged: (value) {
                      _globalController.onFormChange(
                        title: value,
                      );
                    },
                  ),
                  CustomTextField(
                    labelTitle: 'Descrição',
                    inputAction: TextInputAction.done,
                    maxLines: null,
                    controller: context
                        .read<GlobalController>()
                        .descriptionTextFormController,
                    validator: Validators.requiredField,
                    onChanged: (value) => _globalController.onFormChange(
                      description: value,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoComponent({
    String? photoUrl,
  }) {
    return GestureDetector(
      onTap: () => _globalController.openPhotoModal(context: context),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.black.withOpacity(
                0.2,
              ),
            ),
          ],
        ),
        child: photoUrl != null && photoUrl.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.file(
                  File(
                    photoUrl,
                  ),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text(
                      'Adicionar Foto',
                      style: AppTextStyles.subTitlePost,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Icon(
                      Icons.photo_library_rounded,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _bottomNavigationBar({
    required String titlePersistenceButton,
    required VoidCallback persistenceFunction,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          color: AppColors.lightGrey,
          height: 1,
        ),
        Row(
          children: [
            _bottomNavigationButton(
              title: 'Cancelar',
              style: AppTextStyles.bottomNavigationTitle,
              callback: () => Navigator.pop(context),
            ),
            Container(
              height: 45,
              width: 0.5,
              color: AppColors.lightGrey,
            ),
            _bottomNavigationButton(
              title: titlePersistenceButton,
              style: AppTextStyles.bottomNavigationTitlePrimary,
              callback: persistenceFunction,
            ),
          ],
        ),
      ],
    );
  }

  Widget _bottomNavigationButton({
    required String title,
    required TextStyle style,
    required VoidCallback callback,
  }) {
    return Expanded(
      child: InkWell(
        onTap: callback,
        child: Container(
          height: 45,
          decoration: BoxDecoration(),
          alignment: Alignment.center,
          child: Text(
            title,
            style: style,
          ),
        ),
      ),
    );
  }
}
