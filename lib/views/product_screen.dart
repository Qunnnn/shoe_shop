import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/controllers/sneaker_notifier.dart';
import 'package:online_shop/shared/preferences/preferences.dart';
import 'package:provider/provider.dart';
import '../shared/component/component.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late SneakerNotifier sneakerProvider;
  final PageController _pageController = PageController();
  final defaultPadding = SizedBox(
    height: Dimens.dhp10,
  );
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      sneakerProvider = Provider.of<SneakerNotifier>(context, listen: false);
      if (widget.category == "Men's Running") {
        sneakerProvider.getMaleSnekerByid(id: widget.id);
      } else if (widget.category == "Women's Running") {
        sneakerProvider.getFemaleSnekerByid(id: widget.id);
      } else {
        sneakerProvider.getKidSnekerByid(id: widget.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sneaker = context.watch<SneakerNotifier>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.of(context).size.height,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    sneaker.clearSize();
                  },
                  child: const Icon(
                    FontAwesomeIcons.xmark,
                    color: Colors.black,
                  ),
                ),
                const Icon(
                  FontAwesomeIcons.ellipsis,
                )
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: sneaker.sneaker == null
                  ? const Center(child: CircularProgressIndicator())
                  : ProductDetailWidget(pageController: _pageController, sneaker: sneaker, defaultPadding: defaultPadding),
            ),
          )
        ],
      ),
    );
  }
}




