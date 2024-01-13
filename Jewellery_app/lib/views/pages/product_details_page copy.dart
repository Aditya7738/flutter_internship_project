import 'package:flutter/material.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/model/choice_model.dart';
import 'package:jwelery_app/model/products_model.dart';
import 'package:jwelery_app/model/products_of_category.dart';
import 'package:jwelery_app/views/pages/cart_page.dart';
import 'package:jwelery_app/views/widgets/app_bar.dart';
import 'package:jwelery_app/views/widgets/button_widget.dart';
import 'package:jwelery_app/views/widgets/choice_widget.dart';
import 'package:jwelery_app/views/widgets/label_widget.dart';
import 'package:jwelery_app/views/widgets/pincode_widget.dart';
import 'package:jwelery_app/views/widgets/product_breakup_list_item.dart';
import 'package:jwelery_app/views/widgets/whole_carousel_slider%20copy.dart';
import 'package:jwelery_app/views/widgets/whole_carousel_slider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SearchProductDetailsPage extends StatefulWidget {
  final ProductsModel productsModel;

  const SearchProductDetailsPage({super.key, required this.productsModel});

  @override
  State<SearchProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<SearchProductDetailsPage> {
  late ProductsModel productsModel;
  bool isFavourite = false;
  bool backordersAllowed = false;

 

  @override
  void initState() {
    super.initState();
    productsModel = widget.productsModel;
    backordersAllowed = productsModel.backordersAllowed ?? false;
  }

  void toggleFavourite() {
    setState(() {
      isFavourite = !isFavourite; // Toggle the state of the heart icon
    });
  }

  @override
  Widget build(BuildContext context) {
 List<ChoiceModel> listOfChoiceModel = <ChoiceModel>[];
  listOfChoiceModel.add(
    ChoiceModel(label: "Select Metal", options: ["22 KT", "18 KT"], selectedOption: "18KT", )
  );
  listOfChoiceModel.add(
    ChoiceModel(label: "Select Color", options: ["rose", "yellow", "two-tone", "white"], selectedOption: "rose", )
  );
   listOfChoiceModel.add(
    ChoiceModel(label: "Select Size", options: ["2.02 - Make to Order", "2.04 - Make to Order", "2.06 - Make to Order"], selectedOption: "2.02 - Make to Order", )
  );
  listOfChoiceModel.add(
    ChoiceModel(label: "Type of Diamond", options: ["Natural"], selectedOption: "Natural", )
  );
  listOfChoiceModel.add(
    ChoiceModel(label: "Select Quality", options: ["VVS-EF"], selectedOption: "VVS-EF", )
  );
  

    return Scaffold(
      appBar: AppBarWidget(
        menuIcon: Icons.menu,
        onPressed: () {
          // if(scaffoldKey.currentState!.isDrawerOpen){
          //   scaffoldKey.currentState!.closeDrawer();
          // }else{
          //   scaffoldKey.currentState!.openDrawer();
          // }
        },
        isNeededForHome: true,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
            child: Column(children: [
          SearchProductWholeCarouselSlider(listOfProductImage: productsModel.images),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  productsModel.salePrice == ""
                      ?
                      HtmlWidget(productsModel.priceHtml ??
                        "<b>${productsModel.regularPrice}</b>",
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        )
                        :
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/rupee.png",
                        width: 20.0,
                        height: 20.0,
                      ),
                      
                        
                      Text(
                        productsModel.salePrice == ""
                            ? "10,000"
                            : productsModel.salePrice ?? "10,000",
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        productsModel.regularPrice ?? "15,000",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  IconButton(
                      icon: Icon(
                        isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.red,
                        size: 30.0,
                      ),
                      onPressed: () {
                        print("PRESSED");
                        toggleFavourite();
                      }),
                ]),
                const SizedBox(
                  height: 10.0,
                ),
               
                Container(
                    color: Color(0xfff1f7eb),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: backordersAllowed
                        ? const LabelWidget(
                            label: "Available on backorder",
                            color: Color(0xff85BA60),
                          )
                        : const LabelWidget(
                            label: "Unavailable on backorder",
                            color: Color(0xff85BA60),
                          )),
                const SizedBox(
                  height: 10.0,
                ),
        
                SizedBox(height: MediaQuery.of(context).size.height/2.5,
                  child: Scrollbar(
                    child: GridView.builder(
                      itemCount: listOfChoiceModel.length,
                      
                          
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.9,
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 600 ? 5 : 2,
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 15.0),
                       itemBuilder: ((context, index) {
                         return ChoiceWidget(choiceModel: listOfChoiceModel[index], fromCart: false,);
                       })),
                  ),
                ),
                 const SizedBox(
                  height: 10.0,
                ),
                const LabelWidget(
                  label: Strings.description_label,
                ),
                
                HtmlWidget(
                  productsModel.description ?? Strings.product_description
                  ),
                const SizedBox(
                  height: 10.0,
                ),
                // const Text(
                //   Strings.delivery_detail_label,
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                // ),
        
                Row(
                  children: [
                    const LabelWidget(
                      label: "SKU:",
                      fontSize: 18.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(productsModel.sku ?? "12007AN"),
                    const SizedBox(
                      width: 30.0,
                    ),
                    const LabelWidget(
                      label: "Category:",
                      fontSize: 18.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(productsModel.categories[0].name ?? "Jewellery")
                  ],
                ),
                const SizedBox(
                  width: 20.0,
                ),
                const Text(
                  "Tags:",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                productsModel.tags.isEmpty
                    ? Text("Jewellery")
                    : SizedBox(
                        height: 20.0,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: productsModel.tags.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                  productsModel.tags[index].name ??
                                      "Category"),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                // //const PincodeWidget(),
                // const LabelWidget(
                //   label: "BREAKUP",
                //   fontSize: 18.0,
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // ProductBreakupListItem(label: "PRODUCT DETAILS", backgroundColor: Color(0xffF5F5F5), labelColor: Color(0xffCC868A)),
               
                
              ])),
        ])),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: 160.0,
        child: ButtonWidget(
            imagePath: "assets/images/grocery_store.png",
            btnString: Strings.cart_btn_text, 
           // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(productId: productsModel.id!)))
            ),
      ),
    );
  }
}
