import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/shared/preferences/preferences.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final cartBox = Hive.box(Constants.cartBoxName);

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = cartBox.keys.map(
      (e) {
        final item = cartBox.get(e);
        return {
          'key': key,
          'id': item['id'],
          'category': item['category'],
          'imageUrl': item['imageUrl'],
          'name': item['name'],
          'qty': item['qty'],
          'price': item['price'],
          'sizes': item['sizes'],
        };
      },
    ).toList();
    cart = cartData.reversed.toList();
    return Scaffold(
      backgroundColor: AppColors.backGrColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimens.dhp20,
                ),
                Text(
                  'This is my Cart',
                  style: CustomTextStyle.headerStyle_30_black,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: cart.isEmpty
                      ? Center(
                          child: Text(
                            'You have not add to cart yet!',
                            style: CustomTextStyle.titleStyle_17_black,
                          ),
                        )
                      : ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            final data = cart[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: Dimens.dhp10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Slidable(
                                    endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              cartBox.delete(data['key']);
                                            },
                                            backgroundColor: Colors.black,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          )
                                        ]),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimens.dhp5,
                                          horizontal: Dimens.dwp10),
                                      height: Dimens.getHeight(height: 100),
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: data['imageUrl'],
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            width: Dimens.dwp15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: Dimens.dhp10,
                                              ),
                                              Text(
                                                data['name'],
                                                style: CustomTextStyle
                                                    .headerStyle_16_black,
                                              ),
                                              Text(
                                                data['category'],
                                                style: CustomTextStyle
                                                    .titleStyle_15_grey,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '\$${data['price']}',
                                                    style: CustomTextStyle
                                                        .titleStyle_17_black,
                                                  ),
                                                  SizedBox(
                                                    width: Dimens.dwp10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'sizes',
                                                        style: CustomTextStyle
                                                            .titleStyle_17_black,
                                                      ),
                                                      SizedBox(
                                                        width: Dimens.dwp10,
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Row(
                                                          children: [
                                                            ...List.generate(
                                                                data['sizes']
                                                                    .length,
                                                                (index) =>
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        data['sizes']
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
