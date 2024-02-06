class ProductCustomizationOptionsModel {
    ProductCustomizationOptionsModel({
        required this.type,
        required this.data,
    });

    final String? type;
    final Data? data;

    factory ProductCustomizationOptionsModel.fromJson(Map<String, dynamic> json){ 
        return ProductCustomizationOptionsModel(
            type: json["type"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "type": type,
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.display,
        required this.kt,
        required this.color,
        required this.diamond,
        required this.purities,
        required this.collections,
        required this.colors,
        required this.diamondPurities,
    });

    final String? display;
    final String? kt;
    final String? color;
    final String? diamond;
    final List<String> purities;
    final List<dynamic> collections;
    final List<String> colors;
    final List<String> diamondPurities;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            display: json["display"],
            kt: json["kt"],
            color: json["color"],
            diamond: json["diamond"],
            purities: json["purities"] == null ? [] : List<String>.from(json["purities"]!.map((x) => x)),
            collections: json["collections"] == null ? [] : List<dynamic>.from(json["collections"]!.map((x) => x)),
            colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
            diamondPurities: json["diamond_purities"] == null ? [] : List<String>.from(json["diamond_purities"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "display": display,
        "kt": kt,
        "color": color,
        "diamond": diamond,
        "purities": purities.map((x) => x).toList(),
        "collections": collections.map((x) => x).toList(),
        "colors": colors.map((x) => x).toList(),
        "diamond_purities": diamondPurities.map((x) => x).toList(),
    };

}
