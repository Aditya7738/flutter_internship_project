import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/views/widgets/product_item.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CollectionSliderWidget extends StatefulWidget {
  const CollectionSliderWidget({super.key});

  @override
  State<CollectionSliderWidget> createState() => _CollectionSliderWidgetState();
}

class _CollectionSliderWidgetState extends State<CollectionSliderWidget> {
  bool isNewCategoryLoading = false;

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCollections();
  }

  getCollections() async {
    await ApiService.getCollections();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: ApiService.listOfCategory.length ~/ 2,
      itemBuilder: (context, index, realIndex) {
        // final image1Label = ApiService.listOfCategory[index * 2].name;
        // final image2Label = ApiService.listOfCategory[index * 2 + 1].name;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                color: Colors.yellow,
                child: isNewCategoryLoading
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      )
                    : SizedBox()
                // ProductItem(
                //     productsModel: ApiService.onSaleProducts[index],
                //   )
                ),
            Container(
                color: Colors.red,
                child: isNewCategoryLoading
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      )
                    : SizedBox()
                // ProductItem(
                //     productsModel: ApiService.onSaleProducts[index],
                //   )
                ),
          ],
        );
      },
      options: CarouselOptions(
          viewportFraction: 1.0,
          height: 340,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 3),
          onPageChanged: (index, reason) {
            if (mounted) {
              setState(() {
                currentIndex = index;
              });
            }
          }),
    );
  }
}
