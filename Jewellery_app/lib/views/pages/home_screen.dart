import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/navigation_model.dart';
import 'package:Tiara_by_TJ/views/widgets/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:Tiara_by_TJ/views/widgets/button_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/feature_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/pincode_widget.dart';

import '../widgets/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();

  List<String> images = [
    "https://newspaperads.ads2publish.com/wp-content/uploads/2020/11/fuzion-queentessential-extravagance-finest-diamond-jewelry-ad-toi-ahmedabad-6-11-2020.jpg",
    "https://i.pinimg.com/564x/43/68/b2/4368b2a77dceb87086c8752ce87c7728.jpg",
    "https://www.eventalways.com/media/eventgallery/large/gallery-image-1646823449.jpg",
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/jewelry-collection-instagram-post-flyer-design-template-5cbe7bd2c299c98f3145f0a61d7b5cae_screen.jpg",
    "https://images.freecreatives.com/wp-content/uploads/2016/03/Luxury-Jewelry-Advertising.jpg"
  ];

  late CarouselController carouselController;

  int currentIndex = 0;

  // List<CategoriesModel> listOfCategories = [];

  bool isLoading = true;

  bool isNewCategoryLoading = false;

  @override
  void initState() {
    super.initState();
    //getDataFromProvider();
    carouselController = CarouselController();
    getRequest();
    _scrollController.addListener(() async {
      print(
          "CONDITION ${_scrollController.position.pixels == _scrollController.position.maxScrollExtent}");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("REACHED END OF LIST");

        loadMoreData();
      }
    });
  }

  void loadMoreData() async {
    setState(() {
      isNewCategoryLoading = true;
    });

    // Fetch more data (e.g., using ApiService)
    await ApiService.showNextPageOfCategories();

    setState(() {
      isNewCategoryLoading = false;
    });
  }

  // void getDataFromProvider() async {
  //   print("Callig shared prefs");

  //   Provider.of<CartProvider>(context, listen: false).getSharedPrefs();
  //   Provider.of<WishlistProvider>(context, listen: false)
  //       .getWishListSharedPrefs();
  //   print("call wishlist shared prefs");
  // }

  Future<void> getRequest() async {
    await ApiService.fetchCategories(1);

    setState(() {
      isLoading = false;
    });
  }

  // @override
  // void dispose() {
  
  //   super.dispose();
  //    _scrollController.dispose();
     

  // }
  @override
  Widget build(BuildContext context) {
    double width = 20.0;
    double height = 20.0;

    List<NavigationModel> listOfNavigationModel = <NavigationModel>[];
    listOfNavigationModel.add(NavigationModel(
        Image.asset("assets/images/notification.png",
            width: width, height: height, color: Colors.white),
        "Notifications"));
    listOfNavigationModel.add(NavigationModel(
        Image.asset("assets/images/gold_bars.png",
            width: width, height: height),
        "Gold Rate"));
    listOfNavigationModel.add(NavigationModel(
        Image.asset(
          "assets/images/gift.png",
          width: width,
          height: height,
        ),
        "Promotions"));
    listOfNavigationModel.add(NavigationModel(
        Image.asset("assets/images/branding.jpg",
            width: width, height: height, color: Colors.white),
        "Brands"));
    listOfNavigationModel.add(NavigationModel(
        Image.asset("assets/images/roadmap.png",
            width: width, height: height, color: Colors.white),
        "Plans"));
    listOfNavigationModel.add(NavigationModel(
        Image.asset(
          "assets/images/info.png",
          width: width,
          height: height,
          color: Colors.white,
        ),
        "About us"));
    listOfNavigationModel.add(NavigationModel(
        Image.asset("assets/images/account.png", width: width, height: height),
        "My Account"));
    listOfNavigationModel.add(NavigationModel(
        Image.asset("assets/images/gears.png", width: width, height: height),
        "Settings"));
    listOfNavigationModel.add(NavigationModel(
        Image.asset("assets/images/terms_and_conditions.png",
            width: width, height: height, color: Colors.white),
        "Terms and Conditions"));
    listOfNavigationModel.add(NavigationModel(
        Image.asset(
          "assets/images/login.png",
          width: width,
          height: height,
          color: Colors.white,
        ),
        "Login"));

    return Scaffold(
      key: scaffoldKey,
      drawer: NavDrawer(
          backgroundColor: const Color(0xFF9A0056),
          fontColor: Colors.white,
          fontSize: 15.0,
          fontFamily: 'Montserrat',
          listOfNavigationModel: listOfNavigationModel,
          fontWeight: FontWeight.bold),
      appBar: AppBarWidget(
          menuIcon: Icons.menu,
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
            } else {
              scaffoldKey.currentState!.openDrawer();
            }
          },
          isNeededForHome: true,
          isNeededForProductPage: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              height: MediaQuery.of(context).size.height / 6,
              child: Scrollbar(
                child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: ApiService.listOfCategory.length +
                        (isNewCategoryLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < ApiService.listOfCategory.length) {
                        return FeatureWidget(
                          categoriesModel: ApiService.listOfCategory[index],
                          isLoading: isLoading,
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Color(0xffCC868A),
                        ));
                      }
                    }),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: PincodeWidget(),
            ),

            CarouselSlider(
              carouselController: carouselController,
              items: images
                  .map((image) =>
                      //  Container(
                      //       margin: const EdgeInsets.all(5.0),
                      //       decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //               image: NetworkImage(image),
                      //               fit: BoxFit.fill)),
                      //     )
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Image.network(
                          image,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: 92.0,
                              child: const CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          },
                          fit: BoxFit.fill,
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
                    setState(() {
                      currentIndex = index;
                    });
                  }),
            ),

            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DotsIndicator(
                  dotsCount: images.length,
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(alignment: AlignmentDirectional.center, children: [
                Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      "assets/images/banner_web.png",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/images/heart.png",
                          color: const Color.fromRGBO(0, 0, 0, 0.1),
                          width: 45.0,
                          height: 45.0,
                        ),
                        Image.asset(
                          "assets/images/caratlane_transparent.png",
                          color: Colors.white,
                          width: 20.0,
                          height: 20.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "Launching Refer & Earn",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Inspire your friends & family and \n ear upto Rs 750 xCLusive points!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: 400.0,
                      child: ButtonWidget(
                          btnString: "Get Started",
                          imagePath: "assets/images/right_arrow.png"),
                    )
                  ],
                ),
              ]),
            ),

            const SizedBox(
              height: 10.0,
            ),

            //error
            // Container(
            //   margin: const EdgeInsets.fromLTRB(20, 15, 10, 10),
            //   padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     boxShadow: [
            //       BoxShadow(
            //           color: Colors.grey.shade200,
            //           offset: const Offset(0.0, 1.0),
            //           blurRadius: 1.0,
            //           spreadRadius: 2.0)
            //     ],
            //     borderRadius: BorderRadius.circular(30.0),
            //     shape: BoxShape.rectangle),
            //   child: const FreePointsWidget(textColor: Color(0xFF4F3267),),

            // ),
          ],
        ),
      ),
      
    );
  }
}
