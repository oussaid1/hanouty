import 'dart:developer';

import 'package:hanouty/blocs/techservicebloc/techservice_bloc.dart';
import 'package:hanouty/local_components.dart';
import 'package:flutter/services.dart';
import 'package:hanouty/widgets/autocomplete/autocomlete_textfields.dart';
import '../../database/database_operations.dart';
import '/../components.dart';
import 'package:flutter/material.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key, this.techService}) : super(key: key);
  final TechServiceModel? techService;

  @override
  AddServiceState createState() => AddServiceState();
}

class AddServiceState extends State<AddService> {
  final GlobalKey<FormState> mformKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceInController = TextEditingController();
  final TextEditingController priceOutController = TextEditingController();
  final TextEditingController descrController = TextEditingController();
  String serviceCat = 'Service';
  DateTime createdAt = DateTime.now();
  bool _available = true;
  String description = 'legal only';
  bool _canSave = false;
  bool _isUpdate = false;

  /// clear all text fields
  void clear() {
    titleController.clear();
    priceInController.clear();
    priceOutController.clear();
  }

  /// dispose all controllers
  void disposeControllers() {
    titleController.dispose();
    priceInController.dispose();
    priceOutController.dispose();
    descrController.dispose();
  }

  @override
  void initState() {
    if (widget.techService != null) {
      _isUpdate = true;
      titleController.text = widget.techService!.title.toString();
      serviceCat = widget.techService!.category.toString();
      createdAt = widget.techService!.createdAt;
      priceInController.text = widget.techService!.priceIn.toString();
      priceOutController.text = widget.techService!.priceOut.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    clear();
    disposeControllers();
    _isUpdate = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: mformKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCategory(context, []),
              const SizedBox(height: 20),
              _buildTechServiceName(),
              const SizedBox(height: 20),
              _buildPriceIn(),
              const SizedBox(height: 20),
              _buildPriceOut(),
              const SizedBox(height: 20),
              _buildAvailability(context),
              const SizedBox(height: 20),
              _buildDescription(),
              const SizedBox(height: 40),
              _buildSaveButton(context),
              const SizedBox(height: 50) //but
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSaveButton(BuildContext context) {
    var srvBloc =
        TechServiceBloc(databaseOperations: GetIt.I<DatabaseOperations>());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: MThemeData.raisedButtonStyleSave,
          onPressed: !_canSave
              ? null
              : () {
                  if (mformKey.currentState!.validate()) {
                    setState(() {
                      _canSave = false;
                    });
                    final techService = TechServiceModel(
                      seviceId: _isUpdate ? widget.techService!.seviceId : null,
                      description: descrController.text.trim(),
                      createdAt: DateTime.now(),
                      available: _available,
                      category: serviceCat.trim(),
                      title: titleController.text.trim(),
                      priceIn: double.tryParse(priceInController.text),
                      priceOut: double.tryParse(priceOutController.text),
                      serviceDescription: description,
                    );
                    srvBloc.add(_isUpdate
                        ? UpdateTechServiceEvent(techService)
                        : AddTechServiceEvent(techService));
                    log('save button pressed $techService');
                    Navigator.pop(context);
                  }
                },
          child: Text(!_isUpdate ? 'Save' : 'Update').tr(),
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

  _buildCategory(BuildContext context, List<String> list) {
    return CategoryAutocompleteField(
        onChanged: (value) {
          setState(() {
            _canSave = true;
            serviceCat = value;
          });
        },
        categories: const ['Software', 'Service', 'Repair', 'Other']);
  }

  Widget _buildDescription() {
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
          contentPadding: const EdgeInsets.all(12.0),
        ),
      ),
    );
  }

  TextFormField _buildPriceOut() {
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
        maxLength: 10,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: '\$1234',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          contentPadding: const EdgeInsets.only(top: 4),
          filled: true,
          labelText: 'Price-out'.tr(),
          prefixIcon: const Icon(Icons.monetization_on),
        ));
  }

  TextFormField _buildPriceIn() {
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
        maxLength: 10,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: '\$1224',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          contentPadding: const EdgeInsets.only(top: 4),
          filled: true,
          labelText: 'Price-in'.tr(),
          prefixIcon: const Icon(Icons.monetization_on_outlined),
        ));
  }

  TextFormField _buildTechServiceName() {
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
          _canSave = text.trim().isNotEmpty;
        });
      },
      maxLength: 30,
      decoration: InputDecoration(
        counterText: '',
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

  _buildAvailability(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Availibility'.tr(),
          style: Theme.of(context).textTheme.subtitle2!,
        ),
        Switch(
            activeColor: MThemeData.accentColor,
            value: _available,
            onChanged: (value) {
              setState(() {
                _available = value;
              });
            }),
      ],
    );
  }
}
