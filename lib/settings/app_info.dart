import 'package:flutter/material.dart';

import '../components.dart';
import '../utils/global_functions.dart';

final packageInfoProvider = FutureProvider<InfoModel>((ref) async {
  return await PackageInfo.fromPlatform()
      .then((value) => InfoModel(packageInfo: value));
});

class InfoModel {
  PackageInfo packageInfo;
  InfoModel({
    required this.packageInfo,
  });

  String get appName => packageInfo.appName;
  String get packageName => packageInfo.packageName;
  String get version => packageInfo.version;
  String get buildNumber => packageInfo.buildNumber;
}

class AppInfoWidget extends ConsumerWidget {
  const AppInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(packageInfoProvider);

    return ListTile(
      leading: const Icon(Icons.info),
      title: const Text('About'),
      subtitle: Text(
        'version : ${info.value!.version}',
        style: Theme.of(context).textTheme.subtitle2!,
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        GlobalFunctions.showSnackBar(context,
            '${info.value!.packageName}+\n${info.value!.version}+\n${info.value!.buildNumber}');
      },
    );
  }
}
