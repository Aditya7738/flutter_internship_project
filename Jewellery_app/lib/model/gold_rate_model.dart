class GoldRateModel {
    GoldRateModel({
        required this.type,
        required this.data,
    });

    final String? type;
    final Data? data;

    factory GoldRateModel.fromJson(Map<String, dynamic> json){ 
        return GoldRateModel(
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
        required this.goldPricing,
        required this.silverPricing,
        required this.platinumPricing,
        required this.labourPricing,
        required this.diamondPricing,
        required this.gemstonePricing,
        required this.additionalPricing,
        required this.lastUpdated,
        required this.marginPricing,
    });

    final GoldPricing? goldPricing;
    final SilverPricing? silverPricing;
    final PlatinumPricing? platinumPricing;
    final LabourPricing? labourPricing;
    final Map<String, List<Pricing>> diamondPricing;
    final Map<String, List<GemstonePricing>> gemstonePricing;
    final AdditionalPricing? additionalPricing;
    final int? lastUpdated;
    final Map<String, List<Pricing>> marginPricing;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            goldPricing: json["gold_pricing"] == null ? null : GoldPricing.fromJson(json["gold_pricing"]),
            silverPricing: json["silver_pricing"] == null ? null : SilverPricing.fromJson(json["silver_pricing"]),
            platinumPricing: json["platinum_pricing"] == null ? null : PlatinumPricing.fromJson(json["platinum_pricing"]),
            labourPricing: json["labour_pricing"] == null ? null : LabourPricing.fromJson(json["labour_pricing"]),
            diamondPricing: Map.from(json["diamond_pricing"]).map((k, v) => MapEntry<String, List<Pricing>>(k, v == null ? [] : List<Pricing>.from(v!.map((x) => Pricing.fromJson(x))))),
            gemstonePricing: Map.from(json["gemstone_pricing"]).map((k, v) => MapEntry<String, List<GemstonePricing>>(k, v == null ? [] : List<GemstonePricing>.from(v!.map((x) => GemstonePricing.fromJson(x))))),
            additionalPricing: json["additional_pricing"] == null ? null : AdditionalPricing.fromJson(json["additional_pricing"]),
            lastUpdated: json["last_updated"],
            marginPricing: Map.from(json["margin_pricing"]).map((k, v) => MapEntry<String, List<Pricing>>(k, v == null ? [] : List<Pricing>.from(v!.map((x) => Pricing.fromJson(x))))),
        );
    }

    Map<String, dynamic> toJson() => {
        "gold_pricing": goldPricing?.toJson(),
        "silver_pricing": silverPricing?.toJson(),
        "platinum_pricing": platinumPricing?.toJson(),
        "labour_pricing": labourPricing?.toJson(),
        "diamond_pricing": Map.from(diamondPricing).map((k, v) => MapEntry<String, dynamic>(k, v.map((x) => x?.toJson()).toList())),
        "gemstone_pricing": Map.from(gemstonePricing).map((k, v) => MapEntry<String, dynamic>(k, v.map((x) => x?.toJson()).toList())),
        "additional_pricing": additionalPricing?.toJson(),
        "last_updated": lastUpdated,
        "margin_pricing": Map.from(marginPricing).map((k, v) => MapEntry<String, dynamic>(k, v.map((x) => x?.toJson()).toList())),
    };

}

class AdditionalPricing {
    AdditionalPricing({
        required this.hallmark,
        required this.certificate,
        required this.rhodium,
    });

    final Certificate? hallmark;
    final Certificate? certificate;
    final Certificate? rhodium;

