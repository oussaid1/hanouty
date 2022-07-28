import 'package:flutter/material.dart';

import 'blocs/authbloc/auth_bloc.dart';
import 'blocs/clientsbloc/clients_bloc.dart';
import 'blocs/datefilterbloc/date_filter_bloc.dart';
import 'blocs/debtbloc /debt_bloc.dart';
import 'blocs/expensesbloc/expenses_bloc.dart';
import 'blocs/fullsalesbloc/fullsales_bloc.dart';
import 'blocs/incomebloc/income_bloc.dart';
import 'blocs/loginbloc/login_bloc.dart';
import 'blocs/paymentsbloc/payments_bloc.dart';
import 'blocs/productbloc/product_bloc.dart';
import 'blocs/salesbloc/sales_bloc.dart';
import 'blocs/sellactionsbloc/sellactions_bloc.dart';
import 'blocs/signupbloc/signup_bloc.dart';
import 'blocs/suplierbloc/suplier_bloc.dart';
import 'blocs/techservicebloc/techservice_bloc.dart';
import 'components.dart';
import 'cubits/usermodel_cubit/user_model_cubit.dart';
import 'database/database.dart';
import 'database/database_operations.dart';
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
          // BlocProvider(
          //   create: (context) =>
          //       ProductBloc(databaseOperations: GetIt.I<DatabaseOperations>())
          //         ..add(GetProductsEvent()),
          // ),
          // BlocProvider(
          //   create: (context) => SellActionsBloc(GetIt.I<DatabaseOperations>()),
          // ),
          // BlocProvider(
          //   create: (context) =>
          //       SalesBloc(databaseOperations: GetIt.I<DatabaseOperations>())
          //         ..add(GetSalesEvent()),
          // ),
          // BlocProvider(
          //   create: (context) =>
          //       FullSalesBloc(databaseOperations: GetIt.I<DatabaseOperations>())
          //         ..add(GetFullSalesEvent()),
          // ),
          // BlocProvider(
          //   create: (context) =>
          //       DebtBloc(databaseOperations: GetIt.I<DatabaseOperations>())
          //         ..add(GetDebtEvent()),
          // ),
          // BlocProvider(
          //   create: (context) =>
          //       ExpenseBloc(databaseOperations: GetIt.I<DatabaseOperations>())
          //         ..add(GetExpensesEvent()),
          // ),
          // BlocProvider(
          //   create: (context) =>
          //       IncomeBloc(databaseOperations: GetIt.I<DatabaseOperations>())
          //         ..add(GetIncomeEvent()),
          // ),
          // BlocProvider(
          //   create: (context) => ShopClientBloc(
          //       databaseOperations: GetIt.I<DatabaseOperations>())
          //     ..add(GetShopClientsEvent()),
          // ),
          // BlocProvider(
          //   create: (context) =>
          //       SuplierBloc(databaseOperations: GetIt.I<DatabaseOperations>())
          //         ..add(GetSupliersEvent()),
          // ),
          // BlocProvider(
          //   create: (context) => TechServiceBloc(
          //       databaseOperations: GetIt.I<DatabaseOperations>())
          //     ..add(GetTechServiceEvent()),
          // ),
          // BlocProvider(
          //   create: (context) =>
          //       PaymentsBloc(databaseOperations: GetIt.I<DatabaseOperations>())
          //         ..add(GetPaymentsEvent()),
          // ),
          // BlocProvider(
          //   create: (context) => DateFilterBloc()
          //     ..add(const UpdateFilterEvent(filterType: DateFilter.all)),
          // ),
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
