class DigiGoldOrdersModel {
    DigiGoldOrdersModel({
        required this.id,
        required this.parentId,
        required this.status,
        required this.currency,
        required this.version,
        required this.pricesIncludeTax,
        required this.dateCreated,
        required this.dateModified,
        required this.discountTotal,
        required this.discountTax,
        required this.shippingTotal,
        required this.shippingTax,
        required this.cartTax,
        required this.total,
        required this.totalTax,
        required this.customerId,
        required this.orderKey,
        required this.billing,
        required this.shipping,
        required this.paymentMethod,
        required this.paymentMethodTitle,
        required this.transactionId,
        required this.customerIpAddress,
        required this.customerUserAgent,
        required this.createdVia,
        required this.customerNote,
        required this.dateCompleted,
        required this.datePaid,
        required this.cartHash,
        required this.number,
        required this.metaData,
        required this.lineItems,
        required this.taxLines,
        required this.shippingLines,
        required this.feeLines,
        required this.couponLines,
        required this.refunds,
        required this.paymentUrl,
        required this.isEditable,
        required this.needsPayment,
        required this.needsProcessing,
        required this.dateCreatedGmt,
        required this.dateModifiedGmt,
        required this.dateCompletedGmt,
        required this.datePaidGmt,
        required this.currencySymbol,
        required this.links,
    });

    final int? id;
    final int? parentId;
    final String? status;
    final String? currency;
    final String? version;
    final bool? pricesIncludeTax;
    final DateTime? dateCreated;
    final DateTime? dateModified;
    final String? discountTotal;
    final String? discountTax;
    final String? shippingTotal;
    final String? shippingTax;
    final String? cartTax;
    final String? total;
    final String? totalTax;
    final int? customerId;
    final String? orderKey;
    final Ing? billing;
    final Ing? shipping;
    final String? paymentMethod;
    final String? paymentMethodTitle;
    final String? transactionId;
    final String? customerIpAddress;
    final String? customerUserAgent;
    final String? createdVia;
    final String? customerNote;
    final DateTime? dateCompleted;
    final DateTime? datePaid;
    final String? cartHash;
    final String? number;
    final List<MetaDatum> metaData;
    final List<LineItem> lineItems;
    final List<dynamic> taxLines;
    final List<dynamic> shippingLines;
    final List<dynamic> feeLines;
    final List<dynamic> couponLines;
    final List<dynamic> refunds;
    final String? paymentUrl;
    final bool? isEditable;
    final bool? needsPayment;
    final bool? needsProcessing;
    final DateTime? dateCreatedGmt;
    final DateTime? dateModifiedGmt;
    final DateTime? dateCompletedGmt;
    final DateTime? datePaidGmt;
    final String? currencySymbol;
    final Links? links;

