class LayoutModel {
    LayoutModel({
        required this.success,
        required this.data,
    });

    final bool? success;
    final Data? data;

    factory LayoutModel.fromJson(Map<String, dynamic> json){ 
        return LayoutModel(
            success: json["success"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.theme,
        required this.pages,
    });

    final Theme? theme;
    final List<Page> pages;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            theme: json["theme"] == null ? null : Theme.fromJson(json["theme"]),
            pages: json["pages"] == null ? [] : List<Page>.from(json["pages"]!.map((x) => Page.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "theme": theme?.toJson(),
        "pages": pages.map((x) => x?.toJson()).toList(),
    };

}

class Page {
    Page({
        required this.name,
        required this.layout,
        required this.children,
    });

    final String? name;
    final String? layout;
    final List<Child> children;

    factory Page.fromJson(Map<String, dynamic> json){ 
        return Page(
            name: json["name"],
            layout: json["layout"],
            children: json["children"] == null ? [] : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "layout": layout,
        "children": children.map((x) => x?.toJson()).toList(),
    };

}

class Child {
    Child({
        required this.type,
        required this.text,
        required this.style,
        required this.images,
        required this.products,
    });

    final String? type;
    final String? text;
    final Style? style;
    final List<String> images;
    final String? products;

    factory Child.fromJson(Map<String, dynamic> json){ 
        return Child(
            type: json["type"],
            text: json["text"],
            style: json["style"] == null ? null : Style.fromJson(json["style"]),
            images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
            products: json["products"],
        );
    }

    Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "style": style?.toJson(),
        "images": images.map((x) => x).toList(),
        "products": products,
    };

}

class Style {
    Style({
        required this.color,
        required this.fontSize,
    });

    final String? color;
    final int? fontSize;

    factory Style.fromJson(Map<String, dynamic> json){ 
        return Style(
            color: json["color"],
            fontSize: json["fontSize"],
        );
    }

    Map<String, dynamic> toJson() => {
        "color": color,
        "fontSize": fontSize,
    };

}

class Theme {
    Theme({
        required this.colors,
        required this.fontFamily,
    });

    final Colors? colors;
    final String? fontFamily;

    factory Theme.fromJson(Map<String, dynamic> json){ 
        return Theme(
            colors: json["colors"] == null ? null : Colors.fromJson(json["colors"]),
            fontFamily: json["fontFamily"],
        );
    }

    Map<String, dynamic> toJson() => {
        "colors": colors?.toJson(),
        "fontFamily": fontFamily,
    };

}

class Colors {
    Colors({
        required this.primary,
        required this.secondary,
        required this.background,
    });

    final String? primary;
    final String? secondary;
    final String? background;

    factory Colors.fromJson(Map<String, dynamic> json){ 
        return Colors(
            primary: json["primary"],
            secondary: json["secondary"],
            background: json["background"],
        );
    }

    Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary,
        "background": background,
    };

}
