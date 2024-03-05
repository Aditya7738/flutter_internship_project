class LayoutModel {
    LayoutModel({
        required this.theme,
        required this.pages,
    });

    final LayoutTheme? theme;
    final List<LayoutPage> pages;

    factory LayoutModel.fromJson(Map<String, dynamic> json){ 
        return LayoutModel(
            theme: json["theme"] == null ? null : LayoutTheme.fromJson(json["theme"]),
            pages: json["pages"] == null ? [] : List<LayoutPage>.from(json["pages"]!.map((x) => LayoutPage.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "theme": theme?.toJson(),
        "pages": pages.map((x) => x?.toJson()).toList(),
    };

}

class LayoutPage {
    LayoutPage({
        required this.name,
        required this.layout,
        required this.children,
    });

    final String? name;
    final String? layout;
    final List<LayoutChild> children;

    factory LayoutPage.fromJson(Map<String, dynamic> json){ 
        return LayoutPage(
            name: json["name"],
            layout: json["layout"],
            children: json["children"] == null ? [] : List<LayoutChild>.from(json["children"]!.map((x) => LayoutChild.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "layout": layout,
        "children": children.map((x) => x?.toJson()).toList(),
    };

}

class LayoutChild {
    LayoutChild({
        required this.type,
        required this.text,
        required this.style,
        required this.images,
        required this.products,
    });

    final String? type;
    final String? text;
    final LayoutStyle? style;
    final List<String> images;
    final String? products;

    factory LayoutChild.fromJson(Map<String, dynamic> json){ 
        return LayoutChild(
            type: json["type"],
            text: json["text"],
            style: json["style"] == null ? null : LayoutStyle.fromJson(json["style"]),
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

class LayoutStyle {
    LayoutStyle({
        required this.color,
        required this.fontSize,
    });

    final String? color;
    final int? fontSize;

    factory LayoutStyle.fromJson(Map<String, dynamic> json){ 
        return LayoutStyle(
            color: json["color"],
            fontSize: json["fontSize"],
        );
    }

    Map<String, dynamic> toJson() => {
        "color": color,
        "fontSize": fontSize,
    };

}

class LayoutTheme {
    LayoutTheme({
        required this.colors,
        required this.fontFamily,
    });

    final LayoutColors? colors;
    final String? fontFamily;

    factory LayoutTheme.fromJson(Map<String, dynamic> json){ 
        return LayoutTheme(
            colors: json["colors"] == null ? null : LayoutColors.fromJson(json["colors"]),
            fontFamily: json["fontFamily"],
        );
    }

    Map<String, dynamic> toJson() => {
        "colors": colors?.toJson(),
        "fontFamily": fontFamily,
    };

}

class LayoutColors {
    LayoutColors({
        required this.primary,
        required this.secondary,
        required this.background,
    });

    final String? primary;
    final String? secondary;
    final String? background;

    factory LayoutColors.fromJson(Map<String, dynamic> json){ 
        return LayoutColors(
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