    factory DigiGoldOrdersModel.fromJson(Map<String, dynamic> json){ 
        return DigiGoldOrdersModel(
            id: json["id"],
            parentId: json["parent_id"],
            status: json["status"],
            currency: json["currency"],
            version: json["version"],
            pricesIncludeTax: json["prices_include_tax"],
            dateCreated: DateTime.tryParse(json["date_created"] ?? ""),
            dateModified: DateTime.tryParse(json["date_modified"] ?? ""),
            discountTotal: json["discount_total"],
            discountTax: json["discount_tax"],
            shippingTotal: json["shipping_total"],
            shippingTax: json["shipping_tax"],
            cartTax: json["cart_tax"],
            total: json["total"],
            totalTax: json["total_tax"],
            customerId: json["customer_id"],
            orderKey: json["order_key"],
            billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
            shipping: json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
            paymentMethod: json["payment_method"],
            paymentMethodTitle: json["payment_method_title"],
            transactionId: json["transaction_id"],
            customerIpAddress: json["customer_ip_address"],
            customerUserAgent: json["customer_user_agent"],
            createdVia: json["created_via"],
            customerNote: json["customer_note"],
            dateCompleted: DateTime.tryParse(json["date_completed"] ?? ""),
            datePaid: DateTime.tryParse(json["date_paid"] ?? ""),
            cartHash: json["cart_hash"],
            number: json["number"],
            metaData: json["meta_data"] == null ? [] : List<MetaDatum>.from(json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
            lineItems: json["line_items"] == null ? [] : List<LineItem>.from(json["line_items"]!.map((x) => LineItem.fromJson(x))),
            taxLines: json["tax_lines"] == null ? [] : List<dynamic>.from(json["tax_lines"]!.map((x) => x)),
            shippingLines: json["shipping_lines"] == null ? [] : List<dynamic>.from(json["shipping_lines"]!.map((x) => x)),
            feeLines: json["fee_lines"] == null ? [] : List<dynamic>.from(json["fee_lines"]!.map((x) => x)),
            couponLines: json["coupon_lines"] == null ? [] : List<dynamic>.from(json["coupon_lines"]!.map((x) => x)),
            refunds: json["refunds"] == null ? [] : List<dynamic>.from(json["refunds"]!.map((x) => x)),
            paymentUrl: json["payment_url"],
            isEditable: json["is_editable"],
            needsPayment: json["needs_payment"],
            needsProcessing: json["needs_processing"],
            dateCreatedGmt: DateTime.tryParse(json["date_created_gmt"] ?? ""),
            dateModifiedGmt: DateTime.tryParse(json["date_modified_gmt"] ?? ""),
            dateCompletedGmt: DateTime.tryParse(json["date_completed_gmt"] ?? ""),
            datePaidGmt: DateTime.tryParse(json["date_paid_gmt"] ?? ""),
            currencySymbol: json["currency_symbol"],
            links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "status": status,
        "currency": currency,
        "version": version,
        "prices_include_tax": pricesIncludeTax,
        "date_created": dateCreated?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "discount_total": discountTotal,
        "discount_tax": discountTax,
        "shipping_total": shippingTotal,
        "shipping_tax": shippingTax,
        "cart_tax": cartTax,
        "total": total,
        "total_tax": totalTax,
        "customer_id": customerId,
        "order_key": orderKey,
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "transaction_id": transactionId,
        "customer_ip_address": customerIpAddress,
        "customer_user_agent": customerUserAgent,
        "created_via": createdVia,
        "customer_note": customerNote,
        "date_completed": dateCompleted?.toIso8601String(),
        "date_paid": datePaid?.toIso8601String(),
        "cart_hash": cartHash,
        "number": number,
        "meta_data": metaData.map((x) => x?.toJson()).toList(),
        "line_items": lineItems.map((x) => x?.toJson()).toList(),
        "tax_lines": taxLines.map((x) => x).toList(),
        "shipping_lines": shippingLines.map((x) => x).toList(),
        "fee_lines": feeLines.map((x) => x).toList(),
        "coupon_lines": couponLines.map((x) => x).toList(),
        "refunds": refunds.map((x) => x).toList(),
        "payment_url": paymentUrl,
        "is_editable": isEditable,
        "needs_payment": needsPayment,
        "needs_processing": needsProcessing,
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "date_completed_gmt": dateCompletedGmt?.toIso8601String(),
        "date_paid_gmt": datePaidGmt?.toIso8601String(),
        "currency_symbol": currencySymbol,
        "_links": links?.toJson(),
    };

}

class Ing {
    Ing({
        required this.firstName,
        required this.lastName,
        required this.company,
        required this.address1,
        required this.address2,
        required this.city,
        required this.state,
        required this.postcode,
        required this.country,
        required this.email,
        required this.phone,
    });

    final String? firstName;
    final String? lastName;
    final String? company;
    final String? address1;
    final String? address2;
    final String? city;
    final String? state;
    final String? postcode;
    final String? country;
    final String? email;
    final String? phone;

    factory Ing.fromJson(Map<String, dynamic> json){ 
        return Ing(
            firstName: json["first_name"],
            lastName: json["last_name"],
            company: json["company"],
            address1: json["address_1"],
            address2: json["address_2"],
            city: json["city"],
            state: json["state"],
            postcode: json["postcode"],
            country: json["country"],
            email: json["email"],
            phone: json["phone"],
        );
    }

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email,
        "phone": phone,
    };

}

class LineItem {
    LineItem({
        required this.id,
        required this.name,
        required this.productId,
        required this.variationId,
        required this.quantity,
        required this.taxClass,
        required this.subtotal,
        required this.subtotalTax,
        required this.total,
        required this.totalTax,
        required this.taxes,
        required this.metaData,
        required this.sku,
        required this.price,
        required this.image,
        required this.parentName,
    });

    final int? id;
    final String? name;
    final int? productId;
    final int? variationId;
    final int? quantity;
    final String? taxClass;
    final String? subtotal;
    final String? subtotalTax;
    final String? total;
    final String? totalTax;
    final List<dynamic> taxes;
    final List<dynamic> metaData;
    final String? sku;
    final int? price;
    final Image? image;
    final dynamic parentName;

    factory LineItem.fromJson(Map<String, dynamic> json){ 
        return LineItem(
            id: json["id"],
            name: json["name"],
            productId: json["product_id"],
            variationId: json["variation_id"],
            quantity: json["quantity"],
            taxClass: json["tax_class"],
            subtotal: json["subtotal"],
            subtotalTax: json["subtotal_tax"],
            total: json["total"],
            totalTax: json["total_tax"],
            taxes: json["taxes"] == null ? [] : List<dynamic>.from(json["taxes"]!.map((x) => x)),
            metaData: json["meta_data"] == null ? [] : List<dynamic>.from(json["meta_data"]!.map((x) => x)),
            sku: json["sku"],
            price: json["price"],
            image: json["image"] == null ? null : Image.fromJson(json["image"]),
            parentName: json["parent_name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
        "tax_class": taxClass,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total": total,
        "total_tax": totalTax,
        "taxes": taxes.map((x) => x).toList(),
        "meta_data": metaData.map((x) => x).toList(),
        "sku": sku,
        "price": price,
        "image": image?.toJson(),
        "parent_name": parentName,
    };

}

class Image {
    Image({
        required this.id,
        required this.src,
    });

    final String? id;
    final String? src;

    factory Image.fromJson(Map<String, dynamic> json){ 
        return Image(
            id: json["id"],
            src: json["src"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
    };

}

class Links {
    Links({
        required this.self,
        required this.collection,
        required this.customer,
    });

    final List<Collection> self;
    final List<Collection> collection;
    final List<Collection> customer;

    factory Links.fromJson(Map<String, dynamic> json){ 
        return Links(
            self: json["self"] == null ? [] : List<Collection>.from(json["self"]!.map((x) => Collection.fromJson(x))),
            collection: json["collection"] == null ? [] : List<Collection>.from(json["collection"]!.map((x) => Collection.fromJson(x))),
            customer: json["customer"] == null ? [] : List<Collection>.from(json["customer"]!.map((x) => Collection.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "self": self.map((x) => x?.toJson()).toList(),
        "collection": collection.map((x) => x?.toJson()).toList(),
        "customer": customer.map((x) => x?.toJson()).toList(),
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
    final String? value;

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
