class ProductModel {
    ProductModel({
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
    final int? stockQuantity;
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
    final List<ProductModelCollection> collections;
    final Links? links;

    factory ProductModel.fromJson(Map<String, dynamic> json){ 
        return ProductModel(
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
            collections: json["collections"] == null ? [] : List<ProductModelCollection>.from(json["collections"]!.map((x) => ProductModelCollection.fromJson(x))),
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
        "categories": categories.map((x) => x.toJson()).toList(),
        "tags": tags.map((x) => x).toList(),
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
        "subcategory": subcategory.map((x) => x).toList(),
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

class ProductModelCollection {
    ProductModelCollection({
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

    factory ProductModelCollection.fromJson(Map<String, dynamic> json){ 
        return ProductModelCollection(
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

    final List<SelfElement> self;
    final List<SelfElement> collection;

    factory Links.fromJson(Map<String, dynamic> json){ 
        return Links(
            self: json["self"] == null ? [] : List<SelfElement>.from(json["self"]!.map((x) => SelfElement.fromJson(x))),
            collection: json["collection"] == null ? [] : List<SelfElement>.from(json["collection"]!.map((x) => SelfElement.fromJson(x))),
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

    factory SelfElement.fromJson(Map<String, dynamic> json){ 
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

class PurpleValue {
    PurpleValue({
        required this.id,
        required this.color,
        required this.diamondWeight,
        required this.diamondQuality,
        required this.diamondShape,
        required this.diamondPieces,
        required this.diamondSieve,
    });

    final int? id;
    final String? color;
    final String? diamondWeight;
    final String? diamondQuality;
    final String? diamondShape;
    final int? diamondPieces;
    final String? diamondSieve;

    factory PurpleValue.fromJson(Map<String, dynamic> json){ 
        return PurpleValue(
            id: json["id"],
            color: json["color"],
            diamondWeight: json["diamond_weight"],
            diamondQuality: json["diamond_quality"],
            diamondShape: json["diamond_shape"],
            diamondPieces: json["diamond_pieces"],
            diamondSieve: json["diamond_sieve"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
        "diamond_weight": diamondWeight,
        "diamond_quality": diamondQuality,
        "diamond_shape": diamondShape,
        "diamond_pieces": diamondPieces,
        "diamond_sieve": diamondSieve,
    };

}

class FluffyValue {
    FluffyValue({
        required this.seoDescription,
        required this.seoTitle,
        required this.seoKeywords,
        required this.min,
        required this.max,
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
        required this.diamond,
        required this.making,
        required this.diamondBreakup,
        required this.diamondRates,
        required this.the1,
        required this.gemstone,
        required this.gemstoneBreakup,
        required this.gemstoneRates,
    });

    final String? seoDescription;
    final String? seoTitle;
    final dynamic seoKeywords;
    final String? min;
    final String? max;
    final Metal? metal;
    final Breakup? breakup;
    final Master? master;
    final MetalBreakup? metalBreakup;
    final MetalRates? metalRates;
    final List<dynamic> labourBreakup;
    final Discount? discount;
    final int? totalDiscount;
    final int? totalPrice;
    final int? tax;
    final bool? hasManualPrice;
    final int? priceWithoutTax;
    final int? price;
    final int? totalTax;
    final int? priceWithoutTaxWithDiscount;
    final Map<String, Diamond> diamond;
    final Making? making;
    final Map<String, int> diamondBreakup;
    final Map<String, int> diamondRates;
    final Value1? the1;
    final Gemstone? gemstone;
    final GemstoneBreakupClass? gemstoneBreakup;
    final GemstoneBreakupClass? gemstoneRates;

    factory FluffyValue.fromJson(Map<String, dynamic> json){ 
        return FluffyValue(
            seoDescription: json["seo_description"],
            seoTitle: json["seo_title"],
            seoKeywords: json["seo_keywords"],
            min: json["min"],
            max: json["max"],
            metal: json["metal"] == null ? null : Metal.fromJson(json["metal"]),
            breakup: json["breakup"] == null ? null : Breakup.fromJson(json["breakup"]),
            master: json["master"] == null ? null : Master.fromJson(json["master"]),
            metalBreakup: json["metalBreakup"] == null ? null : MetalBreakup.fromJson(json["metalBreakup"]),
            metalRates: json["metalRates"] == null ? null : MetalRates.fromJson(json["metalRates"]),
            labourBreakup: json["labourBreakup"] == null ? [] : List<dynamic>.from(json["labourBreakup"]!.map((x) => x)),
            discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
            totalDiscount: json["totalDiscount"],
            totalPrice: json["totalPrice"],
            tax: json["tax"],
            hasManualPrice: json["has_manual_price"],
            priceWithoutTax: json["priceWithoutTax"],
            price: json["price"],
            totalTax: json["totalTax"],
            priceWithoutTaxWithDiscount: json["priceWithoutTaxWithDiscount"],
            diamond: Map.from(json["diamond"]).map((k, v) => MapEntry<String, Diamond>(k, Diamond.fromJson(v))),
            making: json["making"] == null ? null : Making.fromJson(json["making"]),
            diamondBreakup: Map.from(json["diamondBreakup"]).map((k, v) => MapEntry<String, int>(k, v)),
            diamondRates: Map.from(json["diamondRates"]).map((k, v) => MapEntry<String, int>(k, v)),
            the1: json["1"] == null ? null : Value1.fromJson(json["1"]),
            gemstone: json["gemstone"] == null ? null : Gemstone.fromJson(json["gemstone"]),
            gemstoneBreakup: json["gemstoneBreakup"] == null ? null : GemstoneBreakupClass.fromJson(json["gemstoneBreakup"]),
            gemstoneRates: json["gemstoneRates"] == null ? null : GemstoneBreakupClass.fromJson(json["gemstoneRates"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "seo_description": seoDescription,
        "seo_title": seoTitle,
        "seo_keywords": seoKeywords,
        "min": min,
        "max": max,
        "metal": metal?.toJson(),
        "breakup": breakup?.toJson(),
        "master": master?.toJson(),
        "metalBreakup": metalBreakup?.toJson(),
        "metalRates": metalRates?.toJson(),
        "labourBreakup": labourBreakup.map((x) => x).toList(),
        "discount": discount?.toJson(),
        "totalDiscount": totalDiscount,
        "totalPrice": totalPrice,
        "tax": tax,
        "has_manual_price": hasManualPrice,
        "priceWithoutTax": priceWithoutTax,
        "price": price,
        "totalTax": totalTax,
        "priceWithoutTaxWithDiscount": priceWithoutTaxWithDiscount,
        "diamond": Map.from(diamond).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "making": making?.toJson(),
        "diamondBreakup": Map.from(diamondBreakup).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "diamondRates": Map.from(diamondRates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "1": the1?.toJson(),
        "gemstone": gemstone?.toJson(),
        "gemstoneBreakup": gemstoneBreakup?.toJson(),
        "gemstoneRates": gemstoneRates?.toJson(),
    };

}

class Breakup {
    Breakup({
        required this.total,
        required this.metal,
        required this.tax,
    });

    final int? total;
    final int? metal;
    final int? tax;

    factory Breakup.fromJson(Map<String, dynamic> json){ 
        return Breakup(
            total: json["total"],
            metal: json["metal"],
            tax: json["tax"],
        );
    }

    Map<String, dynamic> toJson() => {
        "total": total,
        "metal": metal,
        "tax": tax,
    };

}

class Diamond {
    Diamond({
        required this.clarity,
        required this.color,
        required this.size,
        required this.weight,
    });

    final String? clarity;
    final String? color;
    final String? size;
    final String? weight;

    factory Diamond.fromJson(Map<String, dynamic> json){ 
        return Diamond(
            clarity: json["clarity"],
            color: json["color"],
            size: json["size"],
            weight: json["weight"],
        );
    }

    Map<String, dynamic> toJson() => {
        "clarity": clarity,
        "color": color,
        "size": size,
        "weight": weight,
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

class Gemstone {
    Gemstone({
        required this.the1,
    });

    final Gemstone1? the1;

    factory Gemstone.fromJson(Map<String, dynamic> json){ 
        return Gemstone(
            the1: json["1"] == null ? null : Gemstone1.fromJson(json["1"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "1": the1?.toJson(),
    };

}

class Gemstone1 {
    Gemstone1({
        required this.weight,
    });

    final String? weight;

    factory Gemstone1.fromJson(Map<String, dynamic> json){ 
        return Gemstone1(
            weight: json["weight"],
        );
    }

    Map<String, dynamic> toJson() => {
        "weight": weight,
    };

}

class GemstoneBreakupClass {
    GemstoneBreakupClass({
        required this.the1,
    });

    final int? the1;

    factory GemstoneBreakupClass.fromJson(Map<String, dynamic> json){ 
        return GemstoneBreakupClass(
            the1: json["1"],
        );
    }

    Map<String, dynamic> toJson() => {
        "1": the1,
    };

}

class Making {
    Making({
        required this.pergramAmt,
    });

    final String? pergramAmt;

    factory Making.fromJson(Map<String, dynamic> json){ 
        return Making(
            pergramAmt: json["pergram_amt"],
        );
    }

    Map<String, dynamic> toJson() => {
        "pergram_amt": pergramAmt,
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

    final GoldClass? gold;

    factory Metal.fromJson(Map<String, dynamic> json){ 
        return Metal(
            gold: json["gold"] == null ? null : GoldClass.fromJson(json["gold"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "gold": gold?.toJson(),
    };

}

class GoldClass {
    GoldClass({
        required this.goldPurity,
        required this.rate,
        required this.goldGross,
        required this.goldNet,
        required this.amount,
    });

    final String? goldPurity;
    final dynamic rate;
    final String? goldGross;
    final String? goldNet;
    final int? amount;

    factory GoldClass.fromJson(Map<String, dynamic> json){ 
        return GoldClass(
            goldPurity: json["gold_purity"],
            rate: json["rate"],
            goldGross: json["gold_gross"],
            goldNet: json["gold_net"],
            amount: json["amount"],
        );
    }

    Map<String, dynamic> toJson() => {
        "gold_purity": goldPurity,
        "rate": rate,
        "gold_gross": goldGross,
        "gold_net": goldNet,
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

    final Map<String, dynamic> gold;
    final List<dynamic> silver;
    final List<dynamic> platinum;

    factory MetalRates.fromJson(Map<String, dynamic> json){ 
        return MetalRates(
            gold: Map.from(json["gold"]).map((k, v) => MapEntry<String, dynamic>(k, v)),
            silver: json["silver"] == null ? [] : List<dynamic>.from(json["silver"]!.map((x) => x)),
            platinum: json["platinum"] == null ? [] : List<dynamic>.from(json["platinum"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "gold": Map.from(gold).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "silver": silver.map((x) => x).toList(),
        "platinum": platinum.map((x) => x).toList(),
    };

}

class Value1 {
    Value1({
        required this.colorstoneWeight,
        required this.colorstonePieces,
    });

    final String? colorstoneWeight;
    final String? colorstonePieces;

    factory Value1.fromJson(Map<String, dynamic> json){ 
        return Value1(
            colorstoneWeight: json["colorstone_weight"],
            colorstonePieces: json["colorstone_pieces"],
        );
    }

    Map<String, dynamic> toJson() => {
        "colorstone_weight": colorstoneWeight,
        "colorstone_pieces": colorstonePieces,
    };

}
