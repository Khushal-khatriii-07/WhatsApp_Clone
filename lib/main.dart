import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/Common/routes/routes.dart';
import 'package:whatsapp_clonee/Common/theme/dark_theme.dart';
import 'package:whatsapp_clonee/Common/theme/light_theme.dart';
import 'package:whatsapp_clonee/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clonee/feature/home/pages/home_page.dart';
import 'package:whatsapp_clonee/feature/welcome/pages/welcome_page.dart';
import 'package:whatsapp_clonee/firebase_options.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp clone',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: ref.watch(userInfoAuthProvider).when(
          data: (user){
            FlutterNativeSplash.remove();
            if(user == null) return WelcomePage();
            return HomePage();
          },
          error: (error, trace){
            return const Scaffold(
              body: Center(child: Text('something wrong happened!')),
            );
          },
          loading: (){
            return SizedBox();
          }
      ),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}


