import 'package:ecommerce/apps/auth_widget.dart';
import 'package:ecommerce/apps/pages/admin/admin_home.dart';
import 'package:ecommerce/apps/pages/sign_in_page.dart';
import 'package:ecommerce/apps/pages/user/user_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.orange,
        ),
      ),
      home: AuthWidget(
        signedInBuilder: (context) => const UserHome(),
        nonSignedInBuilder: (_) => const SignInPage(),
        adminSignedInBuilder: (context) => const AdminHome(),
      ),
    );
  }
}
