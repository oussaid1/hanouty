import 'package:hanouty/settings/info_model.dart';

import '../../components.dart';

final packageInfoProvider = FutureProvider<InfoModel>((ref) async {
  return await PackageInfo.fromPlatform()
      .then((value) => InfoModel(packageInfo: value));
});
