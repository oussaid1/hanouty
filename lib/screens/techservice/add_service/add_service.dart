import 'package:hanouty/local_components.dart';

import 'package:hanouty/widgets/select_or_add/select_or_add_cat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '/../components.dart';
import 'package:flutter/material.dart';

class AddService extends ConsumerStatefulWidget {
  const AddService({Key? key, this.techService}) : super(key: key);
  final TechServiceModel? techService;
  @override
  AddServiceState createState() => AddServiceState();
}

class AddServiceState extends ConsumerState<AddService> {
  final GlobalKey<FormState> mformKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  // final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceInController = TextEditingController();
  final TextEditingController priceOutController = TextEditingController();
  final TextEditingController descrController = TextEditingController();
  // String serviceCat = '';
  void clear() {
    titleController.clear();
    priceInController.clear();
    priceOutController.clear();
  }

  @override
  void initState() {
    if (widget.techService != null) {
      titleController.text = widget.techService!.title.toString();
      priceInController.text = widget.techService!.priceIn.toString();
      priceOutController.text = widget.techService!.priceOut.toString();
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
    return SizedBox(
      width: 300,
      height: 800,
      child: Column(
        children: const [
          //InStockWidget(dBTechServices: dBTechServices),
          // buildFlexible(context, ref, techServiceList),
        ],
      ),
    );
  }

  Flexible buildFlexible(
      BuildContext context, WidgetRef ref, List<String> techServiceList) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              SelectOrAddNewDropDown(
                list: techServiceList,
                hintText: "Service-Type".tr(),
                onSaved: (value) {},
              ),
              Form(
                key: mformKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    buildTechServiceName(ref),
                    const SizedBox(height: 20),
                    buildPriceIn(ref),
                    const SizedBox(height: 20),
                    buildPriceOut(ref),
                    const SizedBox(height: 20),
                    buildAvailability(ref, context),
                    const SizedBox(height: 20),
                    buildDescription(),
                    const SizedBox(height: 40),
                    buildSaveButton(ref, context),
                    const SizedBox(
                      height: 100,
                    ) //but
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildSaveButton(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: MThemeData.raisedButtonStyleSave,
          child: Text(
            'Save'.tr(),
          ),
          onPressed: () {
            // if (mformKey.currentState?.validate() ?? false) {
            //   final techService = TechServiceModel(
            //     description: descrController.text.trim(),
            //     timeStamp: DateTime.now(),
            //     available: ref.read(techServAvailProvider.state).state,
            //     type: ref.watch(selectedSelectOrAddCat.state).state!,
            //     title: titleController.text.trim(),
            //     priceIn: double.tryParse(priceInController.text.trim())!,
            //     priceOut: double.tryParse(priceOutController.text.trim())!,
            //   );

            //   ref
            //       .read(databaseProvider)!
            //       .addTechService(techService)
            //       .then((value) => MDialogs.snackBar("success".tr()))
            //       .then((value) => clear());
            // } else {
            //   MDialogs.snackBar("error".tr());
            // }
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

  Widget buildDescription() {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      width: 240,
      child: TextFormField(
        controller: descrController,
        validator: (text) {
          return null;
        },
        maxLines: 4,
        decoration: InputDecoration(
          labelText: 'Description'.tr(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: 'description_hint'.tr(),
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          filled: true,
        ),
      ),
    );
  }

  TextFormField buildPriceOut(WidgetRef ref) {
    return TextFormField(
        controller: priceOutController,
        validator: (text) {
          if (text!.trim().isEmpty) {
            return "error".tr();
          }
          return null;
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
        ],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: '1434 dh',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          contentPadding: const EdgeInsets.only(top: 4),
          filled: true,
          labelText: 'Price-out'.tr(),
          prefixIcon: const Icon(Icons.monetization_on),
        ));
  }

  TextFormField buildPriceIn(WidgetRef ref) {
    return TextFormField(
        controller: priceInController,
        validator: (text) {
          if (text!.trim().isEmpty) {
            return "error".tr();
          }
          return null;
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
        ],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: '1234 \$',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          contentPadding: const EdgeInsets.only(top: 4),
          filled: true,
          labelText: 'Price-in'.tr(),
          prefixIcon: const Icon(Icons.monetization_on_outlined),
        ));
  }

  TextFormField buildTechServiceName(WidgetRef ref) {
    return TextFormField(
      controller: titleController,
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
        hintText: 'name the service'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.adb_sharp),
        filled: true,
        labelText: 'Service-Name'.tr(),
      ),
    );
  }

  Autocomplete<String> builAutocomleteCat(kOptions) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return kOptions.where((String option) {
          return option.contains(textEditingValue.text);
        });
      },
      onSelected: (String selection) {
        // ref.read(techServiceTypeProvider.state).state = selection;
        // print('You just selected $selection');
      },
    );
  }

  Row buildAvailability(WidgetRef ref, BuildContext context) {
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
            'Availibility'.tr(),
            style: Theme.of(context).textTheme.subtitle2!,
          ),
        ),
        CupertinoSwitch(
            activeColor: MThemeData.accentColor,
            value: false,
            onChanged: (value) {
              // ref.read(techServAvailProvider.state).state = value;
            }),
      ],
    );
  }
}
