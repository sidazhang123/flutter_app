import 'package:flutter/material.dart';
import 'package:flutter_app/src/login.dart';
import 'package:flutter_app/src/news.dart';
import 'package:flutter_app/src/screens/webview_page.dart';

import 'screens/cat_screen.dart';

class CatAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      // Navigator.pushNamed() calls onGenerateRoute's callback to find a route
      onGenerateRoute: routes,
    );
  }

  Route routes(RouteSettings settings) {
    final Map<String, dynamic> param = settings.arguments;
    switch (settings.name) {
      case '/news':
        return newsRouteHandler(settings, param);
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/webview':
        return MaterialPageRoute(
            builder: (context) =>
                WebviewPage(param.containsKey('url') ? param['url'] : null));
      default:
      // the cat animation on the first screen
        return MaterialPageRoute(builder: (context) => CatScreen());
    }
  }

  // Helper function for route '/news'.
  // Route to news list when no args (index of news) are given
  // and to a news' comments page otherwise.
  MaterialPageRoute newsRouteHandler(RouteSettings settings,
      Map<String, dynamic> param) {
    {
      if (settings.arguments == null) {
        return MaterialPageRoute(builder: (context) => News(null));
      } else {
        return MaterialPageRoute(
            builder: (context) =>
                News(param.containsKey('id') ? param['id'] : null));
      }
    }
  }
}
