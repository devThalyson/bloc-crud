import 'package:bloc_crud/modules/list_of_posts/state_management/list_of_posts_bloc.dart';
import 'package:bloc_crud/modules/list_of_posts/state_management/list_of_posts_state.dart';
import 'package:bloc_crud/shared/controllers/global_controller.dart';
import 'package:bloc_crud/shared/database/database_helper.dart';
import 'package:bloc_crud/shared/models/post_model.dart';
import 'package:bloc_crud/shared/theme/app_text_styles.dart';
import 'package:bloc_crud/shared/widgets/post_card/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfPostsView extends StatefulWidget {
  @override
  _ListOfPostsViewState createState() => _ListOfPostsViewState();
}

class _ListOfPostsViewState extends State<ListOfPostsView> {
  var _globalController = GlobalController(databaseHelper: DatabaseHelper());

  @override
  void initState() {
    _globalController = context.read<GlobalController>();
    _globalController.getPosts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Meus Posts',
          style: AppTextStyles.appBarTitle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () => Navigator.pushNamed(
          context,
          '/saveOrEditPostView',
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilder<ListOfPostsBloc, ListOfPostsState>(
      bloc: _globalController.listOfPostsBloc,
      builder: (context, state) {
        if (state is ListOfPostsContainsError) {
          return _onError(state.message);
        }

        if (state is ListOfPostsIsLoading) {
          return _onLoading();
        }

        state = state as ListOfPostsIsLoaded;

        return _isSucess(state.posts);
      },
    );
  }

  Widget _onError(String message) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        message,
        style: AppTextStyles.errorMessage,
      ),
    );
  }

  Widget _onLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _isSucess(List<PostModel> posts) {
    return posts.isEmpty
        ? Container(
            alignment: Alignment.center,
            child: Text(
              'Lista de Posts vazia',
              style: AppTextStyles.primaryMessage,
            ),
          )
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, index) {
              PostModel post = posts[index];
              return PostCard(
                post: post,
                callback: () => Navigator.pushNamed(
                  context,
                  '/saveOrEditPostView',
                  arguments: post,
                ),
              );
            },
          );
  }
}
