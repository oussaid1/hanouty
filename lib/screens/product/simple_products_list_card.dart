import 'package:hanouty/local_components.dart';
import 'package:flutter/material.dart';
import '../../components.dart';

class SimpleProductListCard extends ConsumerWidget {
  const SimpleProductListCard({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: BluredContainer(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: product.color.withOpacity(0.5),
                    //backgroundColor: AppConstants.whiteOpacity,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      product.productName.substring(0, 1),
                      style: Theme.of(context).textTheme.headline6!,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: getColor(product.quantity)),
                    ),
                    Text(
                      '${product.suplier} ${product.dateIn.ddmmyyyy()}',
                      style: Theme.of(context).textTheme.subtitle2!,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    product.quantity.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: getColor(product.quantity)),
                  ),
                  Text(
                    product.category.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? getColor(int value) {
    switch (value) {
      case 0:
        return Colors.red[900];
      case 1:
        return Colors.red[700];
      case 2:
        return Colors.red[500];
      case 3:
        return Colors.red[300];
      case 4:
        return Colors.red[200];
      default:
        return Colors.green[300];
    }
  }
}

/*
 Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actions: [
        IconButton(
            icon: const Icon(
              Icons.price_check_rounded,
              color: MThemeData.accentVarientServ,
              size: 30, 
            ),
            onPressed: () {
              ref.read(incrementedNumber.state).state = product.quantity;
              ref.read(priceSoldForProvider.state).state = product.priceOut;
              ref.read(pickedDateTime.state).state = DateTime.now();
              MDialogs.dialogSimple(context,
               title: Text(
                    "Sell : ".tr() + product.productName,
                    style: Theme.of(context).textTheme.headline3!
                        .copyWith(color: MThemeData.accentVarientServ),
                    textAlign: TextAlign.center,
                  ),
                  contentWidget: SizedBox(
                    height: 420,
                    width: 400,
                    child: SellProductDialoge(
                     
                      product: product,
                    ),
                  ));
            })
      ],
      secondaryActions: [
        IconButton(
          icon: const Icon(
            Icons.edit_outlined,
            color: MThemeData.accentVarientP,
          ),
          onPressed: () {
            ref.read(pickedDateTime.state).state = product.dateIn;
            ref.read(quantityProvider.state).state = product.quantity;
            ref.read(selectedSelectOrAddCat.state).state = product.category!;
            ref.read(selectedSelectOrAddSuplier.state).state = product.suplier!;

            MDialogs.dialogSimple(
              context,
               title: Text(
                    "Edit : ".tr() + product.productName,
                style: Theme.of(context).textTheme.headline3!
                    .copyWith(color: MThemeData.accentVarientServ),
                textAlign: TextAlign.center,
              ),
              contentWidget: SizedBox(
                height: 400,
                width: 400,
                child: AddProduct(
                  product: product,
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: MThemeData.errorColor,
          ),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                " ${product.productName}",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: MThemeData.raisedButtonStyle,
                    child: Text(
                      'Delete'.tr(),
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                    onPressed: () {
                      ref
                          .read(databaseProvider)!
                          .deleteProduct(product)
                          .then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(MDialogs.snackBar('Done !'));

                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(MDialogs.errorSnackBar('Error !'));
                        }
                      });
                    },
                  ),
                  ElevatedButton(
                    style: MThemeData.raisedButtonStyleCancel,
                    child: Text(
                      'Cancel'.tr(),
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
      child:  
*/