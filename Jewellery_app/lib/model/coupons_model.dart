class CouponsModel {
    CouponsModel({
        required this.id,
        required this.code,
        required this.amount,
        required this.status,
        required this.dateCreated,
        required this.dateCreatedGmt,
        required this.dateModified,
        required this.dateModifiedGmt,
        required this.discountType,
        required this.description,
        required this.dateExpires,
        required this.dateExpiresGmt,
        required this.usageCount,
        required this.individualUse,
        required this.productIds,
        required this.excludedProductIds,
        required this.usageLimit,
        required this.usageLimitPerUser,
        required this.limitUsageToXItems,
        required this.freeShipping,
        required this.productCategories,
        required this.excludedProductCategories,
        required this.excludeSaleItems,
        required this.minimumAmount,
        required this.maximumAmount,
        required this.emailRestrictions,
        required this.usedBy,
        required this.metaData,
        required this.links,
    });

    final int? id;
    final String? code;
    final String? amount;
    final String? status;
    final DateTime? dateCreated;
    final DateTime? dateCreatedGmt;
    final DateTime? dateModified;
    final DateTime? dateModifiedGmt;
    final String? discountType;
    final String? description;
    final DateTime? dateExpires;
    final DateTime? dateExpiresGmt;
    final int? usageCount;
    final bool? individualUse;
    final List<dynamic> productIds;
    final List<dynamic> excludedProductIds;
    final int? usageLimit;
    final int? usageLimitPerUser;
    final dynamic limitUsageToXItems;
    final bool? freeShipping;
    final List<int> productCategories;
    final List<dynamic> excludedProductCategories;
    final bool? excludeSaleItems;
    final String? minimumAmount;
    final String? maximumAmount;
    final List<dynamic> emailRestrictions;
    final List<String> usedBy;
    final List<MetaDatum> metaData;
    final Links? links;

    factory CouponsModel.fromJson(Map<String, dynamic> json){ 
        return CouponsModel(
            id: json["id"],
            code: json["code"],
            amount: json["amount"],
            status: json["status"],
            dateCreated: DateTime.tryParse(json["date_created"] ?? ""),
            dateCreatedGmt: DateTime.tryParse(json["date_created_gmt"] ?? ""),
            dateModified: DateTime.tryParse(json["date_modified"] ?? ""),
            dateModifiedGmt: DateTime.tryParse(json["date_modified_gmt"] ?? ""),
            discountType: json["discount_type"],
            description: json["description"],
            dateExpires: DateTime.tryParse(json["date_expires"] ?? ""),
            dateExpiresGmt: DateTime.tryParse(json["date_expires_gmt"] ?? ""),
            usageCount: json["usage_count"],
            individualUse: json["individual_use"],
            productIds: json["product_ids"] == null ? [] : List<dynamic>.from(json["product_ids"]!.map((x) => x)),
            excludedProductIds: json["excluded_product_ids"] == null ? [] : List<dynamic>.from(json["excluded_product_ids"]!.map((x) => x)),
            usageLimit: json["usage_limit"],
            usageLimitPerUser: json["usage_limit_per_user"],
            limitUsageToXItems: json["limit_usage_to_x_items"],
            freeShipping: json["free_shipping"],
            productCategories: json["product_categories"] == null ? [] : List<int>.from(json["product_categories"]!.map((x) => x)),
            excludedProductCategories: json["excluded_product_categories"] == null ? [] : List<dynamic>.from(json["excluded_product_categories"]!.map((x) => x)),
            excludeSaleItems: json["exclude_sale_items"],
            minimumAmount: json["minimum_amount"],
            maximumAmount: json["maximum_amount"],
            emailRestrictions: json["email_restrictions"] == null ? [] : List<dynamic>.from(json["email_restrictions"]!.map((x) => x)),
            usedBy: json["used_by"] == null ? [] : List<String>.from(json["used_by"]!.map((x) => x)),
            metaData: json["meta_data"] == null ? [] : List<MetaDatum>.from(json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
            links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "amount": amount,
        "status": status,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "discount_type": discountType,
        "description": description,
        "date_expires": dateExpires?.toIso8601String(),
        "date_expires_gmt": dateExpiresGmt?.toIso8601String(),
        "usage_count": usageCount,
        "individual_use": individualUse,
        "product_ids": productIds.map((x) => x).toList(),
        "excluded_product_ids": excludedProductIds.map((x) => x).toList(),
        "usage_limit": usageLimit,
        "usage_limit_per_user": usageLimitPerUser,
        "limit_usage_to_x_items": limitUsageToXItems,
        "free_shipping": freeShipping,
        "product_categories": productCategories.map((x) => x).toList(),
        "excluded_product_categories": excludedProductCategories.map((x) => x).toList(),
        "exclude_sale_items": excludeSaleItems,
        "minimum_amount": minimumAmount,
        "maximum_amount": maximumAmount,
        "email_restrictions": emailRestrictions.map((x) => x).toList(),
        "used_by": usedBy.map((x) => x).toList(),
        "meta_data": metaData.map((x) => x?.toJson()).toList(),
        "_links": links?.toJson(),
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
    final List<int> value;

    factory MetaDatum.fromJson(Map<String, dynamic> json){ 
        return MetaDatum(
            id: json["id"],
            key: json["key"],
            value: json["value"] == null ? [] : List<int>.from(json["value"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value.map((x) => x).toList(),
    };

}
