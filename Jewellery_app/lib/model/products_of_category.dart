class ProductOfCategoryModel {
  ProductOfCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.dateOnSaleFrom,
    required this.dateOnSaleFromGmt,
    required this.dateOnSaleTo,
    required this.dateOnSaleToGmt,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.downloadable,
    required this.downloads,
    required this.downloadLimit,
    required this.downloadExpiry,
    required this.externalUrl,
    required this.buttonText,
    required this.taxStatus,
    required this.taxClass,
    required this.manageStock,
    required this.stockQuantity,
    required this.backorders,
    required this.backordersAllowed,
    required this.backordered,
    required this.lowStockAmount,
    required this.soldIndividually,
    required this.weight,
     required this.dimensions,
    required this.shippingRequired,
    required this.shippingTaxable,
    required this.shippingClass,
    required this.shippingClassId,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.upsellIds,
    required this.crossSellIds,
    required this.parentId,
    required this.purchaseNote,
    required this.categories,
    required this.tags,
    required this.images,
    required this.attributes,
     required this.defaultAttributes,
     required this.variations,
     required this.groupedProducts,
    required this.menuOrder,
    required this.priceHtml,
    required this.relatedIds,
    required this.metaData,
    required this.stockStatus,
    required this.hasOptions,
    required this.postPassword,
    required this.subcategory,
    required this.collections,
    required this.links,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? permalink;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final DateTime? dateModified;
  final DateTime? dateModifiedGmt;
  final String? type;
  final String? status;
  final bool? featured;
  final String? catalogVisibility;
  final String? description;
  final String? shortDescription;
  final String? sku;
  final String? price;
  final String? regularPrice;
  final String? salePrice;
  final dynamic dateOnSaleFrom;
  final dynamic dateOnSaleFromGmt;
  final dynamic dateOnSaleTo;
  final dynamic dateOnSaleToGmt;
  final bool? onSale;
  final bool? purchasable;
  final int? totalSales;
  final bool? virtual;
  final bool? downloadable;
  final List<dynamic> downloads;
  final int? downloadLimit;
  final int? downloadExpiry;
  final String? externalUrl;
  final String? buttonText;
  final String? taxStatus;
  final String? taxClass;
  final bool? manageStock;
  final dynamic stockQuantity;
  final String? backorders;
  final bool? backordersAllowed;
  final bool? backordered;
  final dynamic lowStockAmount;
  final bool? soldIndividually;
  final String? weight;
  final Dimensions? dimensions;
  final bool? shippingRequired;
  final bool? shippingTaxable;
  final String? shippingClass;
  final int? shippingClassId;
  final bool? reviewsAllowed;
  final String? averageRating;
  final int? ratingCount;
  final List<dynamic> upsellIds;
  final List<dynamic> crossSellIds;
  final int? parentId;
  final String? purchaseNote;
  final List<Category> categories;
  final List<Category> tags;
  final List<CategoryWiseProductImage> images;
  final List<Attribute> attributes;
   final List<dynamic> defaultAttributes;
   final List<dynamic> variations;
   final List<dynamic> groupedProducts;
  final int? menuOrder;
  final String? priceHtml;
  final List<int> relatedIds;
  final List<MetaDatum> metaData;
  final String? stockStatus;
  final bool? hasOptions;
  final String? postPassword;
  final List<SubcategoryElement> subcategory;
  final List<SubcategoryElement> collections;
  final ProductLinks? links;

  factory ProductOfCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductOfCategoryModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      permalink: json["permalink"],
      dateCreated: DateTime.tryParse(json["date_created"] ?? ""),
      dateCreatedGmt: DateTime.tryParse(json["date_created_gmt"] ?? ""),
      dateModified: DateTime.tryParse(json["date_modified"] ?? ""),
      dateModifiedGmt: DateTime.tryParse(json["date_modified_gmt"] ?? ""),
      type: json["type"],
      status: json["status"],
      featured: json["featured"],
      catalogVisibility: json["catalog_visibility"],
      description: json["description"],
      shortDescription: json["short_description"],
      sku: json["sku"],
      price: json["price"],
      regularPrice: json["regular_price"],
      salePrice: json["sale_price"],
      dateOnSaleFrom: json["date_on_sale_from"],
      dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
      dateOnSaleTo: json["date_on_sale_to"],
      dateOnSaleToGmt: json["date_on_sale_to_gmt"],
      onSale: json["on_sale"],
      purchasable: json["purchasable"],
      totalSales: json["total_sales"],
      virtual: json["virtual"],
      downloadable: json["downloadable"],
      downloads: json["downloads"] == null
          ? []
          : List<dynamic>.from(json["downloads"]!.map((x) => x)),
      downloadLimit: json["download_limit"],
      downloadExpiry: json["download_expiry"],
      externalUrl: json["external_url"],
      buttonText: json["button_text"],
      taxStatus: json["tax_status"],
      taxClass: json["tax_class"],
      manageStock: json["manage_stock"],
      stockQuantity: json["stock_quantity"],
      backorders: json["backorders"],
      backordersAllowed: json["backorders_allowed"],
      backordered: json["backordered"],
      lowStockAmount: json["low_stock_amount"],
      soldIndividually: json["sold_individually"],
      weight: json["weight"],
      dimensions: json["dimensions"] == null
          ? null
          : Dimensions.fromJson(json["dimensions"]),
      shippingRequired: json["shipping_required"],
      shippingTaxable: json["shipping_taxable"],
      shippingClass: json["shipping_class"],
      shippingClassId: json["shipping_class_id"],
      reviewsAllowed: json["reviews_allowed"],
      averageRating: json["average_rating"],
      ratingCount: json["rating_count"],
      upsellIds: json["upsell_ids"] == null
          ? []
          : List<dynamic>.from(json["upsell_ids"]!.map((x) => x)),
      crossSellIds: json["cross_sell_ids"] == null
          ? []
          : List<dynamic>.from(json["cross_sell_ids"]!.map((x) => x)),
      parentId: json["parent_id"],
      purchaseNote: json["purchase_note"],
      categories: json["categories"] == null
          ? []
          : List<Category>.from(
              json["categories"]!.map((x) => Category.fromJson(x))),
      tags: json["tags"] == null
          ? []
          : List<Category>.from(json["tags"]!.map((x) => Category.fromJson(x))),
      images: json["images"] == null
          ? []
          : List<CategoryWiseProductImage>.from(
              json["images"]!.map((x) => CategoryWiseProductImage.fromJson(x))),
      attributes: json["attributes"] == null
          ? []
          : List<Attribute>.from(
              json["attributes"]!.map((x) => Attribute.fromJson(x))),
      defaultAttributes: json["default_attributes"] == null
          ? []
          : List<dynamic>.from(json["default_attributes"]!.map((x) => x)),
      variations: json["variations"] == null
          ? []
          : List<dynamic>.from(json["variations"]!.map((x) => x)),
      groupedProducts: json["grouped_products"] == null
          ? []
          : List<dynamic>.from(json["grouped_products"]!.map((x) => x)),
      menuOrder: json["menu_order"],
      priceHtml: json["price_html"],
      relatedIds: json["related_ids"] == null
          ? []
          : List<int>.from(json["related_ids"]!.map((x) => x)),
      metaData: json["meta_data"] == null
          ? []
          : List<MetaDatum>.from(
              json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
      stockStatus: json["stock_status"],
      hasOptions: json["has_options"],
      postPassword: json["post_password"],
      subcategory: json["subcategory"] == null
          ? []
          : List<SubcategoryElement>.from(
              json["subcategory"]!.map((x) => SubcategoryElement.fromJson(x))),
      collections: json["collections"] == null
          ? []
          : List<SubcategoryElement>.from(
              json["collections"]!.map((x) => SubcategoryElement.fromJson(x))),
      links: json["_links"] == null ? null : ProductLinks.fromJson(json["_links"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "type": type,
        "status": status,
        "featured": featured,
        "catalog_visibility": catalogVisibility,
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_from_gmt": dateOnSaleFromGmt,
        "date_on_sale_to": dateOnSaleTo,
        "date_on_sale_to_gmt": dateOnSaleToGmt,
        "on_sale": onSale,
        "purchasable": purchasable,
        "total_sales": totalSales,
        "virtual": virtual,
        "downloadable": downloadable,
        "downloads": downloads.map((x) => x).toList(),
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "external_url": externalUrl,
        "button_text": buttonText,
        "tax_status": taxStatus,
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "backorders": backorders,
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "low_stock_amount": lowStockAmount,
        "sold_individually": soldIndividually,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "upsell_ids": upsellIds.map((x) => x).toList(),
       "cross_sell_ids": crossSellIds.map((x) => x).toList(),
        "parent_id": parentId,
        "purchase_note": purchaseNote,
        "categories": categories.map((x) => x.toJson()).toList(),
        "tags": tags.map((x) => x.toJson()).toList(),
        "images": images.map((x) => x.toJson()).toList(),
        "attributes": attributes.map((x) => x.toJson()).toList(),
         "default_attributes": defaultAttributes.map((x) => x).toList(),
         "variations": variations.map((x) => x).toList(),
         "grouped_products": groupedProducts.map((x) => x).toList(),
        "menu_order": menuOrder,
        "price_html": priceHtml,
        "related_ids": relatedIds.map((x) => x).toList(),
        "meta_data": metaData.map((x) => x.toJson()).toList(),
        "stock_status": stockStatus,
        "has_options": hasOptions,
        "post_password": postPassword,
        "subcategory": subcategory.map((x) => x.toJson()).toList(),
        "collections": collections.map((x) => x.toJson()).toList(),
        "_links": links?.toJson(),
      };
}

class Attribute {
  Attribute({
    required this.id,
    required this.name,
    required this.slug,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  final int? id;
  final String? name;
  final String? slug;
  final int? position;
  final bool? visible;
  final bool? variation;
  final List<String> options;

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      position: json["position"],
      visible: json["visible"],
      variation: json["variation"],
      options: json["options"] == null
          ? []
          : List<String>.from(json["options"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "position": position,
        "visible": visible,
        "variation": variation,
        "options": options.map((x) => x).toList(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  final int? id;
  final String? name;
  final String? slug;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class SubcategoryElement {
  SubcategoryElement({
    required this.termId,
    required this.name,
    required this.slug,
    required this.termGroup,
    required this.termTaxonomyId,
    required this.taxonomy,
    required this.description,
    required this.parent,
    required this.count,
    required this.filter,
  });

  final int? termId;
  final String? name;
  final String? slug;
  final int? termGroup;
  final int? termTaxonomyId;
  final String? taxonomy;
  final String? description;
  final int? parent;
  final int? count;
  final String? filter;

  factory SubcategoryElement.fromJson(Map<String, dynamic> json) {
    return SubcategoryElement(
      termId: json["term_id"],
      name: json["name"],
      slug: json["slug"],
      termGroup: json["term_group"],
      termTaxonomyId: json["term_taxonomy_id"],
      taxonomy: json["taxonomy"],
      description: json["description"],
      parent: json["parent"],
      count: json["count"],
      filter: json["filter"],
    );
  }

  Map<String, dynamic> toJson() => {
        "term_id": termId,
        "name": name,
        "slug": slug,
        "term_group": termGroup,
        "term_taxonomy_id": termTaxonomyId,
        "taxonomy": taxonomy,
        "description": description,
        "parent": parent,
        "count": count,
        "filter": filter,
      };
}

 class Dimensions {
   Dimensions({
     required this.length,
     required this.width,
     required this.height,
   });

   final String? length;
   final String? width;
   final String? height;

   factory Dimensions.fromJson(Map<String, dynamic> json) {
     return Dimensions(
       length: json["length"],
       width: json["width"],
       height: json["height"],
     );
   }

   Map<String, dynamic> toJson() => {
         "length": length,
         "width": width,
         "height": height,
       };
 }

class CategoryWiseProductImage {
  CategoryWiseProductImage({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });

  final int? id;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final DateTime? dateModified;
  final DateTime? dateModifiedGmt;
  final String? src;
  final String? name;
  final String? alt;

  factory CategoryWiseProductImage.fromJson(Map<String, dynamic> json) {
    return CategoryWiseProductImage(
      id: json["id"],
      dateCreated: DateTime.tryParse(json["date_created"] ?? ""),
      dateCreatedGmt: DateTime.tryParse(json["date_created_gmt"] ?? ""),
      dateModified: DateTime.tryParse(json["date_modified"] ?? ""),
      dateModifiedGmt: DateTime.tryParse(json["date_modified_gmt"] ?? ""),
      src: json["src"],
      name: json["name"],
      alt: json["alt"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "src": src,
        "name": name,
        "alt": alt,
      };
}

class ProductLinks {
  ProductLinks({
    required this.self,
    required this.collection,
  });

  final List<SelfElement> self;
  final List<SelfElement> collection;

  factory ProductLinks.fromJson(Map<String, dynamic> json) {
    return ProductLinks(
      self: json["self"] == null
          ? []
          : List<SelfElement>.from(
              json["self"]!.map((x) => SelfElement.fromJson(x))),
      collection: json["collection"] == null
          ? []
          : List<SelfElement>.from(
              json["collection"]!.map((x) => SelfElement.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "self": self.map((x) => x.toJson()).toList(),
        "collection": collection.map((x) => x.toJson()).toList(),
      };
}

class SelfElement {
  SelfElement({
    required this.href,
  });

  final String? href;

  factory SelfElement.fromJson(Map<String, dynamic> json) {
    return SelfElement(
      href: json["href"],
    );
  }

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class MetaDatum {
  MetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

  final int? id;
  final String? key;
  final dynamic value;

  factory MetaDatum.fromJson(Map<String, dynamic> json) {
    return MetaDatum(
      id: json["id"],
      key: json["key"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}

class PurpleValue {
  PurpleValue({
    required this.diamondWeight,
    required this.diamondQuality,
    required this.diamondShape,
    required this.diamondPieces,
    required this.diamondSieve,
    required this.id,
    required this.color,
    required this.diamondType,
    required this.diamondCut,
  });

  final String? diamondWeight;
  final String? diamondQuality;
  final String? diamondShape;
  final int? diamondPieces;
  final String? diamondSieve;
  final int? id;
  final String? color;
  final String? diamondType;
  final String? diamondCut;

  factory PurpleValue.fromJson(Map<String, dynamic> json) {
    return PurpleValue(
      diamondWeight: json["diamond_weight"],
      diamondQuality: json["diamond_quality"],
      diamondShape: json["diamond_shape"],
      diamondPieces: json["diamond_pieces"],
      diamondSieve: json["diamond_sieve"],
      id: json["id"],
      color: json["color"],
      diamondType: json["diamond_type"],
      diamondCut: json["diamond_cut"],
    );
  }

  Map<String, dynamic> toJson() => {
        "diamond_weight": diamondWeight,
        "diamond_quality": diamondQuality,
        "diamond_shape": diamondShape,
        "diamond_pieces": diamondPieces,
        "diamond_sieve": diamondSieve,
        "id": id,
        "color": color,
        "diamond_type": diamondType,
        "diamond_cut": diamondCut,
      };
}

class FluffyValue {
  FluffyValue({
    required this.seoTitle,
    required this.seoDescription,
    required this.seoKeywords,
    required this.min,
    required this.max,
    required this.metal,
    required this.diamond,
    required this.making,
    required this.breakup,
    required this.master,
    required this.metalBreakup,
    required this.metalRates,
    required this.diamondBreakup,
    required this.diamondRates,
    required this.labourBreakup,
    required this.discount,
    required this.totalDiscount,
    required this.totalPrice,
    required this.tax,
    required this.hasManualPrice,
    required this.priceWithoutTax,
    required this.price,
    required this.the1,
    required this.the2,
    required this.gemstone,
    required this.extracharges,
    required this.gemstoneBreakup,
    required this.gemstoneRates,
    required this.customize,
    required this.the3,
    required this.the4,
    required this.the5,
  });

  final String? seoTitle;
  final String? seoDescription;
  final dynamic seoKeywords;
  final String? min;
  final String? max;
  final Metal? metal;
  final Map<String, Diamond> diamond;
  final Making? making;
  final Breakup? breakup;
  final Master? master;
  final MetalBreakup? metalBreakup;
  final MetalRates? metalRates;
  final Map<String, int> diamondBreakup;
  final Map<String, int> diamondRates;
  final List<dynamic> labourBreakup;
  final Discount? discount;
  final int? totalDiscount;
  final int? totalPrice;
  final int? tax;
  final bool? hasManualPrice;
  final int? priceWithoutTax;
  final int? price;
  final The1? the1;
  final The1? the2;
  final Map<String, Gemstone> gemstone;
  final Map<String, Extracharge> extracharges;
  final Map<String, int> gemstoneBreakup;
  final Map<String, int> gemstoneRates;
  final Customize? customize;
  final The3? the3;
  final The3? the4;
  final The5? the5;

  factory FluffyValue.fromJson(Map<String, dynamic> json) {
    return FluffyValue(
      seoTitle: json["seo_title"],
      seoDescription: json["seo_description"],
      seoKeywords: json["seo_keywords"],
      min: json["min"],
      max: json["max"],
      metal: json["metal"] == null ? null : Metal.fromJson(json["metal"]),
      diamond: Map.from(json["diamond"])
          .map((k, v) => MapEntry<String, Diamond>(k, Diamond.fromJson(v))),
      making: json["making"] == null ? null : Making.fromJson(json["making"]),
      breakup:
          json["breakup"] == null ? null : Breakup.fromJson(json["breakup"]),
      master: json["master"] == null ? null : Master.fromJson(json["master"]),
      metalBreakup: json["metalBreakup"] == null
          ? null
          : MetalBreakup.fromJson(json["metalBreakup"]),
      metalRates: json["metalRates"] == null
          ? null
          : MetalRates.fromJson(json["metalRates"]),
      diamondBreakup: Map.from(json["diamondBreakup"])
          .map((k, v) => MapEntry<String, int>(k, v)),
      diamondRates: Map.from(json["diamondRates"])
          .map((k, v) => MapEntry<String, int>(k, v)),
       labourBreakup: json["labourBreakup"] == null
           ? []
           : List<dynamic>.from(json["labourBreakup"]!.map((x) => x)),
      discount:
          json["discount"] == null ? null : Discount.fromJson(json["discount"]),
      totalDiscount: json["totalDiscount"],
      totalPrice: json["totalPrice"],
      tax: json["tax"],
      hasManualPrice: json["has_manual_price"],
      priceWithoutTax: json["priceWithoutTax"],
      price: json["price"],
      the1: json["1"] == null ? null : The1.fromJson(json["1"]),
      the2: json["2"] == null ? null : The1.fromJson(json["2"]),
      gemstone: Map.from(json["gemstone"])
          .map((k, v) => MapEntry<String, Gemstone>(k, Gemstone.fromJson(v))),
      extracharges: Map.from(json["extracharges"]).map(
          (k, v) => MapEntry<String, Extracharge>(k, Extracharge.fromJson(v))),
      gemstoneBreakup: Map.from(json["gemstoneBreakup"])
          .map((k, v) => MapEntry<String, int>(k, v)),
      gemstoneRates: Map.from(json["gemstoneRates"])
          .map((k, v) => MapEntry<String, int>(k, v)),
      customize: json["customize"] == null
          ? null
          : Customize.fromJson(json["customize"]),
      the3: json["3"] == null ? null : The3.fromJson(json["3"]),
      the4: json["4"] == null ? null : The3.fromJson(json["4"]),
      the5: json["5"] == null ? null : The5.fromJson(json["5"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "seo_title": seoTitle,
        "seo_description": seoDescription,
        "seo_keywords": seoKeywords,
        "min": min,
        "max": max,
        "metal": metal?.toJson(),
        "diamond": Map.from(diamond)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "making": making?.toJson(),
        "breakup": breakup?.toJson(),
        "master": master?.toJson(),
        "metalBreakup": metalBreakup?.toJson(),
        "metalRates": metalRates?.toJson(),
        "diamondBreakup": Map.from(diamondBreakup)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "diamondRates": Map.from(diamondRates)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
         "labourBreakup": labourBreakup.map((x) => x).toList(),
        "discount": discount?.toJson(),
        "totalDiscount": totalDiscount,
        "totalPrice": totalPrice,
        "tax": tax,
        "has_manual_price": hasManualPrice,
        "priceWithoutTax": priceWithoutTax,
        "price": price,
        "1": the1?.toJson(),
        "2": the2?.toJson(),
        "gemstone": Map.from(gemstone)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "extracharges": Map.from(extracharges)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "gemstoneBreakup": Map.from(gemstoneBreakup)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "gemstoneRates": Map.from(gemstoneRates)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "customize": customize?.toJson(),
        "3": the3?.toJson(),
        "4": the4?.toJson(),
        "5": the5?.toJson(),
      };
}

class Breakup {
  Breakup({
    required this.metal,
    required this.tax,
    required this.total,
    required this.extraCharges,
  });

  final int? metal;
  final int? tax;
  final int? total;
  final int? extraCharges;

  factory Breakup.fromJson(Map<String, dynamic> json) {
    return Breakup(
      metal: json["metal"],
      tax: json["tax"],
      total: json["total"],
      extraCharges: json["extra_charges"],
    );
  }

  Map<String, dynamic> toJson() => {
        "metal": metal,
        "tax": tax,
        "total": total,
        "extra_charges": extraCharges,
      };
}

class Customize {
  Customize({
    required this.diamond,
    required this.labour,
    required this.colorstone,
    required this.gemstone,
  });

  final int? diamond;
  final int? labour;
  final int? colorstone;
  final int? gemstone;

  factory Customize.fromJson(Map<String, dynamic> json) {
    return Customize(
      diamond: json["diamond"],
      labour: json["labour"],
      colorstone: json["colorstone"],
      gemstone: json["gemstone"],
    );
  }

  Map<String, dynamic> toJson() => {
        "diamond": diamond,
        "labour": labour,
        "colorstone": colorstone,
        "gemstone": gemstone,
      };
}

class Diamond {
  Diamond({
    required this.clarity,
    required this.color,
    required this.size,
    required this.weight,
    required this.cut,
    required this.rate,
    required this.amount,
  });

  final String? clarity;
  final String? color;
  final String? size;
  final String? weight;
  final String? cut;
  final int? rate;
  final int? amount;

  factory Diamond.fromJson(Map<String, dynamic> json) {
    return Diamond(
      clarity: json["clarity"],
      color: json["color"],
      size: json["size"],
      weight: json["weight"],
      cut: json["cut"],
      rate: json["rate"],
      amount: json["amount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "clarity": clarity,
        "color": color,
        "size": size,
        "weight": weight,
        "cut": cut,
        "rate": rate,
        "amount": amount,
      };
}

class Discount {
  Discount({
    required this.labour,
    required this.metal,
    required this.diamond,
    required this.gemstone,
    required this.total,
  });

  final int? labour;
  final int? metal;
  final int? diamond;
  final int? gemstone;
  final int? total;

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      labour: json["labour"],
      metal: json["metal"],
      diamond: json["diamond"],
      gemstone: json["gemstone"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "labour": labour,
        "metal": metal,
        "diamond": diamond,
        "gemstone": gemstone,
        "total": total,
      };
}

class Extracharge {
  Extracharge({
    required this.label,
    required this.value,
  });

  final String? label;
  final String? value;

  factory Extracharge.fromJson(Map<String, dynamic> json) {
    return Extracharge(
      label: json["label"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}

class Gemstone {
  Gemstone({
    required this.clarity,
    required this.type,
    required this.shape,
    required this.size,
    required this.weight,
  });

  final String? clarity;
  final String? type;
  final String? shape;
  final String? size;
  final String? weight;

  factory Gemstone.fromJson(Map<String, dynamic> json) {
    return Gemstone(
      clarity: json["clarity"],
      type: json["type"],
      shape: json["shape"],
      size: json["size"],
      weight: json["weight"],
    );
  }

  Map<String, dynamic> toJson() => {
        "clarity": clarity,
        "type": type,
        "shape": shape,
        "size": size,
        "weight": weight,
      };
}

class Making {
  Making({
    required this.pergramAmt,
    required this.from,
    required this.wastage,
    required this.minimumMaking,
  });

  final String? pergramAmt;
  final String? from;
  final String? wastage;
  final String? minimumMaking;

  factory Making.fromJson(Map<String, dynamic> json) {
    return Making(
      pergramAmt: json["pergram_amt"],
      from: json["from"],
      wastage: json["wastage"],
      minimumMaking: json["minimum_making"],
    );
  }

  Map<String, dynamic> toJson() => {
        "pergram_amt": pergramAmt,
        "from": from,
        "wastage": wastage,
        "minimum_making": minimumMaking,
      };
}

class Master {
  Master({
    required this.metal,
    required this.extraCharges,
    required this.diamond,
    required this.labour,
    required this.colorstone,
    required this.gemstone,
  });

  final int? metal;
  final int? extraCharges;
  final int? diamond;
  final int? labour;
  final int? colorstone;
  final int? gemstone;

  factory Master.fromJson(Map<String, dynamic> json) {
    return Master(
      metal: json["metal"],
      extraCharges: json["extraCharges"],
      diamond: json["diamond"],
      labour: json["labour"],
      colorstone: json["colorstone"],
      gemstone: json["gemstone"],
    );
  }

  Map<String, dynamic> toJson() => {
        "metal": metal,
        "extraCharges": extraCharges,
        "diamond": diamond,
        "labour": labour,
        "colorstone": colorstone,
        "gemstone": gemstone,
      };
}

class Metal {
  Metal({
    required this.gold,
    required this.silver,
    required this.platinum,
  });

  final Gold? gold;
  final MetalSilver? silver;
  final MetalPlatinum? platinum;

  factory Metal.fromJson(Map<String, dynamic> json) {
    return Metal(
      gold: json["gold"] == null ? null : Gold.fromJson(json["gold"]),
      silver:
          json["silver"] == null ? null : MetalSilver.fromJson(json["silver"]),
      platinum: json["platinum"] == null
          ? null
          : MetalPlatinum.fromJson(json["platinum"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "gold": gold?.toJson(),
        "silver": silver?.toJson(),
        "platinum": platinum?.toJson(),
      };
}

class Gold {
  Gold({
    required this.goldGross,
    required this.goldNet,
    required this.goldPurity,
    required this.rate,
    required this.amount,
  });

  final String? goldGross;
  final String? goldNet;
  final String? goldPurity;
  final int? rate;
  final int? amount;

  factory Gold.fromJson(Map<String, dynamic> json) {
    return Gold(
      goldGross: json["gold_gross"],
      goldNet: json["gold_net"],
      goldPurity: json["gold_purity"],
      rate: json["rate"],
      amount: json["amount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "gold_gross": goldGross,
        "gold_net": goldNet,
        "gold_purity": goldPurity,
        "rate": rate,
        "amount": amount,
      };
}

class MetalPlatinum {
  MetalPlatinum({
    required this.platiniumGross,
    required this.platiniumNet,
    required this.platinumPurity,
    required this.rate,
    required this.amount,
  });

  final String? platiniumGross;
  final String? platiniumNet;
  final String? platinumPurity;
  final int? rate;
  final int? amount;

  factory MetalPlatinum.fromJson(Map<String, dynamic> json) {
    return MetalPlatinum(
      platiniumGross: json["platinium_gross"],
      platiniumNet: json["platinium_net"],
      platinumPurity: json["platinum_purity"],
      rate: json["rate"],
      amount: json["amount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "platinium_gross": platiniumGross,
        "platinium_net": platiniumNet,
        "platinum_purity": platinumPurity,
        "rate": rate,
        "amount": amount,
      };
}

class MetalSilver {
  MetalSilver({
    required this.silverGross,
    required this.silverNet,
    required this.silverPurity,
    required this.rate,
    required this.amount,
  });

  final String? silverGross;
  final String? silverNet;
  final String? silverPurity;
  final String? rate;
  final int? amount;

  factory MetalSilver.fromJson(Map<String, dynamic> json) {
    return MetalSilver(
      silverGross: json["silver_gross"],
      silverNet: json["silver_net"],
      silverPurity: json["silver_purity"],
      rate: json["rate"],
      amount: json["amount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "silver_gross": silverGross,
        "silver_net": silverNet,
        "silver_purity": silverPurity,
        "rate": rate,
        "amount": amount,
      };
}

class MetalBreakup {
  MetalBreakup({
    required this.gold,
    required this.silver,
    required this.platinum,
  });

  final int? gold;
  final int? silver;
  final int? platinum;

  factory MetalBreakup.fromJson(Map<String, dynamic> json) {
    return MetalBreakup(
      gold: json["gold"],
      silver: json["silver"],
      platinum: json["platinum"],
    );
  }

  Map<String, dynamic> toJson() => {
        "gold": gold,
        "silver": silver,
        "platinum": platinum,
      };
}

class MetalRates {
  MetalRates({
    required this.gold,
    required this.silver,
    required this.platinum,
  });

  final Map<String, int> gold;
  final dynamic silver;
  final dynamic platinum;

  factory MetalRates.fromJson(Map<String, dynamic> json) {
    return MetalRates(
      gold: Map.from(json["gold"]).map((k, v) => MapEntry<String, int>(k, v)),
      silver: json["silver"],
      platinum: json["platinum"],
    );
  }

  Map<String, dynamic> toJson() => {
        "gold": Map.from(gold).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "silver": silver,
        "platinum": platinum,
      };
}

class PlatinumPlatinum {
  PlatinumPlatinum({
    required this.the950,
  });

  final int? the950;

  factory PlatinumPlatinum.fromJson(Map<String, dynamic> json) {
    return PlatinumPlatinum(
      the950: json["950"],
    );
  }

  Map<String, dynamic> toJson() => {
        "950": the950,
      };
}

class SilverSilver {
  SilverSilver({
    required this.the995,
  });

  final String? the995;

  factory SilverSilver.fromJson(Map<String, dynamic> json) {
    return SilverSilver(
      the995: json["995"],
    );
  }

  Map<String, dynamic> toJson() => {
        "995": the995,
      };
}

class The1 {
  The1({
    required this.diamondWeight,
    required this.diamondType,
    required this.diamondQuality,
    required this.diamondShape,
    required this.diamondCut,
    required this.diamondPieces,
    required this.diamondRate,
    required this.diamondSieve,
    required this.colorstoneWeight,
    required this.colorstoneQuality,
    required this.colorstoneShape,
    required this.colorstoneType,
    required this.colorstonePieces,
    required this.colorstoneSize,
    required this.colorstoneRate,
    required this.extraChargeLabel,
    required this.extraChargeValue,
    required this.currentRate,
  });

  final String? diamondWeight;
  final String? diamondType;
  final String? diamondQuality;
  final String? diamondShape;
  final String? diamondCut;
  final dynamic diamondPieces;
  final String? diamondRate;
  final String? diamondSieve;
  final String? colorstoneWeight;
  final String? colorstoneQuality;
  final String? colorstoneShape;
  final String? colorstoneType;
  final String? colorstonePieces;
  final String? colorstoneSize;
  final String? colorstoneRate;
  final String? extraChargeLabel;
  final String? extraChargeValue;
  final String? currentRate;

  factory The1.fromJson(Map<String, dynamic> json) {
    return The1(
      diamondWeight: json["diamond_weight"],
      diamondType: json["diamond_type"],
      diamondQuality: json["diamond_quality"],
      diamondShape: json["diamond_shape"],
      diamondCut: json["diamond_cut"],
      diamondPieces: json["diamond_pieces"],
      diamondRate: json["diamond_rate"],
      diamondSieve: json["diamond_sieve"],
      colorstoneWeight: json["colorstone_weight"],
      colorstoneQuality: json["colorstone_quality"],
      colorstoneShape: json["colorstone_shape"],
      colorstoneType: json["colorstone_type"],
      colorstonePieces: json["colorstone_pieces"],
      colorstoneSize: json["colorstone_size"],
      colorstoneRate: json["colorstone_rate"],
      extraChargeLabel: json["extra_charge_label"],
      extraChargeValue: json["extra_charge_value"],
      currentRate: json["current_rate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "diamond_weight": diamondWeight,
        "diamond_type": diamondType,
        "diamond_quality": diamondQuality,
        "diamond_shape": diamondShape,
        "diamond_cut": diamondCut,
        "diamond_pieces": diamondPieces,
        "diamond_rate": diamondRate,
        "diamond_sieve": diamondSieve,
        "colorstone_weight": colorstoneWeight,
        "colorstone_quality": colorstoneQuality,
        "colorstone_shape": colorstoneShape,
        "colorstone_type": colorstoneType,
        "colorstone_pieces": colorstonePieces,
        "colorstone_size": colorstoneSize,
        "colorstone_rate": colorstoneRate,
        "extra_charge_label": extraChargeLabel,
        "extra_charge_value": extraChargeValue,
        "current_rate": currentRate,
      };
}

class The3 {
  The3({
    required this.extraChargeLabel,
    required this.extraChargeValue,
    required this.colorstonePieces,
  });

  final String? extraChargeLabel;
  final String? extraChargeValue;
  final String? colorstonePieces;

  factory The3.fromJson(Map<String, dynamic> json) {
    return The3(
      extraChargeLabel: json["extra_charge_label"],
      extraChargeValue: json["extra_charge_value"],
      colorstonePieces: json["colorstone_pieces"],
    );
  }

  Map<String, dynamic> toJson() => {
        "extra_charge_label": extraChargeLabel,
        "extra_charge_value": extraChargeValue,
        "colorstone_pieces": colorstonePieces,
      };
}

class The5 {
  The5({
    required this.extraChargeLabel,
    required this.extraChargeValue,
  });

  final String? extraChargeLabel;
  final String? extraChargeValue;

  factory The5.fromJson(Map<String, dynamic> json) {
    return The5(
      extraChargeLabel: json["extra_charge_label"],
      extraChargeValue: json["extra_charge_value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "extra_charge_label": extraChargeLabel,
        "extra_charge_value": extraChargeValue,
      };
}
