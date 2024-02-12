class DigiGoldPlanModel {
    DigiGoldPlanModel({
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
    final List<dynamic> tags;
    final List<Image> images;
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
    final List<dynamic> subcategory;
    final List<dynamic> collections;
    final Links? links;

    factory DigiGoldPlanModel.fromJson(Map<String, dynamic> json){ 
        return DigiGoldPlanModel(
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
            downloads: json["downloads"] == null ? [] : List<dynamic>.from(json["downloads"]!.map((x) => x)),
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
            dimensions: json["dimensions"] == null ? null : Dimensions.fromJson(json["dimensions"]),
            shippingRequired: json["shipping_required"],
            shippingTaxable: json["shipping_taxable"],
            shippingClass: json["shipping_class"],
            shippingClassId: json["shipping_class_id"],
            reviewsAllowed: json["reviews_allowed"],
            averageRating: json["average_rating"],
            ratingCount: json["rating_count"],
            upsellIds: json["upsell_ids"] == null ? [] : List<dynamic>.from(json["upsell_ids"]!.map((x) => x)),
            crossSellIds: json["cross_sell_ids"] == null ? [] : List<dynamic>.from(json["cross_sell_ids"]!.map((x) => x)),
            parentId: json["parent_id"],
            purchaseNote: json["purchase_note"],
            categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
            tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
            images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
            attributes: json["attributes"] == null ? [] : List<Attribute>.from(json["attributes"]!.map((x) => Attribute.fromJson(x))),
            defaultAttributes: json["default_attributes"] == null ? [] : List<dynamic>.from(json["default_attributes"]!.map((x) => x)),
            variations: json["variations"] == null ? [] : List<dynamic>.from(json["variations"]!.map((x) => x)),
            groupedProducts: json["grouped_products"] == null ? [] : List<dynamic>.from(json["grouped_products"]!.map((x) => x)),
            menuOrder: json["menu_order"],
            priceHtml: json["price_html"],
            relatedIds: json["related_ids"] == null ? [] : List<int>.from(json["related_ids"]!.map((x) => x)),
            metaData: json["meta_data"] == null ? [] : List<MetaDatum>.from(json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
            stockStatus: json["stock_status"],
            hasOptions: json["has_options"],
            postPassword: json["post_password"],
            subcategory: json["subcategory"] == null ? [] : List<dynamic>.from(json["subcategory"]!.map((x) => x)),
            collections: json["collections"] == null ? [] : List<dynamic>.from(json["collections"]!.map((x) => x)),
            links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
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
        "categories": categories.map((x) => x?.toJson()).toList(),
        "tags": tags.map((x) => x).toList(),
        "images": images.map((x) => x?.toJson()).toList(),
        "attributes": attributes.map((x) => x?.toJson()).toList(),
        "default_attributes": defaultAttributes.map((x) => x).toList(),
        "variations": variations.map((x) => x).toList(),
        "grouped_products": groupedProducts.map((x) => x).toList(),
        "menu_order": menuOrder,
        "price_html": priceHtml,
        "related_ids": relatedIds.map((x) => x).toList(),
        "meta_data": metaData.map((x) => x?.toJson()).toList(),
        "stock_status": stockStatus,
        "has_options": hasOptions,
        "post_password": postPassword,
        "subcategory": subcategory.map((x) => x).toList(),
        "collections": collections.map((x) => x).toList(),
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

    factory Attribute.fromJson(Map<String, dynamic> json){ 
        return Attribute(
            id: json["id"],
            name: json["name"],
            slug: json["slug"],
            position: json["position"],
            visible: json["visible"],
            variation: json["variation"],
            options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
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

    factory Category.fromJson(Map<String, dynamic> json){ 
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

class Dimensions {
    Dimensions({
        required this.length,
        required this.width,
        required this.height,
    });

    final String? length;
    final String? width;
    final String? height;

    factory Dimensions.fromJson(Map<String, dynamic> json){ 
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

class Image {
    Image({
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

    factory Image.fromJson(Map<String, dynamic> json){ 
        return Image(
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

class Links {
    Links({
        required this.self,
        required this.collection,
    });

    final List<Collection> self;
    final List<Collection> collection;

    factory Links.fromJson(Map<String, dynamic> json){ 
        return Links(
            self: json["self"] == null ? [] : List<Collection>.from(json["self"]!.map((x) => Collection.fromJson(x))),
            collection: json["collection"] == null ? [] : List<Collection>.from(json["collection"]!.map((x) => Collection.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "self": self.map((x) => x?.toJson()).toList(),
        "collection": collection.map((x) => x?.toJson()).toList(),
    };

}

class Collection {
    Collection({
        required this.href,
    });

    final String? href;

    factory Collection.fromJson(Map<String, dynamic> json){ 
        return Collection(
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
    final dynamic? value;

    factory MetaDatum.fromJson(Map<String, dynamic> json){ 
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

class ValueClass {
    ValueClass({
        required this.the1,
        required this.metal,
        required this.breakup,
        required this.master,
        required this.metalBreakup,
        required this.metalRates,
        required this.labourBreakup,
        required this.discount,
        required this.totalDiscount,
        required this.totalPrice,
        required this.tax,
        required this.hasManualPrice,
        required this.priceWithoutTax,
        required this.price,
        required this.totalTax,
        required this.priceWithoutTaxWithDiscount,
        required this.the2,
        required this.the3,
        required this.the4,
        required this.the5,
        required this.the6,
        required this.the7,
    });

    final The1? the1;
    final Metal? metal;
    final Breakup? breakup;
    final Master? master;
    final MetalBreakup? metalBreakup;
    final MetalRates? metalRates;
    final LabourBreakup? labourBreakup;
    final Discount? discount;
    final int? totalDiscount;
    final int? totalPrice;
    final int? tax;
    final bool? hasManualPrice;
    final int? priceWithoutTax;
    final int? price;
    final int? totalTax;
    final int? priceWithoutTaxWithDiscount;
    final The2? the2;
    final The2? the3;
    final The2? the4;
    final The5? the5;
    final The5? the6;
    final The5? the7;

    factory ValueClass.fromJson(Map<String, dynamic> json){ 
        return ValueClass(
            the1: json["1"] == null ? null : The1.fromJson(json["1"]),
            metal: json["metal"] == null ? null : Metal.fromJson(json["metal"]),
            breakup: json["breakup"] == null ? null : Breakup.fromJson(json["breakup"]),
            master: json["master"] == null ? null : Master.fromJson(json["master"]),
            metalBreakup: json["metalBreakup"] == null ? null : MetalBreakup.fromJson(json["metalBreakup"]),
            metalRates: json["metalRates"] == null ? null : MetalRates.fromJson(json["metalRates"]),
            labourBreakup: json["labourBreakup"] == null ? null : LabourBreakup.fromJson(json["labourBreakup"]),
            discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
            totalDiscount: json["totalDiscount"],
            totalPrice: json["totalPrice"],
            tax: json["tax"],
            hasManualPrice: json["has_manual_price"],
            priceWithoutTax: json["priceWithoutTax"],
            price: json["price"],
            totalTax: json["totalTax"],
            priceWithoutTaxWithDiscount: json["priceWithoutTaxWithDiscount"],
            the2: json["2"] == null ? null : The2.fromJson(json["2"]),
            the3: json["3"] == null ? null : The2.fromJson(json["3"]),
            the4: json["4"] == null ? null : The2.fromJson(json["4"]),
            the5: json["5"] == null ? null : The5.fromJson(json["5"]),
            the6: json["6"] == null ? null : The5.fromJson(json["6"]),
            the7: json["7"] == null ? null : The5.fromJson(json["7"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "1": the1?.toJson(),
        "metal": metal?.toJson(),
        "breakup": breakup?.toJson(),
        "master": master?.toJson(),
        "metalBreakup": metalBreakup?.toJson(),
        "metalRates": metalRates?.toJson(),
        "labourBreakup": labourBreakup?.toJson(),
        "discount": discount?.toJson(),
        "totalDiscount": totalDiscount,
        "totalPrice": totalPrice,
        "tax": tax,
        "has_manual_price": hasManualPrice,
        "priceWithoutTax": priceWithoutTax,
        "price": price,
        "totalTax": totalTax,
        "priceWithoutTaxWithDiscount": priceWithoutTaxWithDiscount,
        "2": the2?.toJson(),
        "3": the3?.toJson(),
        "4": the4?.toJson(),
        "5": the5?.toJson(),
        "6": the6?.toJson(),
        "7": the7?.toJson(),
    };

}

class Breakup {
    Breakup({
        required this.making,
        required this.tax,
        required this.total,
    });

    final int? making;
    final int? tax;
    final int? total;

    factory Breakup.fromJson(Map<String, dynamic> json){ 
        return Breakup(
            making: json["making"],
            tax: json["tax"],
            total: json["total"],
        );
    }

    Map<String, dynamic> toJson() => {
        "making": making,
        "tax": tax,
        "total": total,
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

    factory Discount.fromJson(Map<String, dynamic> json){ 
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

class LabourBreakup {
    LabourBreakup({
        required this.labour,
        required this.wastage,
    });

    final int? labour;
    final int? wastage;

    factory LabourBreakup.fromJson(Map<String, dynamic> json){ 
        return LabourBreakup(
            labour: json["labour"],
            wastage: json["wastage"],
        );
    }

    Map<String, dynamic> toJson() => {
        "labour": labour,
        "wastage": wastage,
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

    factory Master.fromJson(Map<String, dynamic> json){ 
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
    });

    final MetalGold? gold;

    factory Metal.fromJson(Map<String, dynamic> json){ 
        return Metal(
            gold: json["gold"] == null ? null : MetalGold.fromJson(json["gold"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "gold": gold?.toJson(),
    };

}

class MetalGold {
    MetalGold({
        required this.rate,
        required this.goldGross,
        required this.goldPurity,
    });

    final dynamic? rate;
    final String? goldGross;
    final String? goldPurity;

    factory MetalGold.fromJson(Map<String, dynamic> json){ 
        return MetalGold(
            rate: json["rate"],
            goldGross: json["gold_gross"],
            goldPurity: json["gold_purity"],
        );
    }

    Map<String, dynamic> toJson() => {
        "rate": rate,
        "gold_gross": goldGross,
        "gold_purity": goldPurity,
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

    factory MetalBreakup.fromJson(Map<String, dynamic> json){ 
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

    final MetalRatesGold? gold;
    final List<dynamic> silver;
    final List<dynamic> platinum;

    factory MetalRates.fromJson(Map<String, dynamic> json){ 
        return MetalRates(
            gold: json["gold"] == null ? null : MetalRatesGold.fromJson(json["gold"]),
            silver: json["silver"] == null ? [] : List<dynamic>.from(json["silver"]!.map((x) => x)),
            platinum: json["platinum"] == null ? [] : List<dynamic>.from(json["platinum"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "gold": gold?.toJson(),
        "silver": silver.map((x) => x).toList(),
        "platinum": platinum.map((x) => x).toList(),
    };

}

class MetalRatesGold {
    MetalRatesGold({
        required this.empty,
        required this.the750,
        required this.the916,
        required this.the999,
    });

    final String? empty;
    final int? the750;
    final int? the916;
    final int? the999;

    factory MetalRatesGold.fromJson(Map<String, dynamic> json){ 
        return MetalRatesGold(
            empty: json[""],
            the750: json["750"],
            the916: json["916"],
            the999: json["999"],
        );
    }

    Map<String, dynamic> toJson() => {
        "": empty,
        "750": the750,
        "916": the916,
        "999": the999,
    };

}

class The1 {
    The1({
        required this.id,
        required this.title,
        required this.gift,
        required this.month,
        required this.rewardAmount,
        required this.rewardMonth,
    });

    final String? id;
    final String? title;
    final String? gift;
    final dynamic? month;
    final String? rewardAmount;
    final String? rewardMonth;

    factory The1.fromJson(Map<String, dynamic> json){ 
        return The1(
            id: json["id"],
            title: json["title"],
            gift: json["gift"],
            month: json["month"],
            rewardAmount: json["reward_amount"],
            rewardMonth: json["reward_month"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "gift": gift,
        "month": month,
        "reward_amount": rewardAmount,
        "reward_month": rewardMonth,
    };

}

class The2 {
    The2({
        required this.rewardAmount,
        required this.rewardMonth,
        required this.id,
        required this.title,
        required this.gift,
        required this.month,
    });

    final String? rewardAmount;
    final String? rewardMonth;
    final String? id;
    final String? title;
    final String? gift;
    final int? month;

    factory The2.fromJson(Map<String, dynamic> json){ 
        return The2(
            rewardAmount: json["reward_amount"],
            rewardMonth: json["reward_month"],
            id: json["id"],
            title: json["title"],
            gift: json["gift"],
            month: json["month"],
        );
    }

    Map<String, dynamic> toJson() => {
        "reward_amount": rewardAmount,
        "reward_month": rewardMonth,
        "id": id,
        "title": title,
        "gift": gift,
        "month": month,
    };

}

class The5 {
    The5({
        required this.rewardAmount,
        required this.rewardMonth,
    });

    final String? rewardAmount;
    final String? rewardMonth;

    factory The5.fromJson(Map<String, dynamic> json){ 
        return The5(
            rewardAmount: json["reward_amount"],
            rewardMonth: json["reward_month"],
        );
    }

    Map<String, dynamic> toJson() => {
        "reward_amount": rewardAmount,
        "reward_month": rewardMonth,
    };

}
