import 'dart:developer';

import 'package:hanouty/local_components.dart';

import '../../../blocs/clientsbloc/clients_bloc.dart';
import '/../components.dart';
import 'package:flutter/material.dart';

class AddClient extends ConsumerStatefulWidget {
  const AddClient({
    Key? key,
    this.client,
    required this.pContext,
  }) : super(key: key);
  final ShopClientModel? client;
  final BuildContext pContext;
  @override
  AddClientState createState() => AddClientState();
}

class AddClientState extends ConsumerState<AddClient> {
  bool _canSave = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController =
      TextEditingController(text: 'oussaid');
  final TextEditingController phoneController =
      TextEditingController(text: '0687888888');
  final TextEditingController emailController =
      TextEditingController(text: 'oussaid.abdellatif@gmail.com');

  void clear() {
    titleController.clear();
    phoneController.clear();
    emailController.clear();
  }

  @override
  void initState() {
    if (widget.client != null) {
      titleController.text = widget.client!.clientName.toString();
      phoneController.text = widget.client!.phone.toString();
      emailController.text = widget.client!.email.toString();
      ref.read(clientRaringProvider.state).state = widget.client!.stars;
    }
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    log('add stuff ${context.widget}');
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Column(
        children: [
          buildFlexible(context, ref),
        ],
      ),
    );
  }

  Flexible buildFlexible(BuildContext context, WidgetRef ref) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 2,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          width: Responsive.isDesktop(context) ? 600 : context.width - 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            //color: Theme.of(context).colorScheme.onBackground,
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  buildClientName(ref),
                  const SizedBox(height: 20),
                  buildClientPhone(ref),
                  const SizedBox(height: 20),
                  buildClientEmail(ref),
                  const SizedBox(height: 20),
                  buildRating(ref, context),
                  const SizedBox(height: 20),
                  buildSaveButton(ref, context),
                  const SizedBox(
                    height: 100,
                  ) //but
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildSaveButton(WidgetRef ref, BuildContext context) {
    return widget.client != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: MThemeData.raisedButtonStyleSave,
                child: Text(
                  'Update'.tr(),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final client = ShopClientModel(
                      id: widget.client!.id,
                      clientName: titleController.text.trim(),
                      phone: phoneController.text.trim(),
                      email: emailController.text.trim(),
                      stars: ref.read(clientRaringProvider.state).state,
                    );
                    context
                        .read<ShopClientBloc>()
                        .add(AddShopClientEvent(client));
                    Navigator.pop(context);
                  }
                },
              ),
              ElevatedButton(
                style: MThemeData.raisedButtonStyleCancel,
                child: Text(
                  'Cancel'.tr(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: MThemeData.raisedButtonStyleSave,
                child: Text(
                  'Save'.tr(),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final client = ShopClientModel(
                      clientName: titleController.text.trim(),
                      phone: phoneController.text.trim(),
                      email: emailController.text.trim(),
                      stars: ref.read(clientRaringProvider.state).state,
                    );
                    widget.pContext
                        .read<ShopClientBloc>()
                        .add(AddShopClientEvent(client));
                    Navigator.pop(context);
                    // ref.read(databaseProvider)!.addClient(client).then((value) {
                    //   if (value) {
                    //     ScaffoldMessenger.of(context)
                    //         .showSnackBar(MDialogs.snackBar('Done !'));
                    //     clear();
                    //     Navigator.of(context).pop();
                    //   } else {
                    //     ScaffoldMessenger.of(context)
                    //         .showSnackBar(MDialogs.errorSnackBar('Error !'));
                    //   }
                    // });
                  }
                },
              ),
              ElevatedButton(
                style: MThemeData.raisedButtonStyleCancel,
                child: Text(
                  'Cancel'.tr(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
  }

  TextFormField buildClientName(WidgetRef ref) {
    return TextFormField(
      controller: titleController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      onChanged: (text) {
        setState(() {
          _canSave = true;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'Client name'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
        labelText: 'Client-name'.tr(),
      ),
    );
  }

  TextFormField buildClientPhone(WidgetRef ref) {
    return TextFormField(
      controller: phoneController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'phone number'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.phone),
        filled: true,
        labelText: 'Phone'.tr(),
      ),
    );
  }

  TextFormField buildClientEmail(WidgetRef ref) {
    return TextFormField(
      controller: emailController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'email'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.email),
        filled: true,
      ),
    );
  }

  Row buildRating(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 8,
          ),
          child: Text(
            'Reputation'.tr(),
            style: Theme.of(context).textTheme.subtitle2!,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).bottomAppBarColor),
              borderRadius: BorderRadius.circular(6)),
          height: 50,
          width: 160,
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.thumb_down_alt_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    if (ref.read(clientRaringProvider.state).state > 0) {
                      ref.read(clientRaringProvider.state).state -= 1;
                    }
                  }),
              Expanded(
                child: Consumer(
                  // 2. specify the builder and obtain a WidgetRef
                  builder: (_, WidgetRef ref, __) {
                    // 3. use ref.ref.watch() to get the value of the provider
                    final value = ref.watch(clientRaringProvider.state).state;
                    return Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1,
                    );
                  },
                ),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.thumb_up_alt_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    ref.read(clientRaringProvider.state).state += 1;
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

final clientRaringProvider = StateProvider<int>((ref) {
  return 1;
});
