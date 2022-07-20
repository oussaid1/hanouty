import 'package:hanouty/screens/dashboard/dashboard_tab.dart';
import 'package:hanouty/screens/device_specific/homeforweb/home_for_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'blocs/authbloc/auth_bloc.dart';
import 'cubits/usermodel_cubit/user_model_cubit.dart';
import 'database/database.dart';
import 'screens/sales/sales_tab.dart';
import 'utils/global_functions.dart';
import 'routes/routes.dart';
import 'screens/splash/splash_login_signup.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticationFailedState) {
          GlobalFunctions.showErrorSnackBar(
            context,
            state.error,
          );
          Navigator.of(context).pushReplacementNamed('/login');
        }

        if (state is UnauthenticatedState) {
          Navigator.of(context).pushNamed('/');
        }

        if (state is AuthenticatedState) {
          GlobalFunctions.showSuccessSnackBar(
            context,
            'Welcome ${state.user.email}',
          );
          Navigator.pushNamed(context, RouteGenerator.root);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitState) {
            return const SplashPage();
          }
          if (state is AuthenticatedState) {
            GetIt.I<Database>().setUserUid(state.user.uid);
            //var database = GetIt.I<Database>();
            context.read<UserModelCubit>().loadUser();
            return HomeForAll(
              title: 'Dashboard',
              centreWidget: BlocProvider(
                create: (context) => UserModelCubit(),
                child: const SalesTab(),
              ),
            );
          }
          if (state is UnauthenticatedState) {
            return const SplashPage();
          }
          return Container();
        },
      ),
    );
  }
}
