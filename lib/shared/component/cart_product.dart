import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../controllers/controllers.dart';
import '../preferences/preferences.dart';

class CartProduct extends StatefulWidget {
  CartProduct({
    super.key,
    required this.data,
    required this.sneaker,
  });
  final CartNotifier data;
  final dynamic sneaker;

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  late int quantity;
  late final CartNotifier cartNotifier;

  putAt() {
    if (quantity >= 20) quantity = 20;
    cartNotifier.putCart(int.parse(widget.sneaker['id']), {
      'id': widget.sneaker['id'],
      'name': widget.sneaker['name'],
      'category': widget.sneaker['category'],
      'imageUrl': widget.sneaker['imageUrl'],
      'sizes': widget.sneaker['sizes'],
      'price': widget.sneaker['price'],
      'qty': quantity,
    });
    cartNotifier.getCart();
  }

  @override
  void initState() {
    cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    quantity = widget.sneaker['qty'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.dp10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Slidable(
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  widget.data.deleteCart(int.parse(widget.sneaker['id']));
                  widget.data.getCart();
                },
                backgroundColor: Colors.black,
                icon: Icons.delete,
                label: 'Delete',
              )
            ]),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimens.dp6, horizontal: Dimens.dp10),
              height: Dimens.getHeight(context: context) * 0.12,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.sneaker['imageUrl'],
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: Dimens.dp16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: Dimens.dp10,
                      ),
                      Text(
                        widget.sneaker['name'],
                        style: CustomTextStyle.headerStyle_16_black,
                      ),
                      Text(
                        widget.sneaker['category'],
                        style: CustomTextStyle.titleStyle_15_grey,
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${widget.sneaker['price']}',
                            style: CustomTextStyle.titleStyle_17_black,
                          ),
                          const SizedBox(
                            width: Dimens.dp10,
                          ),
                          Row(
                            children: [
                              Text(
                                'sizes',
                                style: CustomTextStyle.titleStyle_17_black,
                              ),
                              const SizedBox(
                                width: Dimens.dp10,
                              ),
                              SingleChildScrollView(
                                child: Row(
                                  children: [
                                    ...List.generate(
                                        widget.sneaker['sizes'].length,
                                        (index) => Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Text(
                                                widget.sneaker['sizes'][index],
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
                  ),
                  const Spacer(),
                  Container(
                    height: Dimens.getHeight(context: context) * 0.1,
                    width: Dimens.getWidth(context: context) * 0.045,
                    color: Colors.grey[200],
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: Dimens.getHeight(context: context) * 0.02,
                            child: Material(
                              color: Colors.grey,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    quantity--;
                                    putAt();
                                  });
                                },
                                child: const Center(
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Colors.black,
                                    size: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: CustomTextStyle.titleStyle_15_grey,
                          ),
                          SizedBox(
                            height: Dimens.getHeight(context: context) * 0.02,
                            child: Material(
                              color: Colors.black,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                    putAt();
                                  });
                                },
                                child: const Center(
                                  child: Icon(
                                    FontAwesomeIcons.plus,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
