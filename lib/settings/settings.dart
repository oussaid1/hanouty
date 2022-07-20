import 'package:hanouty/providers/pachage_info_provider.dart';
import 'package:hanouty/components.dart';
import 'package:hanouty/utils/constents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/global_functions.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final authService = ref.watch(authServicesProvider);
    //final user = ref.watch(userModelProvider);
    final info = ref.watch(packageInfoProvider);
    final globalFunction = ref.watch(globalFunctionsProvider);
    // final dateRangeState = ref.watch(dateRangeStateNotifier);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
            child: Column(
              children: [
                Column(
                  children: [
                    Text('Account Settings',
                        style: Theme.of(context).textTheme.bodyText1!),
                    Text(
                      'Update your settings like profile edit, change password etc.',
                      style: Theme.of(context).textTheme.subtitle2!,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: SizedBox(
                      width: 45,
                      height: 45,
                      child: CircleAvatar(
                        backgroundColor: AppConstants.whiteOpacity,
                        child: const Icon(
                          Icons.account_circle_outlined,
                          color: Colors.grey,
                          size: 35,
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '{user!.name}',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          '{user.email}',
                          style: Theme.of(context).textTheme.subtitle2!,
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const SizedBox(
                        width: 45, height: 45, child: Icon(Icons.lock)),
                    title: Text(
                      'Change Password',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    subtitle: const Text('change your password'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const SizedBox(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.share_outlined)),
                    title: Text(
                      'Share to Friends',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    subtitle: Text(
                      'Share your app with your friends',
                      style: Theme.of(context).textTheme.subtitle2!,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: SizedBox(
                            width: 45,
                            height: 45,
                            child: IconButton(
                                icon: const Icon(CupertinoIcons.power),
                                onPressed: () {
                                  globalFunction.buildSignOut(context);
                                }),
                          ),
                          title: Text(
                            'logout'.tr(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          subtitle: Text(
                            'logout and try different login'.tr(),
                            style: Theme.of(context).textTheme.subtitle2!,
                          ),
                          trailing: Text(
                            'version : ${info.value!.version}',
                            style: Theme.of(context).textTheme.subtitle2!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
