import 'package:bloc_crud/modules/list_of_posts/list_of_posts_view.dart';
import 'package:bloc_crud/modules/save_or_edit_post/save_or_edit_post_view.dart';
import 'package:bloc_crud/shared/models/post_model.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    // Tela inicial do app
    '/listOfPostsView': (BuildContext context) => ListOfPostsView(),

    // Tela onde o usuário pode adicionar ou editar um post
    '/saveOrEditPostView': (BuildContext context) => SaveOrEditPostView(
          postModel: ModalRoute.of(context)!.settings.arguments != null
              ? ModalRoute.of(context)!.settings.arguments as PostModel
              : null,
        ),
  };
}
