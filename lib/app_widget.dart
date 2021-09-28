import 'package:bloc_crud/shared/controllers/global_controller.dart';
import 'package:bloc_crud/shared/database/database_helper.dart';
import 'package:bloc_crud/shared/navigation/app_routes.dart';
import 'package:bloc_crud/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => DatabaseHelper()),
        Provider(
          create: (_) => GlobalController(
            databaseHelper: _.read<DatabaseHelper>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Bloc Crud',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: AppColors.primaryColor,
        ),
        routes: AppRoutes.routes,
        initialRoute: '/listOfPostsView',
      ),
    );
  }
}
