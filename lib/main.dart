import 'package:flutter/material.dart';
import 'package:flutter_bbs/color_schemes.g.dart';
import 'package:flutter_bbs/comps/index.dart';
import 'package:flutter_bbs/provider/functions_basic.dart';
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
        ChangeNotifierProvider(create: (_) => FunctionsBasic()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "BBS연습",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => const Index(),
        },
      ),
    );
  }
}
