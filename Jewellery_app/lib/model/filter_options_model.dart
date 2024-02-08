class FilterOptionsModel {
    FilterOptionsModel({
        required this.collections,
        required this.categories,
        required this.subCategories,
        required this.tags,
        required this.diamondWt,
        required this.goldWt,
        required this.gender,
    });

    final List<Category> collections;
    final List<Category> categories;
    final List<Category> subCategories;
    final List<Category> tags;
    final List<Category> diamondWt;
    final List<Category> goldWt;
    final List<Category> gender;

    factory FilterOptionsModel.fromJson(Map<String, dynamic> json){ 
        return FilterOptionsModel(
            collections: json["collections"] == null ? [] : List<Category>.from(json["collections"]!.map((x) => Category.fromJson(x))),
            categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
            subCategories: json["sub-categories"] == null ? [] : List<Category>.from(json["sub-categories"]!.map((x) => Category.fromJson(x))),
            tags: json["tags"] == null ? [] : List<Category>.from(json["tags"]!.map((x) => Category.fromJson(x))),
            diamondWt: json["diamond_wt"] == null ? [] : List<Category>.from(json["diamond_wt"]!.map((x) => Category.fromJson(x))),
            goldWt: json["gold_wt"] == null ? [] : List<Category>.from(json["gold_wt"]!.map((x) => Category.fromJson(x))),
            gender: json["gender"] == null ? [] : List<Category>.from(json["gender"]!.map((x) => Category.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "collections": collections.map((x) => x?.toJson()).toList(),
        "categories": categories.map((x) => x?.toJson()).toList(),
        "sub-categories": subCategories.map((x) => x?.toJson()).toList(),
        "tags": tags.map((x) => x?.toJson()).toList(),
        "diamond_wt": diamondWt.map((x) => x?.toJson()).toList(),
        "gold_wt": goldWt.map((x) => x?.toJson()).toList(),
        "gender": gender.map((x) => x?.toJson()).toList(),
    };

}

class Category {
    Category({
        required this.id,
        required this.label,
        required this.value,
        required this.count,
    });

    final int? id;
    final String? label;
    final String? value;
    final int? count;

    factory Category.fromJson(Map<String, dynamic> json){ 
        return Category(
            id: json["id"],
            label: json["label"],
            value: json["value"],
            count: json["count"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "value": value,
        "count": count,
    };

}
