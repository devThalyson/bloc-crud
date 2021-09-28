import 'package:bloc_crud/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomSelectPhotoModal {
  static showModal({
    required BuildContext context,
    required Function openCamera,
    required Function openGallery,
  }) {
    showModalBottomSheet(
      context: context,
      elevation: 10,
      builder: (context) {
        return Container(
          height: 130,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    await openCamera();
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 45,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          'Câmera',
                          style: AppTextStyles.bottomNavigationTitle,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    await openGallery();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_album_outlined,
                          size: 45,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          'Galeria',
                          style: AppTextStyles.bottomNavigationTitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
