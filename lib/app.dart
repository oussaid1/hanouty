import 'package:flutter/material.dart';

import 'blocs/authbloc/auth_bloc.dart';

import 'blocs/loginbloc/login_bloc.dart';
import 'blocs/signupbloc/signup_bloc.dart';
import 'components.dart';
import 'cubits/usermodel_cubit/user_model_cubit.dart';
import 'database/database.dart';
import 'local_components.dart';
import 'providers/localization_provider.dart';
import 'root.dart';
import 'routes/routes.dart';
import 'services/auth_service.dart';
import 'settings/themes.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.initialization, required this.authService})
      : super(key: key);
  final FirebaseApp initialization;
  final AuthService authService;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: (context) => authService,
        ),
        RepositoryProvider.value(
          value: (context) => Database(''),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authService),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              AuthBloc(authService),
              authService,
            ),
          ),

          /// sign up bloc
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              AuthBloc(authService),
              authService,
            ),
          ),
          BlocProvider<UserModelCubit>(
            create: (context) => UserModelCubit()..loadUser(),
          ),
        ],
        child: Hanouty(initialization: initialization),
      ),
    );
  }
}

class Hanouty extends ConsumerWidget {
  const Hanouty({Key? key, required this.initialization}) : super(key: key);
  final FirebaseApp initialization;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var appThemeState = ref.watch(appThemeStateNotifier);
    var appLocalState = ref.watch(appLocalStateNotifier);
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hanouty',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: appLocalState.locale,
        theme: MThemeData.lightThemeData,
        //darkTheme: MThemeData.darkThemeData,
        //themeMode: appThemeState.darkMode ? ThemeMode.dark : ThemeMode.light,
        initialRoute: RouteGenerator.root,
        home: const Root(), // StartPage(initialization: initialization),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Future<FirebaseApp> initialization;

  const StartPage({Key? key, required this.initialization}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something Went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const Root();
        }
        //loading
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
