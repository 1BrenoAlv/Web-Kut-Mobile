import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_kut/core/routes/routes.dart';
import 'package:web_kut/ui/viewmodels/auth_view_model.dart';
import 'package:web_kut/ui/viewmodels/posts_view_model.dart';
import 'package:web_kut/ui/viewmodels/users_view_model.dart';

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostsViewModel()),
        ChangeNotifierProvider(create: (_) => UsersViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initialPage,
        routes: Routes.routes,
      ),
    );
  }
}