    factory AdditionalPricing.fromJson(Map<String, dynamic> json){ 
        return AdditionalPricing(
            hallmark: json["hallmark"] == null ? null : Certificate.fromJson(json["hallmark"]),
            certificate: json["certificate"] == null ? null : Certificate.fromJson(json["certificate"]),
            rhodium: json["rhodium"] == null ? null : Certificate.fromJson(json["rhodium"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "hallmark": hallmark?.toJson(),
        "certificate": certificate?.toJson(),
        "rhodium": rhodium?.toJson(),
    };

}

class Certificate {
    Certificate({
        required this.inr,
    });

    final String? inr;

    factory Certificate.fromJson(Map<String, dynamic> json){ 
        return Certificate(
            inr: json["INR"],
        );
    }

    Map<String, dynamic> toJson() => {
        "INR": inr,
    };

}

class Pricing {
    Pricing({
        required this.id,
        required this.clarities,
        required this.colors,
        required this.shapes,
        required this.sieves,
        required this.sieveFrom,
        required this.sieveTo,
        required this.sieveType,
        required this.cuts,
        required this.types,
        required this.rate,
        required this.title,
    });

    final int? id;
    final List<Clarity> clarities;
    final List<Clarity> colors;
    final List<Clarity> shapes;
    final List<Clarity> sieves;
    final String? sieveFrom;
    final String? sieveTo;
    final String? sieveType;
    final List<Clarity> cuts;
    final List<Clarity> types;
    final String? rate;
    final String? title;

    factory Pricing.fromJson(Map<String, dynamic> json){ 
        return Pricing(
            id: json["id"],
            clarities: json["clarities"] == null ? [] : List<Clarity>.from(json["clarities"]!.map((x) => Clarity.fromJson(x))),
            colors: json["colors"] == null ? [] : List<Clarity>.from(json["colors"]!.map((x) => Clarity.fromJson(x))),
            shapes: json["shapes"] == null ? [] : List<Clarity>.from(json["shapes"]!.map((x) => Clarity.fromJson(x))),
            sieves: json["sieves"] == null ? [] : List<Clarity>.from(json["sieves"]!.map((x) => Clarity.fromJson(x))),
            sieveFrom: json["sieve_from"],
            sieveTo: json["sieve_to"],
            sieveType: json["sieve_type"],
            cuts: json["cuts"] == null ? [] : List<Clarity>.from(json["cuts"]!.map((x) => Clarity.fromJson(x))),
            types: json["types"] == null ? [] : List<Clarity>.from(json["types"]!.map((x) => Clarity.fromJson(x))),
            rate: json["rate"],
            title: json["title"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "clarities": clarities.map((x) => x?.toJson()).toList(),
        "colors": colors.map((x) => x?.toJson()).toList(),
        "shapes": shapes.map((x) => x?.toJson()).toList(),
        "sieves": sieves.map((x) => x?.toJson()).toList(),
        "sieve_from": sieveFrom,
        "sieve_to": sieveTo,
        "sieve_type": sieveType,
        "cuts": cuts.map((x) => x?.toJson()).toList(),
        "types": types.map((x) => x?.toJson()).toList(),
        "rate": rate,
        "title": title,
    };

}

class Clarity {
    Clarity({
        required this.label,
        required this.value,
    });

    final String? label;
    final String? value;

    factory Clarity.fromJson(Map<String, dynamic> json){ 
        return Clarity(
            label: json["label"],
            value: json["value"],
        );
    }

    Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
    };

}

class GemstonePricing {
    GemstonePricing({
        required this.id,
        required this.title,
        required this.qualities,
        required this.types,
        required this.shapes,
        required this.sizes,
        required this.rate,
    });

    final int? id;
    final String? title;
    final List<Clarity> qualities;
    final List<Clarity> types;
    final List<Clarity> shapes;
    final List<Clarity> sizes;
    final String? rate;

    factory GemstonePricing.fromJson(Map<String, dynamic> json){ 
        return GemstonePricing(
            id: json["id"],
            title: json["title"],
            qualities: json["qualities"] == null ? [] : List<Clarity>.from(json["qualities"]!.map((x) => Clarity.fromJson(x))),
            types: json["types"] == null ? [] : List<Clarity>.from(json["types"]!.map((x) => Clarity.fromJson(x))),
            shapes: json["shapes"] == null ? [] : List<Clarity>.from(json["shapes"]!.map((x) => Clarity.fromJson(x))),
            sizes: json["sizes"] == null ? [] : List<Clarity>.from(json["sizes"]!.map((x) => Clarity.fromJson(x))),
            rate: json["rate"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "qualities": qualities.map((x) => x?.toJson()).toList(),
        "types": types.map((x) => x?.toJson()).toList(),
        "shapes": shapes.map((x) => x?.toJson()).toList(),
        "sizes": sizes.map((x) => x?.toJson()).toList(),
        "rate": rate,
    };

}

class GoldPricing {
    GoldPricing({
        required this.inr,
        required this.from,
        required this.type,
    });

    final GoldPricingInr? inr;
    final String? from;
    final String? type;

    factory GoldPricing.fromJson(Map<String, dynamic> json){ 
        return GoldPricing(
            inr: json["INR"] == null ? null : GoldPricingInr.fromJson(json["INR"]),
            from: json["from"],
            type: json["type"],
        );
    }

    Map<String, dynamic> toJson() => {
        "INR": inr?.toJson(),
        "from": from,
        "type": type,
    };

}

class GoldPricingInr {
    GoldPricingInr({
        required this.inrDefault,
        required this.automatic,
        required this.manual,
        required this.enabledPurities,
    });

    final String? inrDefault;
    final PurpleAutomatic? automatic;
    final Map<String, Manual> manual;
    final Map<String, bool> enabledPurities;

    factory GoldPricingInr.fromJson(Map<String, dynamic> json){ 
        return GoldPricingInr(
            inrDefault: json["default"],
            automatic: json["automatic"] == null ? null : PurpleAutomatic.fromJson(json["automatic"]),
            manual: Map.from(json["manual"]).map((k, v) => MapEntry<String, Manual>(k, Manual.fromJson(v))),
            enabledPurities: Map.from(json["enabled_purities"]).map((k, v) => MapEntry<String, bool>(k, v)),
        );
    }

    Map<String, dynamic> toJson() => {
        "default": inrDefault,
        "automatic": automatic?.toJson(),
        "manual": Map.from(manual).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "enabled_purities": Map.from(enabledPurities).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };

}

class PurpleAutomatic {
    PurpleAutomatic({
        required this.the375,
        required this.the583,
        required this.the750,
        required this.the916,
        required this.the995,
        required this.the999,
        required this.the99999,
        required this.empty,
    });

    final The375? the375;
    final The583? the583;
    final The375? the750;
    final The916? the916;
    final The375? the995;
    final The375? the999;
    final The583? the99999;
    final Empty? empty;

    factory PurpleAutomatic.fromJson(Map<String, dynamic> json){ 
        return PurpleAutomatic(
            the375: json["375"] == null ? null : The375.fromJson(json["375"]),
            the583: json["583"] == null ? null : The583.fromJson(json["583"]),
            the750: json["750"] == null ? null : The375.fromJson(json["750"]),
            the916: json["916"] == null ? null : The916.fromJson(json["916"]),
            the995: json["995"] == null ? null : The375.fromJson(json["995"]),
            the999: json["999"] == null ? null : The375.fromJson(json["999"]),
            the99999: json["999.99"] == null ? null : The583.fromJson(json["999.99"]),
            empty: json[""] == null ? null : Empty.fromJson(json[""]),
        );
    }

    Map<String, dynamic> toJson() => {
        "375": the375?.toJson(),
        "583": the583?.toJson(),
        "750": the750?.toJson(),
        "916": the916?.toJson(),
        "995": the995?.toJson(),
        "999": the999?.toJson(),
        "999.99": the99999?.toJson(),
        "": empty?.toJson(),
    };

}

class Empty {
    Empty({
        required this.base,
        required this.rate,
        required this.purpleDefault,
    });

    final dynamic base;
    final String? rate;
    final bool? purpleDefault;

    factory Empty.fromJson(Map<String, dynamic> json){ 
        return Empty(
            base: json["base"],
            rate: json["rate"],
            purpleDefault: json["default"],
        );
    }

    Map<String, dynamic> toJson() => {
        "base": base,
        "rate": rate,
        "default": purpleDefault,
    };

}

class The375 {
    The375({
        required this.base,
        required this.margin,
        required this.rate,
    });

    final dynamic base;
    final int? margin;
    final int? rate;

    factory The375.fromJson(Map<String, dynamic> json){ 
        return The375(
            base: int.parse("${json["base"]}") ,
            margin: json["margin"],
            rate: json["rate"],
        );
    }

    Map<String, dynamic> toJson() => {
        "base": base,
        "margin": margin,
        "rate": rate,
    };

}

class The583 {
    The583({
        required this.base,
        required this.margin,
        required this.rate,
    });

    final dynamic base;
    final String? margin;
    final int? rate;

    factory The583.fromJson(Map<String, dynamic> json){ 
        return The583(
            base: json["base"],
            margin: json["margin"],
            rate: json["rate"],
        );
    }

    Map<String, dynamic> toJson() => {
        "base": base,
        "margin": margin,
        "rate": rate,
    };

}

class The916 {
    The916({
        required this.base,
        required this.margin,
        required this.rate,
    });

    final dynamic base;
    final int? margin;
    final int? rate;

    factory The916.fromJson(Map<String, dynamic> json){ 
        return The916(
            base: json["base"],
            margin: json["margin"],
            rate: json["rate"],
        );
    }

    Map<String, dynamic> toJson() => {
        "base": base,
        "margin": margin,
        "rate": rate,
    };

}

class Manual {
    Manual({
        required this.base,
        required this.rate,
    });

    final dynamic base;
    final String? rate;

    factory Manual.fromJson(Map<String, dynamic> json){ 
        return Manual(
            base: json["base"],
            rate: json["rate"],
        );
    }

    Map<String, dynamic> toJson() => {
        "base": base,
        "rate": rate,
    };

}

class LabourPricing {
    LabourPricing({
        required this.inr,
    });

    final List<InrElement> inr;

    factory LabourPricing.fromJson(Map<String, dynamic> json){ 
        return LabourPricing(
            inr: json["INR"] == null ? [] : List<InrElement>.from(json["INR"]!.map((x) => InrElement.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "INR": inr.map((x) => x?.toJson()).toList(),
    };

}

class InrElement {
    InrElement({
        required this.id,
        required this.collections,
        required this.categories,
        required this.subcategories,
        required this.labourFrom,
        required this.wastage,
        required this.wastageFrom,
        required this.perGram,
        required this.makingFrom,
        required this.minimumMaking,
        required this.title,
    });

    final int? id;
    final List<Category> collections;
    final List<Category> categories;
    final List<Category> subcategories;
    final String? labourFrom;
    final String? wastage;
    final String? wastageFrom;
    final String? perGram;
    final String? makingFrom;
    final String? minimumMaking;
    final String? title;

    factory InrElement.fromJson(Map<String, dynamic> json){ 
        return InrElement(
            id: json["id"],
            collections: json["collections"] == null ? [] : List<Category>.from(json["collections"]!.map((x) => Category.fromJson(x))),
            categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
            subcategories: json["subcategories"] == null ? [] : List<Category>.from(json["subcategories"]!.map((x) => Category.fromJson(x))),
            labourFrom: json["labour_from"],
            wastage: json["wastage"],
            wastageFrom: json["wastage_from"],
            perGram: json["per_gram"],
            makingFrom: json["making_from"],
            minimumMaking: json["minimum_making"],
            title: json["title"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "collections": collections.map((x) => x?.toJson()).toList(),
        "categories": categories.map((x) => x?.toJson()).toList(),
        "subcategories": subcategories.map((x) => x?.toJson()).toList(),
        "labour_from": labourFrom,
        "wastage": wastage,
        "wastage_from": wastageFrom,
        "per_gram": perGram,
        "making_from": makingFrom,
        "minimum_making": minimumMaking,
        "title": title,
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

class PlatinumPricing {
    PlatinumPricing({
        required this.inr,
        required this.from,
        required this.type,
    });

    final PlatinumPricingInr? inr;
    final String? from;
    final String? type;

    factory PlatinumPricing.fromJson(Map<String, dynamic> json){ 
        return PlatinumPricing(
            inr: json["INR"] == null ? null : PlatinumPricingInr.fromJson(json["INR"]),
            from: json["from"],
            type: json["type"],
        );
    }

    Map<String, dynamic> toJson() => {
        "INR": inr?.toJson(),
        "from": from,
        "type": type,
    };

}

class PlatinumPricingInr {
    PlatinumPricingInr({
        required this.inrDefault,
        required this.automatic,
        required this.manual,
        required this.enabledPurities,
    });

    final String? inrDefault;
    final Map<String, AutomaticValue> automatic;
    final Map<String, Manual> manual;
    final Map<String, bool> enabledPurities;

    factory PlatinumPricingInr.fromJson(Map<String, dynamic> json){ 
        return PlatinumPricingInr(
            inrDefault: json["default"],
            automatic: Map.from(json["automatic"]).map((k, v) => MapEntry<String, AutomaticValue>(k, AutomaticValue.fromJson(v))),
            manual: Map.from(json["manual"]).map((k, v) => MapEntry<String, Manual>(k, Manual.fromJson(v))),
            enabledPurities: Map.from(json["enabled_purities"]).map((k, v) => MapEntry<String, bool>(k, v)),
        );
    }

    Map<String, dynamic> toJson() => {
        "default": inrDefault,
        "automatic": Map.from(automatic).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "manual": Map.from(manual).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "enabled_purities": Map.from(enabledPurities).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };

}

class AutomaticValue {
    AutomaticValue({
        required this.base,
        required this.margin,
        required this.rate,
    });

    final dynamic base;
    final int? margin;
    final int? rate;

    factory AutomaticValue.fromJson(Map<String, dynamic> json){ 
        return AutomaticValue(
            base: json["base"],
            margin: json["margin"],
            rate: json["rate"],
        );
    }

    Map<String, dynamic> toJson() => {
        "base": base,
        "margin": margin,
        "rate": rate,
    };

}

class SilverPricing {
    SilverPricing({
        required this.inr,
        required this.from,
        required this.type,
    });

    final SilverPricingInr? inr;
    final String? from;
    final String? type;

    factory SilverPricing.fromJson(Map<String, dynamic> json){ 
        return SilverPricing(
            inr: json["INR"] == null ? null : SilverPricingInr.fromJson(json["INR"]),
            from: json["from"],
            type: json["type"],
        );
    }

    Map<String, dynamic> toJson() => {
        "INR": inr?.toJson(),
        "from": from,
        "type": type,
    };

}

class SilverPricingInr {
    SilverPricingInr({
        required this.inrDefault,
        required this.automatic,
        required this.manual,
        required this.enabledPurities,
    });

    final String? inrDefault;
    final FluffyAutomatic? automatic;
    final Map<String, Manual> manual;
    final Map<String, bool> enabledPurities;

    factory SilverPricingInr.fromJson(Map<String, dynamic> json){ 
        return SilverPricingInr(
            inrDefault: json["default"],
            automatic: json["automatic"] == null ? null : FluffyAutomatic.fromJson(json["automatic"]),
            manual: Map.from(json["manual"]).map((k, v) => MapEntry<String, Manual>(k, Manual.fromJson(v))),
            enabledPurities: Map.from(json["enabled_purities"]).map((k, v) => MapEntry<String, bool>(k, v)),
        );
    }

    Map<String, dynamic> toJson() => {
        "default": inrDefault,
        "automatic": automatic?.toJson(),
        "manual": Map.from(manual).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "enabled_purities": Map.from(enabledPurities).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };

}

class FluffyAutomatic {
    FluffyAutomatic({
        required this.the650,
        required this.the750,
        required this.the850,
        required this.the925,
        required this.the995,
        required this.the999,
        required this.empty,
    });

    final The650? the650;
    final The650? the750;
    final The650? the850;
    final The650? the925;
    final The650? the995;
    final The650? the999;
    final Empty? empty;

    factory FluffyAutomatic.fromJson(Map<String, dynamic> json){ 
        return FluffyAutomatic(
            the650: json["650"] == null ? null : The650.fromJson(json["650"]),
            the750: json["750"] == null ? null : The650.fromJson(json["750"]),
            the850: json["850"] == null ? null : The650.fromJson(json["850"]),
            the925: json["925"] == null ? null : The650.fromJson(json["925"]),
            the995: json["995"] == null ? null : The650.fromJson(json["995"]),
            the999: json["999"] == null ? null : The650.fromJson(json["999"]),
            empty: json[""] == null ? null : Empty.fromJson(json[""]),
        );
    }

    Map<String, dynamic> toJson() => {
        "650": the650?.toJson(),
        "750": the750?.toJson(),
        "850": the850?.toJson(),
        "925": the925?.toJson(),
        "995": the995?.toJson(),
        "999": the999?.toJson(),
        "": empty?.toJson(),
    };

}

class The650 {
    The650({
        required this.base,
        required this.margin,
        required this.rate,
    });

    final dynamic base;
    final int? margin;
    final String? rate;

    factory The650.fromJson(Map<String, dynamic> json){ 
        return The650(
            base: json["base"],
            margin: json["margin"],
            rate: json["rate"],
        );
    }

    Map<String, dynamic> toJson() => {
        "base": base,
        "margin": margin,
        "rate": rate,
    };

}
