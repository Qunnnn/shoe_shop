import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/shared/component/component.dart';
import 'package:online_shop/views/product_screen.dart';
import 'package:provider/provider.dart';
import '../controllers/sneaker_notifier.dart';
import '../models/sneaker_model.dart';
import '../shared/preferences/preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SneakerModel> sneakerList = [];
  List<SneakerModel> sneakerStorage = [];
  final TextEditingController textEditingController = TextEditingController();
  late final SneakerNotifier sneakerNotifier;
  List<String> listCategory = [
    "Men's Running",
    "Women's Running",
    "Kid's Running",
  ];
  int selectedCategory = 0;

  getStorage() {
    switch (selectedCategory) {
      case 0:
        setState(() {
          sneakerStorage = sneakerNotifier.maleList;
          sneakerList = sneakerNotifier.maleList;
        });
        break;
      case 1:
        setState(() {
          sneakerStorage = sneakerNotifier.femaleList;
          sneakerList = sneakerNotifier.femaleList;
        });
        break;
      case 2:
        setState(() {
          sneakerStorage = sneakerNotifier.kidList;
          sneakerList = sneakerNotifier.kidList;
        });
        break;
      default:
    }
  }

  searchSneaker(String query) {
    final suggestions = sneakerStorage.where((sneaker) {
      final sneakerName = sneaker.name.toLowerCase();
      final input = query.toLowerCase();
      return sneakerName.contains(input);
    }).toList();
    setState(() {
      sneakerList = suggestions;
    });
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      sneakerNotifier = Provider.of<SneakerNotifier>(context, listen: false);
      getStorage();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGrColor,
        body: Stack(
          children: [
            const ReusableTopImage(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search Screen',
                    style: CustomTextStyle.headerStyle_30_white,
                  ),
                  const SizedBox(
                    height: Dimens.dp20,
                  ),
                  SizedBox(
                    height: Dimens.getHeight(context: context) * 0.07,
                    child: TextField(
                      controller: textEditingController,
                      cursorColor: Colors.grey.shade500,
                      onChanged: (value) {
                        searchSneaker(value);
                      },
                      style: CustomTextStyle.titleStyle_15_white,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(bottom: Dimens.dp10),
                        prefixIcon: Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.grey[500],
                          size: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.grey.shade500, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.grey.shade500, width: 2)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.dp40,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          listCategory.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = index;
                                    getStorage();
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(right: Dimens.dp10),
                                  height:
                                      Dimens.getHeight(context: context) * 0.05,
                                  width:
                                      Dimens.getWidth(context: context) * 0.4,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: selectedCategory == index
                                            ? Colors.indigo
                                            : Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(listCategory[index],
                                        style: CustomTextStyle
                                            .titleStyle_17_black
                                            .copyWith(
                                                color: selectedCategory == index
                                                    ? Colors.indigo
                                                    : Colors.black)),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  sneakerList.isEmpty
                      ? Container()
                      : Expanded(
                          child: ListView.builder(
                            itemCount: sneakerList.length,
                            itemBuilder: (context, index) {
                              final sneaker = sneakerList[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                            id: sneaker.id,
                                            category: sneaker.category),
                                      ));
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: Dimens.dp10),
                                  height:
                                      Dimens.getHeight(context: context) * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[0]),
                                        const SizedBox(
                                          width: Dimens.dp18,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              sneaker.name,
                                              style: CustomTextStyle
                                                  .titleStyle_17_black,
                                            ),
                                            Text(
                                              sneaker.category,
                                              style: CustomTextStyle
                                                  .titleStyle_15_grey,
                                            ),
                                            Text(
                                              '\$${sneaker.price}',
                                              style: CustomTextStyle
                                                  .titleStyle_17_black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            )
          ],
        ));
  }
}
