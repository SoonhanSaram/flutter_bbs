import 'package:flutter/material.dart';
import 'package:flutter_bbs/color_schemes.g.dart';
import 'package:flutter_bbs/comps/board_list.dart';
import 'package:flutter_bbs/comps/index.dart';
import 'package:flutter_bbs/comps/join.dart';
import 'package:flutter_bbs/comps/login.dart';
import 'package:flutter_bbs/comps/post_detail.dart';
import 'package:flutter_bbs/comps/write_post.dart';
import 'package:flutter_bbs/provider/functions_basic.dart';
import 'package:flutter_bbs/provider/functions_post.dart';
import 'package:flutter_bbs/provider/functions_user.dart';
import 'package:flutter_bbs/provider/functions_writing.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlutterBbs());
}

class FlutterBbs extends StatelessWidget {
  const FlutterBbs({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FunctionsBasic(),
        ),
        ChangeNotifierProvider(
          create: (_) => FunctionsWriting(),
        ),
        ChangeNotifierProvider(
          create: (_) => FunctionsPost(),
        ),
        ChangeNotifierProvider(
          create: (_) => FunctionsUser(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "BBS연습",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => const Index(),
          '/board': (context) => const BoardList(),
          '/writePost': (context) => const WritingPost(),
          '/postDetail': (context) => const PostDetail(),
          '/join': (context) => const JoinPage(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
