class Constants {
  static const String app_name = "Jewellery App";
  static const String app_logo =
      "https://tiarabytj.com/wp-content/uploads/sites/27/2021/10/logo-1.png";

  static const String baseUrl = "https://tiarabytj.com";
  static const String consumerKey =
      "ck_33882e17eeaff38b20ac7c781156024bc2d6af4a";
  static const String consumerSecret =
      "cs_df67b056d05606c05275b571ab39fa508fcdd7b9";

  static const String delivery_detail_label = "Delivery Details";
  static const String price_label = "Price";
  static const String description_label = "Description";
  static const String cart_btn_text = "ADD TO CART";
  static const String product_description =
      "<p>Introducing our Golden Elegance Bridal Necklace, a mesmerizing symbol of love and beauty. Handcrafted with 18-karat gold and adorned with dazzling diamonds, it exudes opulence and luxury. As it gracefully drapes around the bride’s neck, its intricate design and shimmering diamonds reflect the promises made and the radiant joy of the wedding day. Wearing this exquisite necklace evokes overwhelming emotions of excitement, love, and anticipation. Passed down as a cherished heirloom, it becomes a timeless reminder of the bride’s elegance and grace. Our Golden Elegance Bridal Necklace, crafted to perfection, ensures an extraordinary wedding day and a keepsake treasured for a lifetime</p>";
  static const defaultImageUrl =
      "https://www.pngmart.com/files/1/Jewellery-Necklace-Transparent-Background.png";
  static const String oneSignalAppId = "c58ace4e-b5d1-4ebe-b769-c0705eeac0db";

  static const String userName = "tiarabytj@gmail.com";
  static const String password = "October@Jwero";

  static const String consumerKeySignup = "";
  static const String consumerSecretSignup = "";

  static const String shopContactNo = "9833566117";

  static const String shopEmailId =  "tiarabytj@gmail.com";

  static const Map<String, dynamic> defaultLayoutDesign = {
    "success": true,
    "data": {
        "theme": {
            "colors": {
                "primary": "#CC868A",
                "secondary": "#33FF57",
                "background": "#FFFFFF"
            },
            "fontFamily": "Roboto"
        },
        "pages": [
            {
                "name": "HomePage",
                "layout": "column",
                "children": [
                    {
                        "type": "image_slider",
                        "layout": {
                            "item_per_row": 1
                        }
                    },
                    {
                        "type": "header",
                        "text": "Tiarabytj",
                        "style": {
                            "color": "#333333",
                            "fontSize": 24
                        },
                        "layout": {}
                    },
                    {
                        "type": "categories",
                        "layout": {
                            "direction": "horizontal",
                            "item_per_row": 1
                        }
                    },
                    {
                        "type": "collections",
                        "meta": {
                            "label": "Diamond Collection",
                            "id": 12
                        },
                        "layout": {
                            "direction": "horizontal",
                            "item_per_row": 1
                        }
                    }
                ]
            }
        ],
        "placeholders": {
            "product_image": "https://i0.wp.com/mikeyarce.com/wp-content/uploads/2021/09/woocommerce-placeholder.png"
        }
    }
};

}
