import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanouty/extensions/extensions.dart';

import '../../blocs/rechargebloc/fullrechargesales_bloc.dart';
import '../../components.dart';
import '../../database/database_operations.dart';
import '../../models/recharge/recharge.dart';

import '../../settings/themes.dart';
import '../../widgets/date_pickers.dart/date_picker.dart';
import '../../widgets/number_incrementer.dart';
import 'recharge_card_widget.dart';

class AddRechargeWidget extends StatefulWidget {
  final RechargeModel? recharge;
  const AddRechargeWidget({
    Key? key,
    this.recharge,
  }) : super(key: key);

  @override
  State<AddRechargeWidget> createState() => _AddRechargeStateWidget();
}

class _AddRechargeStateWidget extends State<AddRechargeWidget> {
  final GlobalKey<FormState> dformKey = GlobalKey<FormState>();
  //final TextEditingController clientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String suplierID = "any";
  final TextEditingController percentageController = TextEditingController();
  DateTime _date = DateTime.now();
  num quantity = 1;
  RechargeOperator? oprtr;
  bool _canSave = false;
  bool _isUpdate = false;

  @override
  void initState() {
    if (widget.recharge != null) {
      _isUpdate = true;
      _date = widget.recharge!.date;
      amountController.text = widget.recharge!.amount.toString();
      percentageController.text = widget.recharge!.percntg.toString();
      quantity = widget.recharge!.qntt;
      oprtr = widget.recharge!.oprtr;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: dformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildOperator(),
                  const SizedBox(height: 20),
                  buildPercentage(),
                  const SizedBox(height: 20),
                  _buildQuantity(context),
                  const SizedBox(height: 20),
                  buildAmount(),
                  const SizedBox(height: 20),
                  buildDate(),
                  const SizedBox(height: 40),
                  buildSaveButton(context),
                  const SizedBox(height: 40) //but
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildSaveButton(BuildContext context) {
    var rechargeBloc =
        RechargeBloc(databaseOperations: GetIt.I<DatabaseOperations>());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            onPressed: !_canSave
                ? null
                : () {
                    if (dformKey.currentState!.validate()) {
                      setState(() {
                        _canSave = false;
                      });
                      final rchrge = RechargeModel(
                        id: _isUpdate ? widget.recharge!.id : null,
                        amount: double.tryParse(amountController.text)!,
                        date: _date,
                        percntg: double.tryParse(percentageController.text)!,
                        qntt: quantity,
                        oprtr: oprtr!,
                      );
                      log('${rchrge.toMap()}');
                      rechargeBloc.add(_isUpdate
                          ? UpdateRechargeEvent(rechargeModel: rchrge)
                          : AddRechargeEvent(rechargeModel: rchrge));
                      // // Navigator.pop(context);
                    }
                  },
            child: Text(_isUpdate ? "Update" : "Save").tr()),
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

  Widget _buildQuantity(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: NumberIncrementerWidget(
        initialValue: quantity,
        onChanged: (num number) {
          setState(() {
            quantity = number;
          });
        },
      ),
    );
  }

  Widget buildDate() {
    return SelectDate(
      initialDate: _date,
      onDateSelected: (value) {
        setState(() {
          _canSave = true;
          _date = value;
        });
      },
    );
  }

  TextFormField buildPercentage() {
    return TextFormField(
      controller: percentageController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      onChanged: (value) {
        setState(() {
          _canSave = true;
        });
      },
      style: Theme.of(context).textTheme.headline3!.copyWith(
            // color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
      textAlign: TextAlign.center,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      maxLength: 5,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Percentage'.tr(),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '%',
        // hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.percent),

        /// a clear button to clear the text
        suffix: percentageController.text.trim().isEmpty
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    percentageController.clear();
                    _canSave = false;
                  });
                },
              ),
        filled: true,
      ),
    );
  }

  TextFormField buildAmount() {
    return TextFormField(
      controller: amountController,
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
      onChanged: (value) {
        setState(() {
          _canSave = true;
        });
      },
      textAlign: TextAlign.center,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Amount'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '\$',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        filled: true,
      ),
    );
  }

  _buildOperator() {
    return RechargeOperatorRadioWidget(
      initialValue: oprtr,
      onRechargeSelected: (value) {
        setState(() {
          _canSave = true;
          oprtr = value;
        });
      },
    );
  }
}
