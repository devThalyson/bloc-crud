import 'package:bloc_crud/shared/models/post_model.dart';
import 'package:bloc_crud/shared/theme/app_text_styles.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloc_crud/shared/utils/functions/extensions.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback callback;

  PostCard({
    required this.post,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 35,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            post.photoUrl!.isNotEmpty
                ? Image.file(
                    File(post.photoUrl!),
                    width: double.infinity,
                    height: 210,
                    fit: BoxFit.cover,
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 210,
                    width: double.infinity,
                    child: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        post.title!,
                        style: AppTextStyles.titlePost,
                      ),
                      Text(
                        post.creationDate!.converterDate(),
                        style: AppTextStyles.subTitlePost,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    post.description!,
                    style: AppTextStyles.subTitlePost,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
