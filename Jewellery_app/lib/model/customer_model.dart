class CustomerModel {
    CustomerModel({
        required this.id,
        required this.dateCreated,
        required this.dateCreatedGmt,
        required this.dateModified,
        required this.dateModifiedGmt,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.role,
        required this.username,
        required this.billing,
        required this.shipping,
        required this.isPayingCustomer,
        required this.avatarUrl,
        required this.metaData,
        required this.nickname,
        required this.pushNotify,
        required this.notes,
        required this.sessions,
        required this.links,
        required this.cart,
    });

    final int? id;
    final DateTime? dateCreated;
    final DateTime? dateCreatedGmt;
    final DateTime? dateModified;
    final DateTime? dateModifiedGmt;
    final String? email;
    final String? firstName;
    final String? lastName;
    final String? role;
    final String? username;
    final Ing? billing;
    final Ing? shipping;
    final bool? isPayingCustomer;
    final String? avatarUrl;
    final List<MetaDatum> metaData;
    final String? nickname;
    final String? pushNotify;
    final bool? notes;
    final String? sessions;
    final Links? links;
    final List<dynamic> cart;

    factory CustomerModel.fromJson(Map<String, dynamic> json){ 
        return CustomerModel(
            id: json["id"],
            dateCreated: DateTime.tryParse(json["date_created"] ?? ""),
            dateCreatedGmt: DateTime.tryParse(json["date_created_gmt"] ?? ""),
            dateModified: DateTime.tryParse(json["date_modified"] ?? ""),
            dateModifiedGmt: DateTime.tryParse(json["date_modified_gmt"] ?? ""),
            email: json["email"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            role: json["role"],
            username: json["username"],
            billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
            shipping: json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
            isPayingCustomer: json["is_paying_customer"],
            avatarUrl: json["avatar_url"],
            metaData: json["meta_data"] == null ? [] : List<MetaDatum>.from(json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
            nickname: json["nickname"],
            pushNotify: json["push_notify"],
            notes: json["notes"],
            sessions: json["sessions"],
            links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
            cart: json["cart"] == null ? [] : List<dynamic>.from(json["cart"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "role": role,
        "username": username,
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
        "is_paying_customer": isPayingCustomer,
        "avatar_url": avatarUrl,
        "meta_data": metaData.map((x) => x.toJson()).toList(),
        "nickname": nickname,
        "push_notify": pushNotify,
        "notes": notes,
        "sessions": sessions,
        "_links": links?.toJson(),
        "cart": cart.map((x) => x).toList(),
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
        required this.postcode,
        required this.country,
        required this.state,
        required this.email,
        required this.phone,
    });

    final String? firstName;
    final String? lastName;
    final String? company;
    final String? address1;
    final String? address2;
    final String? city;
    final String? postcode;
    final String? country;
    final String? state;
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
            postcode: json["postcode"],
            country: json["country"],
            state: json["state"],
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
        "postcode": postcode,
        "country": country,
        "state": state,
        "email": email,
        "phone": phone,
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
        "self": self.map((x) => x.toJson()).toList(),
        "collection": collection.map((x) => x.toJson()).toList(),
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
