class ReviewsModel {
    ReviewsModel({
        required this.id,
        required this.dateCreated,
        required this.dateCreatedGmt,
        required this.productId,
        required this.productName,
        required this.productPermalink,
        required this.status,
        required this.reviewer,
        required this.reviewerEmail,
        required this.review,
        required this.rating,
        required this.verified,
        required this.reviewerAvatarUrls,
    
    });

    final int? id;
    final DateTime? dateCreated;
    final DateTime? dateCreatedGmt;
    final int? productId;
    final String? productName;
    final String? productPermalink;
    final String? status;
    final String? reviewer;
    final String? reviewerEmail;
    final String? review;
    final int? rating;
    final bool? verified;
    final Map<String, String> reviewerAvatarUrls;
 

    factory ReviewsModel.fromJson(Map<String, dynamic> json){ 
        return ReviewsModel(
            id: json["id"],
            dateCreated: DateTime.tryParse(json["date_created"] ?? ""),
            dateCreatedGmt: DateTime.tryParse(json["date_created_gmt"] ?? ""),
            productId: json["product_id"],
            productName: json["product_name"],
            productPermalink: json["product_permalink"],
            status: json["status"],
            reviewer: json["reviewer"],
            reviewerEmail: json["reviewer_email"],
            review: json["review"],
            rating: json["rating"],
            verified: json["verified"],
            reviewerAvatarUrls: Map.from(json["reviewer_avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
           
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "product_id": productId,
        "product_name": productName,
        "product_permalink": productPermalink,
        "status": status,
        "reviewer": reviewer,
        "reviewer_email": reviewerEmail,
        "review": review,
        "rating": rating,
        "verified": verified,
        "reviewer_avatar_urls": Map.from(reviewerAvatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),

    };

}

class Links {
    Links({
        required this.self,
        required this.collection,
        required this.up,
    });

    final List<Collection> self;
    final List<Collection> collection;
    final List<Collection> up;

    factory Links.fromJson(Map<String, dynamic> json){ 
        return Links(
            self: json["self"] == null ? [] : List<Collection>.from(json["self"]!.map((x) => Collection.fromJson(x))),
            collection: json["collection"] == null ? [] : List<Collection>.from(json["collection"]!.map((x) => Collection.fromJson(x))),
            up: json["up"] == null ? [] : List<Collection>.from(json["up"]!.map((x) => Collection.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "self": self.map((x) => x?.toJson()).toList(),
        "collection": collection.map((x) => x?.toJson()).toList(),
        "up": up.map((x) => x?.toJson()).toList(),
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
