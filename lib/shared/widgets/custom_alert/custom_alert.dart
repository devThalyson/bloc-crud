import 'package:bloc_crud/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomAlert {
  final String title;
  final String body;
  final VoidCallback function;

  CustomAlert({
    required this.title,
    required this.body,
    required this.function,
  });

  showDialog(BuildContext context) {
    _onClickDialogOkorNot(
      context,
      title,
      body,
      function,
    );
  }
}

_onClickDialogOkorNot(
  BuildContext context,
  String title,
  String body,
  VoidCallback function,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        content: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyles.primaryMessage,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                body,
                style: AppTextStyles.titlePost,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  function();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Continuar',
                    style: AppTextStyles.snackbarMessage,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancelar',
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
