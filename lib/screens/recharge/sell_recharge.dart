import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hanouty/blocs/bloc/sellactionsrecharge_bloc.dart';
import 'package:hanouty/blocs/rechargebloc/fullrechargesales_bloc.dart';
import 'package:hanouty/components.dart';
import 'package:hanouty/widgets/autocomplete/autocomlete_textfields.dart';
import '../../database/database_operations.dart';
import '../../local_components.dart';
import '../../models/recharge/recharge.dart';
import '../../settings/themes.dart';
import '../../widgets/date_pickers.dart/date_picker.dart';
import '../../widgets/number_incrementer.dart';

enum AddRechargeState {
  selling,
  editing,
}

class SellRechargeWidget extends StatefulWidget {
  final RechargeModel? recharge;
  final AddRechargeState state;
  final RechargeSaleModel? rechargeSale;
  const SellRechargeWidget({
    Key? key,
    this.recharge,
    this.rechargeSale,
    required this.state,
  }) : super(key: key);

  @override
  State<SellRechargeWidget> createState() => SellRechargeStateWidget();
}

class SellRechargeStateWidget extends State<SellRechargeWidget> {
  //final GlobalKey<FormState> dformKey = GlobalKey<FormState>();
  //final TextEditingController clientController = TextEditingController();
  late RechargeOperator oprtr;
  String clientId = "";
  DateTime _date = DateTime.now();
  num quantity = 1;

  ////////////////////////////////////////////////////////////////////////////////
  bool _canSell = false;
  bool _isUpdate = false;
  ////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    if (widget.state == AddRechargeState.editing) {
      _isUpdate = true;
      _date = widget.rechargeSale!.dateSld;
      // quantity = widget.rechargeSale!.qnttSld;
      clientId = widget.rechargeSale!.clntID!;
      // oprtr = widget.rechargeSale!.oprtr;
    } else {
      if (widget.recharge != null) {
        _date = widget.recharge!.date;
        quantity = widget.recharge!.qntt;
        oprtr = widget.recharge!.oprtr;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            _buildOperator(context, oprtr: oprtr),
            const SizedBox(height: 15),
            _buildClientName(),
            const SizedBox(height: 15),
            _buildQuantity(context),
            const SizedBox(height: 15),
            buildDate(),
            const SizedBox(height: 30),
            buildSaveButton(context),
            const SizedBox(height: 30) //but
          ],
        ),
      ),
    );
  }

  buildSaveButton(BuildContext context) {
    var sellActionsBloc = SellActionsRechargeBloc(
        databaseOperations: GetIt.I<DatabaseOperations>());
    var rechargeBloc =
        RechargeBloc(databaseOperations: GetIt.I<DatabaseOperations>());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            onPressed: !_canSell
                ? null
                : () {
                    if (_isUpdate) {
                      setState(() {
                        _canSell = false;
                      });
                      final rechargeSale = RechargeSaleModel(
                        rSId: widget.rechargeSale!.rSId,
                        dateSld: _date,
                        qnttSld: quantity,
                        soldRchrgId: widget.rechargeSale?.id,
                        clntID: clientId,
                        //rSId: soldRechargeId!.id,
                      );
                      log('${rechargeSale.toMap()}');
                      rechargeBloc.add(
                          UpdateRechargeSaleEvent(rechargeSale: rechargeSale));
                    } else {
                      setState(() {
                        _canSell = false;
                      });
                      final rechargeSale = RechargeSaleModel(
                        dateSld: _date,
                        qnttSld: quantity,
                        soldRchrgId: widget.recharge!.id,
                        clntID: clientId,
                      );
                      log('sell not update ${rechargeSale.toMap()}');
                      sellActionsBloc.add(SellRechargeRequestedEvent(
                        rechargeModel: widget.recharge!,
                        rechargeSaleModel: rechargeSale,
                      ));
                      Navigator.pop(context);
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

  _buildClientName() {
    return ClientsAutocompleteWidget(
      //initialValue: clientId,
      // validator: (client) {
      //   if (client == null) {
      //     return "error".tr();
      //   }
      //   return null;
      // },
      onChanged: (client) {
        setState(() {
          _canSell = quantity > 0;
          clientId = client.id!;
        });
      },
    );
  }

  Widget _buildQuantity(BuildContext context) {
    return NumberIncrementerWidget(
      initialValue: quantity,
      limitUp: widget.recharge?.qntt ?? 0,
      onChanged: (num number) {
        setState(() {
          quantity = number;
        });
      },
    );
  }

  Widget buildDate() {
    return SelectDate(
      initialDate: _date,
      onDateSelected: (value) {
        setState(() {
          _canSell = quantity > 0;
          _date = value;
        });
      },
    );
  }

  Widget _buildOperator(
    BuildContext context, {
    required RechargeOperator oprtr,
  }) {
    return Container(
      width: 67,
      height: 67,
      decoration: BoxDecoration(
        color: RechargeModel.getOprtrColor(oprtr),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(oprtr.name.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  )),
        ],
      ),
    );
  }
}
