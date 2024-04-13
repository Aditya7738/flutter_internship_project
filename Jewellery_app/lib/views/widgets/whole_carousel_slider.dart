import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:provider/provider.dart';

class WholeCarouselSlider extends StatefulWidget {
  final List<ProductImage> listOfProductImage;
  const WholeCarouselSlider({super.key, required this.listOfProductImage});

  @override
  State<WholeCarouselSlider> createState() => _WholeCarouselSliderState();
}

class _WholeCarouselSliderState extends State<WholeCarouselSlider> {
  CarouselController carouselController = CarouselController();
  late List<ProductImage> listOfProductImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfProductImage = widget.listOfProductImage;
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of(context, listen: false);
    List<String> urlList = [layoutDesignProvider.placeHolder];
    return Column(children: [
      Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
            carouselController: carouselController,
            items: listOfProductImage.isEmpty
                ? urlList
                    .map(
                      (image) => Image.network(
                        layoutDesignProvider.placeHolder,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return SizedBox(
                            width: 46.0,
                            height: 16.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                              ),
                            ),
                          );
                          }
                        },
                      ),
                    )
                    .toList()
                : listOfProductImage
                    .map(
                      (image) => Image.network(
                        image.src!,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            width: 46.0,
                            height: 16.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
            options: CarouselOptions(
                viewportFraction: 1.04,
                height: MediaQuery.of(context).size.height / 2,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 10),
                onPageChanged: (index, reason) {
                  if (mounted) {
                    setState(() {
                      currentIndex = index;
                    });
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton.outlined(
                    onPressed: () {
                      carouselController.previousPage();
                    },
                    icon: Icon(Icons.chevron_left_outlined)),
                IconButton.outlined(
                    onPressed: () {
                      carouselController.nextPage();
                    },
                    icon: Icon(Icons.chevron_right_outlined)),
              ],
            ),
          )
        ],
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DotsIndicator(
            dotsCount: listOfProductImage.isEmpty
                ? urlList.length
                : listOfProductImage.length,
            position: currentIndex,
            onTap: (index) {
              carouselController.animateToPage(index);
            },
            decorator: const DotsDecorator(
              color: Colors.grey,
              activeColor: Colors.black,
              size: Size.square(12.0),
              activeSize: Size.square(15.0),
            ),
          )),
    ]);
  }
}
