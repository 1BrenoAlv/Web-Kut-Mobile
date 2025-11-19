import 'package:flutter/material.dart';
import 'package:web_kut/ui/views/navigator_bar.dart';
// import 'package:web_kut/ui/views/widgets/perfil/meus_posts_view.dart';

class Routes {
  static const String initialPage = '/';
  static const String login = '/login';
  static const String meusPosts = '/meus_posts';

  static Map<String, WidgetBuilder> get routes {
    return {
      initialPage: (context) => const NavigatorBar(),
      // meusPosts: (context) => const MeusPostsView(),
    };
  }
}
