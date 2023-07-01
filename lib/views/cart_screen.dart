import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:online_shop/controllers/controllers.dart';
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
    final data = context.watch<CartNotifier>();
    return Scaffold(
      backgroundColor: AppColors.backGrColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Dimens.dp20,
                ),
                Text(
                  'This is my Cart',
                  style: CustomTextStyle.headerStyle_30_black,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
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
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: Dimens.dp10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Slidable(
                                    endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              data.deleteCart(
                                                  int.parse(sneaker['id']));
                                              data.getCart();
                                            },
                                            backgroundColor: Colors.black,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          )
                                        ]),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: Dimens.dp6,
                                          horizontal: Dimens.dp10),
                                      height: Dimens.getHeight(
                                          context: context, height: 100),
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: sneaker['imageUrl'],
                                            fit: BoxFit.fill,
                                          ),
                                          const SizedBox(
                                            width: Dimens.dp16,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: Dimens.dp10,
                                              ),
                                              Text(
                                                sneaker['name'],
                                                style: CustomTextStyle
                                                    .headerStyle_16_black,
                                              ),
                                              Text(
                                                sneaker['category'],
                                                style: CustomTextStyle
                                                    .titleStyle_15_grey,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '\$${sneaker['price']}',
                                                    style: CustomTextStyle
                                                        .titleStyle_17_black,
                                                  ),
                                                  const SizedBox(
                                                    width: Dimens.dp10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'sizes',
                                                        style: CustomTextStyle
                                                            .titleStyle_17_black,
                                                      ),
                                                      const SizedBox(
                                                        width: Dimens.dp10,
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Row(
                                                          children: [
                                                            ...List.generate(
                                                                sneaker['sizes']
                                                                    .length,
                                                                (index) =>
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        sneaker['sizes']
                                                                            [
                                                                            index],
                                                                        style: CustomTextStyle
                                                                            .titleStyle_17_black,
                                                                      ),
                                                                    ))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          },
                        ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
