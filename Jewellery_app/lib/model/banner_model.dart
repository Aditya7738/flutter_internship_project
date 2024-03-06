class BannerModel {
    BannerModel({
        required this.id,
        required this.date,
        required this.dateGmt,
        required this.guid,
        required this.modified,
        required this.modifiedGmt,
        required this.slug,
        required this.status,
        required this.type,
        required this.link,
        required this.title,
        required this.content,
        required this.featuredMedia,
        required this.menuOrder,
        required this.template,
        required this.meta,
        required this.metadata,
       
    });

    final int? id;
    final DateTime? date;
    final DateTime? dateGmt;
    final Guid? guid;
    final DateTime? modified;
    final DateTime? modifiedGmt;
    final String? slug;
    final String? status;
    final String? type;
    final String? link;
    final Guid? title;
    final Content? content;
    final int? featuredMedia;
    final int? menuOrder;
    final String? template;
    final Meta? meta;
    final Metadata? metadata;
 

    factory BannerModel.fromJson(Map<String, dynamic> json){ 
        return BannerModel(
            id: json["id"],
            date: DateTime.tryParse(json["date"] ?? ""),
            dateGmt: DateTime.tryParse(json["date_gmt"] ?? ""),
            guid: json["guid"] == null ? null : Guid.fromJson(json["guid"]),
            modified: DateTime.tryParse(json["modified"] ?? ""),
            modifiedGmt: DateTime.tryParse(json["modified_gmt"] ?? ""),
            slug: json["slug"],
            status: json["status"],
            type: json["type"],
            link: json["link"],
            title: json["title"] == null ? null : Guid.fromJson(json["title"]),
            content: json["content"] == null ? null : Content.fromJson(json["content"]),
            featuredMedia: json["featured_media"],
            menuOrder: json["menu_order"],
            template: json["template"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
          
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "date_gmt": dateGmt?.toIso8601String(),
        "guid": guid?.toJson(),
        "modified": modified?.toIso8601String(),
        "modified_gmt": modifiedGmt?.toIso8601String(),
        "slug": slug,
        "status": status,
        "type": type,
        "link": link,
        "title": title?.toJson(),
        "content": content?.toJson(),
        "featured_media": featuredMedia,
        "menu_order": menuOrder,
        "template": template,
        "meta": meta?.toJson(),
        "metadata": metadata?.toJson(),
   
    };

}

class Content {
    Content({
        required this.rendered,
        required this.protected,
    });

    final String? rendered;
    final bool? protected;

    factory Content.fromJson(Map<String, dynamic> json){ 
        return Content(
            rendered: json["rendered"],
            protected: json["protected"],
        );
    }

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
    };

}

class Guid {
    Guid({
        required this.rendered,
    });

    final String? rendered;

    factory Guid.fromJson(Map<String, dynamic> json){ 
        return Guid(
            rendered: json["rendered"],
        );
    }

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
    };

}

class Links {
    Links({
        required this.self,
        required this.collection,
        required this.about,
        required this.wpFeaturedmedia,
        required this.wpAttachment,
        required this.curies,
    });

    final List<About> self;
    final List<About> collection;
    final List<About> about;
    final List<WpFeaturedmedia> wpFeaturedmedia;
    final List<About> wpAttachment;
    final List<Cury> curies;

    factory Links.fromJson(Map<String, dynamic> json){ 
        return Links(
            self: json["self"] == null ? [] : List<About>.from(json["self"]!.map((x) => About.fromJson(x))),
            collection: json["collection"] == null ? [] : List<About>.from(json["collection"]!.map((x) => About.fromJson(x))),
            about: json["about"] == null ? [] : List<About>.from(json["about"]!.map((x) => About.fromJson(x))),
            wpFeaturedmedia: json["wp:featuredmedia"] == null ? [] : List<WpFeaturedmedia>.from(json["wp:featuredmedia"]!.map((x) => WpFeaturedmedia.fromJson(x))),
            wpAttachment: json["wp:attachment"] == null ? [] : List<About>.from(json["wp:attachment"]!.map((x) => About.fromJson(x))),
            curies: json["curies"] == null ? [] : List<Cury>.from(json["curies"]!.map((x) => Cury.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "self": self.map((x) => x?.toJson()).toList(),
        "collection": collection.map((x) => x?.toJson()).toList(),
        "about": about.map((x) => x?.toJson()).toList(),
        "wp:featuredmedia": wpFeaturedmedia.map((x) => x?.toJson()).toList(),
        "wp:attachment": wpAttachment.map((x) => x?.toJson()).toList(),
        "curies": curies.map((x) => x?.toJson()).toList(),
    };

}

class About {
    About({
        required this.href,
    });

    final String? href;

    factory About.fromJson(Map<String, dynamic> json){ 
        return About(
            href: json["href"],
        );
    }

    Map<String, dynamic> toJson() => {
        "href": href,
    };

}

class Cury {
    Cury({
        required this.name,
        required this.href,
        required this.templated,
    });

    final String? name;
    final String? href;
    final bool? templated;

    factory Cury.fromJson(Map<String, dynamic> json){ 
        return Cury(
            name: json["name"],
            href: json["href"],
            templated: json["templated"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "href": href,
        "templated": templated,
    };

}

class WpFeaturedmedia {
    WpFeaturedmedia({
        required this.embeddable,
        required this.href,
    });

    final bool? embeddable;
    final String? href;

    factory WpFeaturedmedia.fromJson(Map<String, dynamic> json){ 
        return WpFeaturedmedia(
            embeddable: json["embeddable"],
            href: json["href"],
        );
    }

    Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
        "href": href,
    };

}

class Meta {
    Meta({
        required this.wdsPrimaryWoodmartSlider,
    });

    final int? wdsPrimaryWoodmartSlider;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            wdsPrimaryWoodmartSlider: json["wds_primary_woodmart_slider"],
        );
    }

    Map<String, dynamic> toJson() => {
        "wds_primary_woodmart_slider": wdsPrimaryWoodmartSlider,
    };

}

class Metadata {
    Metadata({
        required this.thumbnailId,
        required this.bgImageDesktop,
        required this.bgImageTablet,
        required this.bgImageMobile,
        required this.link,
    });

    final List<String> thumbnailId;
    final List<String> bgImageDesktop;
    final List<String> bgImageTablet;
    final List<String> bgImageMobile;
    final List<String> link;

    factory Metadata.fromJson(Map<String, dynamic> json){ 
        return Metadata(
            thumbnailId: json["_thumbnail_id"] == null ? [] : List<String>.from(json["_thumbnail_id"]!.map((x) => x)),
            bgImageDesktop: json["bg_image_desktop"] == null ? [] : List<String>.from(json["bg_image_desktop"]!.map((x) => x)),
            bgImageTablet: json["bg_image_tablet"] == null ? [] : List<String>.from(json["bg_image_tablet"]!.map((x) => x)),
            bgImageMobile: json["bg_image_mobile"] == null ? [] : List<String>.from(json["bg_image_mobile"]!.map((x) => x)),
            link: json["link"] == null ? [] : List<String>.from(json["link"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "_thumbnail_id": thumbnailId.map((x) => x).toList(),
        "bg_image_desktop": bgImageDesktop.map((x) => x).toList(),
        "bg_image_tablet": bgImageTablet.map((x) => x).toList(),
        "bg_image_mobile": bgImageMobile.map((x) => x).toList(),
        "link": link.map((x) => x).toList(),
    };

}
