import 'package:affinity/Widget/login_widget.dart';
import 'package:affinity/Widget/signup_widget.dart';
import 'package:affinity/crushscreen.dart';
import 'package:affinity/services/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:affinity/homescreen.dart';
import 'package:affinity/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
//...
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        Provider<FireBaseAuthMethods>(
          create: (_) => FireBaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FireBaseAuthMethods>().authState,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Affinity',
        initialRoute: '/',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.red,
        ),
        routes: {
          '/home': (context) => const MyHomePage(
                  currentScreen: HomeScreen(
                isLogin: true,
              )),
          '/crushlist': (context) =>
              const MyHomePage(currentScreen: CrushScreen()),
          '/signin': (context) => const MyHomePage(
                  currentScreen: LoginScreen(
                page: SignUpPage(),
              )),
          '/login': (context) => const MyHomePage(
                  currentScreen: LoginScreen(
                page: LoginPage(),
              )),
          '/crushscreen': (context) =>
              const MyHomePage(currentScreen: CrushScreen()),
        },
        home: const AuthWrapper(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.currentScreen});
  final Widget currentScreen;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade400,
        title: Text(
          "GET YOUR CRUSH THIS VALENTINE'S",
          softWrap: true,
          style: GoogleFonts.inconsolata(color: Colors.white),
        ),
        toolbarHeight: 40,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: const AssetImage("assets/image/logo-bg.png"),
                    height: min(120, screenSize.height * 0.50),
                    width: min(180, screenSize.width * 0.60),
                  ),
                  SizedBox(
                    height: min(8, screenSize.height * 0.01),
                  ),
                  currentScreen,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      //print(firebaseUser.emailVerified);
      return const MyHomePage(
          currentScreen: HomeScreen(
        isLogin: true,
      ));
    } else {
      return const MyHomePage(
          currentScreen: HomeScreen(
        isLogin: false,
      ));
    }
  }
}
