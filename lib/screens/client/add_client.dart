import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../models/client/shop_client.dart';
import '../../settings/themes.dart';

class AddClient extends StatefulWidget {
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

class AddClientState extends State<AddClient> {
  bool _canSave = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController =
      TextEditingController(text: 'oussaid');
  final TextEditingController phoneController =
      TextEditingController(text: '0687888888');
  final TextEditingController emailController =
      TextEditingController(text: 'oussaid.abdellatif@gmail.com');
  double _rating = 3.5;
  bool _isUpdate = false;

  void clear() {
    titleController.clear();
    phoneController.clear();
    emailController.clear();
  }

  @override
  void initState() {
    if (widget.client != null) {
      _isUpdate = true;
      titleController.text = widget.client!.clientName.toString();
      phoneController.text = widget.client!.phone.toString();
      emailController.text = widget.client!.email.toString();
      _rating = widget.client!.stars;
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildFlexible(context),
      ],
    );
  }

  buildFlexible(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            buildClientName(),
            const SizedBox(height: 20),
            buildClientPhone(),
            const SizedBox(height: 20),
            buildClientEmail(),
            const SizedBox(height: 20),
            buildRating(context),
            const SizedBox(height: 20),
            buildSaveButton(context),
            const SizedBox(
              height: 100,
            ) //but
          ],
        ),
      ),
    );
  }

  Row buildSaveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: MThemeData.raisedButtonStyleSave,
          onPressed: !_canSave
              ? null
              : () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      _canSave = false;
                    });
                    final client = ShopClientModel(
                      id: _isUpdate ? widget.client!.id : null,
                      clientName: titleController.text.trim(),
                      phone: phoneController.text.trim(),
                      email: emailController.text.trim(),
                      stars: _rating,
                    );
                    log('added ${client.toString()}');
                    _isUpdate
                        ? BlocProvider.of<ShopClientBloc>(widget.pContext)
                            .add(UpdateShopClientEvent(client))
                        : BlocProvider.of<ShopClientBloc>(widget.pContext)
                            .add(AddShopClientEvent(client));
                    clear();
                    Navigator.pop(context);
                    // Navigator.pop(context);
                  }
                },
          child: Text(_isUpdate ? 'update'.tr() : 'save'.tr()),
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

  TextFormField buildClientName() {
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
      maxLength: 20,
      decoration: InputDecoration(
        counterText: '',
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

  TextFormField buildClientPhone() {
    return TextFormField(
      controller: phoneController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      inputFormatters: [
        /// only numbers and +
        FilteringTextInputFormatter(RegExp('[0-9.]+'), allow: true)
      ],
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
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

  TextFormField buildClientEmail() {
    return TextFormField(
      controller: emailController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      maxLength: 50,
      decoration: InputDecoration(
        counterText: '',
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

  buildRating(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
      itemSize: 32,
      minRating: 0,
      maxRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _canSave = true;
          _rating = rating;
        });
      },
    );
  }
}
