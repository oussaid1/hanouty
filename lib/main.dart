import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'auth/auth_services.dart';
import 'components.dart';
import 'database/database.dart';
import 'database/database_operations.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final storage = await HydratedStorage.build(
  //     storageDirectory: await getApplicationDocumentsDirectory());
  final initialization = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: const FirebaseOptions(
    //   apiKey: 'AIzaSyANojHl-JzTxGGmM3wHGTzHSjllBOTQOxk',
    //   appId: '1:116797597909:web:372e234e1a8c1d28e9da5c',
    //   messagingSenderId: '116797597909',
    //   projectId: 'hanouty-6a822',
    //   authDomain: 'hanouty-6a822.firebaseapp.com',
    //   storageBucket: 'hanouty-6a822.appspot.com',
    //   measurementId: 'G-7DLL9CW9MT',
    // ),
  );
  //final Future<FirebaseApp> initialization = Firebase.initializeApp();
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'DF4CF65C-3AF1-42EE-B713-2A1BE550B524',
  // );
  await EasyLocalization.ensureInitialized();

  /// register Database singleton
  GetIt.I.registerSingleton<Database>(Database(null));
  GetIt.I.registerSingleton<DatabaseOperations>(
      DatabaseOperations(GetIt.I<Database>()));
  GetIt.I.registerSingleton<AuthService>(AuthService(FirebaseAuthService()));
  // HydratedBlocOverrides.runZoned(
  //     storage: storage,
  //   () =>

  runApp(ProviderScope(
    child: EasyLocalization(
        //saveLocale: true,
        supportedLocales: const [
          Locale('ar', ''),
          Locale('fr', ''),
          Locale('en', '')
        ],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', ''),
        useOnlyLangCode: true,
        saveLocale: false,
        startLocale: const Locale('en', ''),
        assetLoader: const RootBundleAssetLoader(),
        child: App(
            initialization: initialization,
            authService: AuthService(
              FirebaseAuthService(),
              // GetIt.I.get<DatabaseOperations>(),
            ))),
  ));
}
