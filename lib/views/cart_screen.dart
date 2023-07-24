import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:online_shop/view_model/view_model.dart';
import 'package:online_shop/shared/component/component.dart';
import 'package:online_shop/shared/preferences/preferences.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartNotifier cartNotifier;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      cartNotifier = Provider.of<CartNotifier>(context, listen: false);
      cartNotifier.getCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGrColor,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            const ReusableTopImage(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: Dimens.dp10,
                  ),
                  Text(
                    'My Cart',
                    style: CustomTextStyle.headerStyle_30_white,
                  ),
                  Builder(builder: (context) {
                    final data = context.watch<CartNotifier>();
                    return SizedBox(
                      height: Dimens.getHeight(context: context) * 0.7,
                      child: data.cart.isEmpty
                          ? Center(
                              child: Text(
                                'You have not add to cart yet!',
                                style: CustomTextStyle.titleStyle_17_black,
                              ),
                            )
                          : ListView.builder(
                              itemCount: data.cart.length,
                              itemBuilder: (context, index) {
                                final sneaker = data.cart[index];
                                return CartProduct(
                                    data: data, sneaker: sneaker);
                              },
                            ),
                    );
                  })
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ReusableButton(onTap: () {}, label: 'Proceed to checkout'),
            )
          ],
        ),
      ),
    );
  }
}
