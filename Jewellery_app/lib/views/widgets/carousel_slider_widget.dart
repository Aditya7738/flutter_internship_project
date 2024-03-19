import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int currentIndex = 0;

  bool isBannerLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBanners();
  }

  Future<void> onLinkClicked(String url, BuildContext context) async {
    Uri uri = Uri.parse(url);
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        print("Could not launch Banner's URL");
      }
    }
  }

  Future<void> getBanners() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (mounted) {
        setState(() {
          isBannerLoading = true;
        });
      }
      ApiService.listOfBanners.clear();
      await ApiService.getBanners();

      if (mounted) {
        setState(() {
          isBannerLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        isBannerLoading
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : Builder(builder: (context) {
                bool bgImageTabletIsNotEmpty = false;
                bool bgImageMobileIsNotEmpty = false;

                ApiService.listOfBanners.forEach((banner) {
                  if (banner.metadata != null) {
                    if (deviceWidth > 600) {
                      if (banner.metadata!.bgImageTablet.isNotEmpty) {
                        for (var i = 0;
                            i < banner.metadata!.bgImageTablet.length;
                            i++) {
                          if (banner.metadata!.bgImageTablet[i].isNotEmpty) {
                            bgImageTabletIsNotEmpty = true;
                          }
                        }
                      }
                    } else {
                      if (banner.metadata!.bgImageMobile.isNotEmpty) {
                        for (var i = 0;
                            i < banner.metadata!.bgImageMobile.length;
                            i++) {
                          if (banner.metadata!.bgImageMobile[i].isNotEmpty) {
                            bgImageMobileIsNotEmpty = true;
                          }
                        }
                      }
                    }
                  }
                });
                if (bgImageTabletIsNotEmpty) {
                  return Column(
                    children: [
                      CarouselSlider(
                        carouselController: carouselController,
                        items: ApiService.listOfBanners
                            .map((banner) => GestureDetector(
                                  onTap: () async {
                                    if (banner.metadata != null) {
                                      if (banner.metadata!.link.isNotEmpty) {
                                        if (banner.metadata!.link[0]
                                            .contains("https://")) {
                                          await onLinkClicked(
                                              banner.metadata!.link[0],
                                              context);
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    child: Image.network(
                                      banner.metadata != null
                                          ? banner.metadata!.bgImageTablet[0]
                                          : "https://rotationalmoulding.com/wp-content/uploads/2017/02/NoImageAvailable.jpg",
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          alignment: Alignment.center,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 92.0,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        );
                                      },
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            viewportFraction: 1.04,
                            height: MediaQuery.of(context).size.height / 2,
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
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DotsIndicator(
                            dotsCount: ApiService.listOfBanners.length > 0
                                ? ApiService.listOfBanners.length
                                : 1,
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
                    ],
                  );
                } else if (bgImageMobileIsNotEmpty) {
                  return Column(
                    children: [
                      CarouselSlider(
                        carouselController: carouselController,
                        items: ApiService.listOfBanners
                            .map((banner) => GestureDetector(
                                  onTap: () async {
                                    if (banner.metadata != null) {
                                      if (banner.metadata!.link.isNotEmpty) {
                                        if (banner.metadata!.link[0]
                                            .contains("https://")) {
                                          await onLinkClicked(
                                              banner.metadata!.link[0],
                                              context);
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    child: Image.network(
                                      banner.metadata != null
                                          ? banner.metadata!.bgImageMobile[0]
                                          : "https://rotationalmoulding.com/wp-content/uploads/2017/02/NoImageAvailable.jpg",
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          alignment: Alignment.center,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 92.0,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        );
                                      },
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            viewportFraction: 1.04,
                            height: MediaQuery.of(context).size.height / 2,
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
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DotsIndicator(
                            dotsCount: ApiService.listOfBanners.length > 0
                                ? ApiService.listOfBanners.length
                                : 1,
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
                    ],
                  );
                } else {
                  return SizedBox();
                }
              })
      ],
    );
  }
}
