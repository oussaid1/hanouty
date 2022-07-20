import 'package:hanouty/settings/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/usermodel_cubit/user_model_cubit.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: MThemeData.white.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: const Icon(Icons.account_circle_sharp, size: 30)),
        BlocBuilder<UserModelCubit, UserModelState>(builder: (context, state) {
          if (state is UserModelInitial) {
            return Text('Loading...',
                style: Theme.of(context).textTheme.subtitle2!);
          }
          if (state is UserModelInitial) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text('...!', style: Theme.of(context).textTheme.subtitle2!),
            );
          }
          if (state is UserModelLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${state.user.name}',
                  style: Theme.of(context).textTheme.subtitle2!),
            );
          }
          if (state is UserModelLoading) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text('...!', style: Theme.of(context).textTheme.subtitle2!),
            );
          }
          return const CircularProgressIndicator();
        }),
      ],
    );
  }
}
