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
  );
  //final Future<FirebaseApp> initialization = Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: '857DD3E9-DCE1-46B3-896F-56DE9E8EAB71',
  );
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
