class WoocommerceRazorpaySettingsModel {
    WoocommerceRazorpaySettingsModel({
        required this.success,
        required this.data,
    });

    final bool? success;
    final Data? data;

    factory WoocommerceRazorpaySettingsModel.fromJson(Map<String, dynamic> json){ 
        return WoocommerceRazorpaySettingsModel(
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
        required this.woocommerceRazorpaySettings,
    });

    final WoocommerceRazorpaySettings? woocommerceRazorpaySettings;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            woocommerceRazorpaySettings: json["woocommerce_razorpay_settings"] == null ? null : WoocommerceRazorpaySettings.fromJson(json["woocommerce_razorpay_settings"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "woocommerce_razorpay_settings": woocommerceRazorpaySettings?.toJson(),
    };

}

class WoocommerceRazorpaySettings {
    WoocommerceRazorpaySettings({
        required this.enabled,
        required this.title,
        required this.description,
        required this.keyId,
        required this.keySecret,
        required this.paymentAction,
        required this.orderSuccessMessage,
        required this.enable1CcDebugMode,
        required this.routeEnable,
        required this.webhookSecret,
    });

    final String? enabled;
    final String? title;
    final String? description;
    final String? keyId;
    final String? keySecret;
    final String? paymentAction;
    final String? orderSuccessMessage;
    final String? enable1CcDebugMode;
    final String? routeEnable;
    final String? webhookSecret;

    factory WoocommerceRazorpaySettings.fromJson(Map<String, dynamic> json){ 
        return WoocommerceRazorpaySettings(
            enabled: json["enabled"],
            title: json["title"],
            description: json["description"],
            keyId: json["key_id"],
            keySecret: json["key_secret"],
            paymentAction: json["payment_action"],
            orderSuccessMessage: json["order_success_message"],
            enable1CcDebugMode: json["enable_1cc_debug_mode"],
            routeEnable: json["route_enable"],
            webhookSecret: json["webhook_secret"],
        );
    }

    Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "title": title,
        "description": description,
        "key_id": keyId,
        "key_secret": keySecret,
        "payment_action": paymentAction,
        "order_success_message": orderSuccessMessage,
        "enable_1cc_debug_mode": enable1CcDebugMode,
        "route_enable": routeEnable,
        "webhook_secret": webhookSecret,
    };

}
