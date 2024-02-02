class PaymentGatewaysModel {
    PaymentGatewaysModel({
        required this.id,
        required this.title,
        required this.description,
        required this.order,
        required this.enabled,
        required this.methodTitle,
        required this.methodDescription,
        required this.methodSupports,
        required this.settings,
        required this.needsSetup,
        required this.postInstallScripts,
        required this.settingsUrl,
        required this.connectionUrl,
        required this.setupHelpText,
        required this.requiredSettingsKeys,
      this.links,
    });

    final String? id;
    final String? title;
    final String? description;
    final dynamic? order;
    final bool? enabled;
    final String? methodTitle;
    final String? methodDescription;
    final List<String> methodSupports;
    final dynamic? settings;
    final bool? needsSetup;
    final List<dynamic> postInstallScripts;
    final String? settingsUrl;
    final String? connectionUrl;
    final String? setupHelpText;
    final List<String> requiredSettingsKeys;
    final Links? links;

    factory PaymentGatewaysModel.fromJson(Map<String, dynamic> json){ 
        return PaymentGatewaysModel(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            order: json["order"],
            enabled: json["enabled"],
            methodTitle: json["method_title"],
            methodDescription: json["method_description"],
            methodSupports: json["method_supports"] == null ? [] : List<String>.from(json["method_supports"]!.map((x) => x)),
            settings: json["settings"],
            needsSetup: json["needs_setup"],
            postInstallScripts: json["post_install_scripts"] == null ? [] : List<dynamic>.from(json["post_install_scripts"]!.map((x) => x)),
            settingsUrl: json["settings_url"],
            connectionUrl: json["connection_url"],
            setupHelpText: json["setup_help_text"],
            requiredSettingsKeys: json["required_settings_keys"] == null ? [] : List<String>.from(json["required_settings_keys"]!.map((x) => x)),
            links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "order": order,
        "enabled": enabled,
        "method_title": methodTitle,
        "method_description": methodDescription,
        "method_supports": methodSupports.map((x) => x).toList(),
        "settings": settings,
        "needs_setup": needsSetup,
        "post_install_scripts": postInstallScripts.map((x) => x).toList(),
        "settings_url": settingsUrl,
        "connection_url": connectionUrl,
        "setup_help_text": setupHelpText,
        "required_settings_keys": requiredSettingsKeys.map((x) => x).toList(),
        "_links": links?.toJson(),
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
        "self": self.map((x) => x?.toJson()).toList(),
        "collection": collection.map((x) => x?.toJson()).toList(),
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

class SettingsClass {
    SettingsClass({
        required this.title,
        required this.instructions,
        required this.enableForMethods,
        required this.enableForVirtual,
        required this.email,
        required this.advanced,
        required this.testmode,
        required this.debug,
        required this.ipnNotification,
        required this.receiverEmail,
        required this.identityToken,
        required this.invoicePrefix,
        required this.sendShipping,
        required this.addressOverride,
        required this.paymentaction,
        required this.imageUrl,
        required this.apiDetails,
        required this.apiUsername,
        required this.apiPassword,
        required this.apiSignature,
        required this.sandboxApiUsername,
        required this.sandboxApiPassword,
        required this.sandboxApiSignature,
        required this.appId,
        required this.secretKey,
        required this.sandbox,
        required this.orderButtonText,
        required this.orderIdPrefixText,
        required this.inContext,
        required this.enabledOffers,
        required this.offers,
        required this.payLater,
        required this.emi,
        required this.enableCurrencyConversion,
        required this.iframemode,
        required this.merchantId,
        required this.workingKey,
        required this.accessCode,
        required this.defaultAdd1,
        required this.defaultCity,
        required this.defaultState,
        required this.defaultZip,
        required this.defaultCountry,
        required this.defaultPhone,
        required this.keyId,
        required this.keySecret,
        required this.paymentAction,
        required this.orderSuccessMessage,
        required this.enable1CcDebugMode,
        required this.routeEnable,
        required this.gatewayModule,
        required this.currency1,
        required this.currency1PayuKey,
        required this.currency1PayuSalt,
        required this.currency2,
        required this.currency2PayuKey,
        required this.currency2PayuSalt,
        required this.currency3,
        required this.currency3PayuKey,
        required this.currency3PayuSalt,
        required this.currency4,
        required this.currency4PayuKey,
        required this.currency4PayuSalt,
        required this.currency5,
        required this.currency5PayuKey,
        required this.currency5PayuSalt,
        required this.currency6,
        required this.currency6PayuKey,
        required this.currency6PayuSalt,
        required this.currency7,
        required this.currency7PayuKey,
        required this.currency7PayuSalt,
        required this.currency8,
        required this.currency8PayuKey,
        required this.currency8PayuSalt,
        required this.currency9,
        required this.currency9PayuKey,
        required this.currency9PayuSalt,
        required this.currency10,
        required this.currency10PayuKey,
        required this.currency10PayuSalt,
        required this.verifyPayment,
        required this.redirectPageId,
        required this.apiCredentials,
        required this.testPublishableKey,
        required this.testSecretKey,
        required this.publishableKey,
        required this.webhook,
        required this.testWebhookSecret,
        required this.webhookSecret,
        required this.inlineCcForm,
        required this.statementDescriptor,
        required this.shortStatementDescriptor,
        required this.capture,
        required this.paymentRequest,
        required this.paymentRequestButtonType,
        required this.paymentRequestButtonTheme,
        required this.paymentRequestButtonLocations,
        required this.paymentRequestButtonSize,
        required this.savedCards,
        required this.logging,
        required this.upeCheckoutExperienceEnabled,
        required this.expiration,
    });

    final AccessCode? title;
    final AccessCode? instructions;
    final AccessCode? enableForMethods;
    final AccessCode? enableForVirtual;
    final AccessCode? email;
    final AccessCode? advanced;
    final AccessCode? testmode;
    final AccessCode? debug;
    final AccessCode? ipnNotification;
    final AccessCode? receiverEmail;
    final AccessCode? identityToken;
    final AccessCode? invoicePrefix;
    final AccessCode? sendShipping;
    final AccessCode? addressOverride;
    final AccessCode? paymentaction;
    final AccessCode? imageUrl;
    final AccessCode? apiDetails;
    final AccessCode? apiUsername;
    final AccessCode? apiPassword;
    final AccessCode? apiSignature;
    final AccessCode? sandboxApiUsername;
    final AccessCode? sandboxApiPassword;
    final AccessCode? sandboxApiSignature;
    final AccessCode? appId;
    final AccessCode? secretKey;
    final AccessCode? sandbox;
    final AccessCode? orderButtonText;
    final AccessCode? orderIdPrefixText;
    final AccessCode? inContext;
    final AccessCode? enabledOffers;
    final AccessCode? offers;
    final AccessCode? payLater;
    final AccessCode? emi;
    final AccessCode? enableCurrencyConversion;
    final AccessCode? iframemode;
    final AccessCode? merchantId;
    final AccessCode? workingKey;
    final AccessCode? accessCode;
    final AccessCode? defaultAdd1;
    final AccessCode? defaultCity;
    final AccessCode? defaultState;
    final AccessCode? defaultZip;
    final AccessCode? defaultCountry;
    final AccessCode? defaultPhone;
    final AccessCode? keyId;
    final AccessCode? keySecret;
    final AccessCode? paymentAction;
    final AccessCode? orderSuccessMessage;
    final AccessCode? enable1CcDebugMode;
    final AccessCode? routeEnable;
    final AccessCode? gatewayModule;
    final AccessCode? currency1;
    final AccessCode? currency1PayuKey;
    final AccessCode? currency1PayuSalt;
    final AccessCode? currency2;
    final AccessCode? currency2PayuKey;
    final AccessCode? currency2PayuSalt;
    final AccessCode? currency3;
    final AccessCode? currency3PayuKey;
    final AccessCode? currency3PayuSalt;
    final AccessCode? currency4;
    final AccessCode? currency4PayuKey;
    final AccessCode? currency4PayuSalt;
    final AccessCode? currency5;
    final AccessCode? currency5PayuKey;
    final AccessCode? currency5PayuSalt;
    final AccessCode? currency6;
    final AccessCode? currency6PayuKey;
    final AccessCode? currency6PayuSalt;
    final AccessCode? currency7;
    final AccessCode? currency7PayuKey;
    final AccessCode? currency7PayuSalt;
    final AccessCode? currency8;
    final AccessCode? currency8PayuKey;
    final AccessCode? currency8PayuSalt;
    final AccessCode? currency9;
    final AccessCode? currency9PayuKey;
    final AccessCode? currency9PayuSalt;
    final AccessCode? currency10;
    final AccessCode? currency10PayuKey;
    final AccessCode? currency10PayuSalt;
    final AccessCode? verifyPayment;
    final AccessCode? redirectPageId;
    final AccessCode? apiCredentials;
    final AccessCode? testPublishableKey;
    final AccessCode? testSecretKey;
    final AccessCode? publishableKey;
    final AccessCode? webhook;
    final AccessCode? testWebhookSecret;
    final AccessCode? webhookSecret;
    final AccessCode? inlineCcForm;
    final AccessCode? statementDescriptor;
    final AccessCode? shortStatementDescriptor;
    final AccessCode? capture;
    final AccessCode? paymentRequest;
    final AccessCode? paymentRequestButtonType;
    final AccessCode? paymentRequestButtonTheme;
    final PaymentRequestButtonLocations? paymentRequestButtonLocations;
    final AccessCode? paymentRequestButtonSize;
    final AccessCode? savedCards;
    final AccessCode? logging;
    final AccessCode? upeCheckoutExperienceEnabled;
    final Expiration? expiration;

    factory SettingsClass.fromJson(Map<String, dynamic> json){ 
        return SettingsClass(
            title: json["title"] == null ? null : AccessCode.fromJson(json["title"]),
            instructions: json["instructions"] == null ? null : AccessCode.fromJson(json["instructions"]),
            enableForMethods: json["enable_for_methods"] == null ? null : AccessCode.fromJson(json["enable_for_methods"]),
            enableForVirtual: json["enable_for_virtual"] == null ? null : AccessCode.fromJson(json["enable_for_virtual"]),
            email: json["email"] == null ? null : AccessCode.fromJson(json["email"]),
            advanced: json["advanced"] == null ? null : AccessCode.fromJson(json["advanced"]),
            testmode: json["testmode"] == null ? null : AccessCode.fromJson(json["testmode"]),
            debug: json["debug"] == null ? null : AccessCode.fromJson(json["debug"]),
            ipnNotification: json["ipn_notification"] == null ? null : AccessCode.fromJson(json["ipn_notification"]),
            receiverEmail: json["receiver_email"] == null ? null : AccessCode.fromJson(json["receiver_email"]),
            identityToken: json["identity_token"] == null ? null : AccessCode.fromJson(json["identity_token"]),
            invoicePrefix: json["invoice_prefix"] == null ? null : AccessCode.fromJson(json["invoice_prefix"]),
            sendShipping: json["send_shipping"] == null ? null : AccessCode.fromJson(json["send_shipping"]),
            addressOverride: json["address_override"] == null ? null : AccessCode.fromJson(json["address_override"]),
            paymentaction: json["paymentaction"] == null ? null : AccessCode.fromJson(json["paymentaction"]),
            imageUrl: json["image_url"] == null ? null : AccessCode.fromJson(json["image_url"]),
            apiDetails: json["api_details"] == null ? null : AccessCode.fromJson(json["api_details"]),
            apiUsername: json["api_username"] == null ? null : AccessCode.fromJson(json["api_username"]),
            apiPassword: json["api_password"] == null ? null : AccessCode.fromJson(json["api_password"]),
            apiSignature: json["api_signature"] == null ? null : AccessCode.fromJson(json["api_signature"]),
            sandboxApiUsername: json["sandbox_api_username"] == null ? null : AccessCode.fromJson(json["sandbox_api_username"]),
            sandboxApiPassword: json["sandbox_api_password"] == null ? null : AccessCode.fromJson(json["sandbox_api_password"]),
            sandboxApiSignature: json["sandbox_api_signature"] == null ? null : AccessCode.fromJson(json["sandbox_api_signature"]),
            appId: json["app_id"] == null ? null : AccessCode.fromJson(json["app_id"]),
            secretKey: json["secret_key"] == null ? null : AccessCode.fromJson(json["secret_key"]),
            sandbox: json["sandbox"] == null ? null : AccessCode.fromJson(json["sandbox"]),
            orderButtonText: json["order_button_text"] == null ? null : AccessCode.fromJson(json["order_button_text"]),
            orderIdPrefixText: json["order_id_prefix_text"] == null ? null : AccessCode.fromJson(json["order_id_prefix_text"]),
            inContext: json["in_context"] == null ? null : AccessCode.fromJson(json["in_context"]),
            enabledOffers: json["enabledOffers"] == null ? null : AccessCode.fromJson(json["enabledOffers"]),
            offers: json["offers"] == null ? null : AccessCode.fromJson(json["offers"]),
            payLater: json["payLater"] == null ? null : AccessCode.fromJson(json["payLater"]),
            emi: json["emi"] == null ? null : AccessCode.fromJson(json["emi"]),
            enableCurrencyConversion: json["enable_currency_conversion"] == null ? null : AccessCode.fromJson(json["enable_currency_conversion"]),
            iframemode: json["iframemode"] == null ? null : AccessCode.fromJson(json["iframemode"]),
            merchantId: json["merchant_id"] == null ? null : AccessCode.fromJson(json["merchant_id"]),
            workingKey: json["working_key"] == null ? null : AccessCode.fromJson(json["working_key"]),
            accessCode: json["access_code"] == null ? null : AccessCode.fromJson(json["access_code"]),
            defaultAdd1: json["default_add1"] == null ? null : AccessCode.fromJson(json["default_add1"]),
            defaultCity: json["default_city"] == null ? null : AccessCode.fromJson(json["default_city"]),
            defaultState: json["default_state"] == null ? null : AccessCode.fromJson(json["default_state"]),
            defaultZip: json["default_zip"] == null ? null : AccessCode.fromJson(json["default_zip"]),
            defaultCountry: json["default_country"] == null ? null : AccessCode.fromJson(json["default_country"]),
            defaultPhone: json["default_phone"] == null ? null : AccessCode.fromJson(json["default_phone"]),
            keyId: json["key_id"] == null ? null : AccessCode.fromJson(json["key_id"]),
            keySecret: json["key_secret"] == null ? null : AccessCode.fromJson(json["key_secret"]),
            paymentAction: json["payment_action"] == null ? null : AccessCode.fromJson(json["payment_action"]),
            orderSuccessMessage: json["order_success_message"] == null ? null : AccessCode.fromJson(json["order_success_message"]),
            enable1CcDebugMode: json["enable_1cc_debug_mode"] == null ? null : AccessCode.fromJson(json["enable_1cc_debug_mode"]),
            routeEnable: json["route_enable"] == null ? null : AccessCode.fromJson(json["route_enable"]),
            gatewayModule: json["gateway_module"] == null ? null : AccessCode.fromJson(json["gateway_module"]),
            currency1: json["currency1"] == null ? null : AccessCode.fromJson(json["currency1"]),
            currency1PayuKey: json["currency1_payu_key"] == null ? null : AccessCode.fromJson(json["currency1_payu_key"]),
            currency1PayuSalt: json["currency1_payu_salt"] == null ? null : AccessCode.fromJson(json["currency1_payu_salt"]),
            currency2: json["currency2"] == null ? null : AccessCode.fromJson(json["currency2"]),
            currency2PayuKey: json["currency2_payu_key"] == null ? null : AccessCode.fromJson(json["currency2_payu_key"]),
            currency2PayuSalt: json["currency2_payu_salt"] == null ? null : AccessCode.fromJson(json["currency2_payu_salt"]),
            currency3: json["currency3"] == null ? null : AccessCode.fromJson(json["currency3"]),
            currency3PayuKey: json["currency3_payu_key"] == null ? null : AccessCode.fromJson(json["currency3_payu_key"]),
            currency3PayuSalt: json["currency3_payu_salt"] == null ? null : AccessCode.fromJson(json["currency3_payu_salt"]),
            currency4: json["currency4"] == null ? null : AccessCode.fromJson(json["currency4"]),
            currency4PayuKey: json["currency4_payu_key"] == null ? null : AccessCode.fromJson(json["currency4_payu_key"]),
            currency4PayuSalt: json["currency4_payu_salt"] == null ? null : AccessCode.fromJson(json["currency4_payu_salt"]),
            currency5: json["currency5"] == null ? null : AccessCode.fromJson(json["currency5"]),
            currency5PayuKey: json["currency5_payu_key"] == null ? null : AccessCode.fromJson(json["currency5_payu_key"]),
            currency5PayuSalt: json["currency5_payu_salt"] == null ? null : AccessCode.fromJson(json["currency5_payu_salt"]),
            currency6: json["currency6"] == null ? null : AccessCode.fromJson(json["currency6"]),
            currency6PayuKey: json["currency6_payu_key"] == null ? null : AccessCode.fromJson(json["currency6_payu_key"]),
            currency6PayuSalt: json["currency6_payu_salt"] == null ? null : AccessCode.fromJson(json["currency6_payu_salt"]),
            currency7: json["currency7"] == null ? null : AccessCode.fromJson(json["currency7"]),
            currency7PayuKey: json["currency7_payu_key"] == null ? null : AccessCode.fromJson(json["currency7_payu_key"]),
            currency7PayuSalt: json["currency7_payu_salt"] == null ? null : AccessCode.fromJson(json["currency7_payu_salt"]),
            currency8: json["currency8"] == null ? null : AccessCode.fromJson(json["currency8"]),
            currency8PayuKey: json["currency8_payu_key"] == null ? null : AccessCode.fromJson(json["currency8_payu_key"]),
            currency8PayuSalt: json["currency8_payu_salt"] == null ? null : AccessCode.fromJson(json["currency8_payu_salt"]),
            currency9: json["currency9"] == null ? null : AccessCode.fromJson(json["currency9"]),
            currency9PayuKey: json["currency9_payu_key"] == null ? null : AccessCode.fromJson(json["currency9_payu_key"]),
            currency9PayuSalt: json["currency9_payu_salt"] == null ? null : AccessCode.fromJson(json["currency9_payu_salt"]),
            currency10: json["currency10"] == null ? null : AccessCode.fromJson(json["currency10"]),
            currency10PayuKey: json["currency10_payu_key"] == null ? null : AccessCode.fromJson(json["currency10_payu_key"]),
            currency10PayuSalt: json["currency10_payu_salt"] == null ? null : AccessCode.fromJson(json["currency10_payu_salt"]),
            verifyPayment: json["verify_payment"] == null ? null : AccessCode.fromJson(json["verify_payment"]),
            redirectPageId: json["redirect_page_id"] == null ? null : AccessCode.fromJson(json["redirect_page_id"]),
            apiCredentials: json["api_credentials"] == null ? null : AccessCode.fromJson(json["api_credentials"]),
            testPublishableKey: json["test_publishable_key"] == null ? null : AccessCode.fromJson(json["test_publishable_key"]),
            testSecretKey: json["test_secret_key"] == null ? null : AccessCode.fromJson(json["test_secret_key"]),
            publishableKey: json["publishable_key"] == null ? null : AccessCode.fromJson(json["publishable_key"]),
            webhook: json["webhook"] == null ? null : AccessCode.fromJson(json["webhook"]),
            testWebhookSecret: json["test_webhook_secret"] == null ? null : AccessCode.fromJson(json["test_webhook_secret"]),
            webhookSecret: json["webhook_secret"] == null ? null : AccessCode.fromJson(json["webhook_secret"]),
            inlineCcForm: json["inline_cc_form"] == null ? null : AccessCode.fromJson(json["inline_cc_form"]),
            statementDescriptor: json["statement_descriptor"] == null ? null : AccessCode.fromJson(json["statement_descriptor"]),
            shortStatementDescriptor: json["short_statement_descriptor"] == null ? null : AccessCode.fromJson(json["short_statement_descriptor"]),
            capture: json["capture"] == null ? null : AccessCode.fromJson(json["capture"]),
            paymentRequest: json["payment_request"] == null ? null : AccessCode.fromJson(json["payment_request"]),
            paymentRequestButtonType: json["payment_request_button_type"] == null ? null : AccessCode.fromJson(json["payment_request_button_type"]),
            paymentRequestButtonTheme: json["payment_request_button_theme"] == null ? null : AccessCode.fromJson(json["payment_request_button_theme"]),
            paymentRequestButtonLocations: json["payment_request_button_locations"] == null ? null : PaymentRequestButtonLocations.fromJson(json["payment_request_button_locations"]),
            paymentRequestButtonSize: json["payment_request_button_size"] == null ? null : AccessCode.fromJson(json["payment_request_button_size"]),
            savedCards: json["saved_cards"] == null ? null : AccessCode.fromJson(json["saved_cards"]),
            logging: json["logging"] == null ? null : AccessCode.fromJson(json["logging"]),
            upeCheckoutExperienceEnabled: json["upe_checkout_experience_enabled"] == null ? null : AccessCode.fromJson(json["upe_checkout_experience_enabled"]),
            expiration: json["expiration"] == null ? null : Expiration.fromJson(json["expiration"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "title": title?.toJson(),
        "instructions": instructions?.toJson(),
        "enable_for_methods": enableForMethods?.toJson(),
        "enable_for_virtual": enableForVirtual?.toJson(),
        "email": email?.toJson(),
        "advanced": advanced?.toJson(),
        "testmode": testmode?.toJson(),
        "debug": debug?.toJson(),
        "ipn_notification": ipnNotification?.toJson(),
        "receiver_email": receiverEmail?.toJson(),
        "identity_token": identityToken?.toJson(),
        "invoice_prefix": invoicePrefix?.toJson(),
        "send_shipping": sendShipping?.toJson(),
        "address_override": addressOverride?.toJson(),
        "paymentaction": paymentaction?.toJson(),
        "image_url": imageUrl?.toJson(),
        "api_details": apiDetails?.toJson(),
        "api_username": apiUsername?.toJson(),
        "api_password": apiPassword?.toJson(),
        "api_signature": apiSignature?.toJson(),
        "sandbox_api_username": sandboxApiUsername?.toJson(),
        "sandbox_api_password": sandboxApiPassword?.toJson(),
        "sandbox_api_signature": sandboxApiSignature?.toJson(),
        "app_id": appId?.toJson(),
        "secret_key": secretKey?.toJson(),
        "sandbox": sandbox?.toJson(),
        "order_button_text": orderButtonText?.toJson(),
        "order_id_prefix_text": orderIdPrefixText?.toJson(),
        "in_context": inContext?.toJson(),
        "enabledOffers": enabledOffers?.toJson(),
        "offers": offers?.toJson(),
        "payLater": payLater?.toJson(),
        "emi": emi?.toJson(),
        "enable_currency_conversion": enableCurrencyConversion?.toJson(),
        "iframemode": iframemode?.toJson(),
        "merchant_id": merchantId?.toJson(),
        "working_key": workingKey?.toJson(),
        "access_code": accessCode?.toJson(),
        "default_add1": defaultAdd1?.toJson(),
        "default_city": defaultCity?.toJson(),
        "default_state": defaultState?.toJson(),
        "default_zip": defaultZip?.toJson(),
        "default_country": defaultCountry?.toJson(),
        "default_phone": defaultPhone?.toJson(),
        "key_id": keyId?.toJson(),
        "key_secret": keySecret?.toJson(),
        "payment_action": paymentAction?.toJson(),
        "order_success_message": orderSuccessMessage?.toJson(),
        "enable_1cc_debug_mode": enable1CcDebugMode?.toJson(),
        "route_enable": routeEnable?.toJson(),
        "gateway_module": gatewayModule?.toJson(),
        "currency1": currency1?.toJson(),
        "currency1_payu_key": currency1PayuKey?.toJson(),
        "currency1_payu_salt": currency1PayuSalt?.toJson(),
        "currency2": currency2?.toJson(),
        "currency2_payu_key": currency2PayuKey?.toJson(),
        "currency2_payu_salt": currency2PayuSalt?.toJson(),
        "currency3": currency3?.toJson(),
        "currency3_payu_key": currency3PayuKey?.toJson(),
        "currency3_payu_salt": currency3PayuSalt?.toJson(),
        "currency4": currency4?.toJson(),
        "currency4_payu_key": currency4PayuKey?.toJson(),
        "currency4_payu_salt": currency4PayuSalt?.toJson(),
        "currency5": currency5?.toJson(),
        "currency5_payu_key": currency5PayuKey?.toJson(),
        "currency5_payu_salt": currency5PayuSalt?.toJson(),
        "currency6": currency6?.toJson(),
        "currency6_payu_key": currency6PayuKey?.toJson(),
        "currency6_payu_salt": currency6PayuSalt?.toJson(),
        "currency7": currency7?.toJson(),
        "currency7_payu_key": currency7PayuKey?.toJson(),
        "currency7_payu_salt": currency7PayuSalt?.toJson(),
        "currency8": currency8?.toJson(),
        "currency8_payu_key": currency8PayuKey?.toJson(),
        "currency8_payu_salt": currency8PayuSalt?.toJson(),
        "currency9": currency9?.toJson(),
        "currency9_payu_key": currency9PayuKey?.toJson(),
        "currency9_payu_salt": currency9PayuSalt?.toJson(),
        "currency10": currency10?.toJson(),
        "currency10_payu_key": currency10PayuKey?.toJson(),
        "currency10_payu_salt": currency10PayuSalt?.toJson(),
        "verify_payment": verifyPayment?.toJson(),
        "redirect_page_id": redirectPageId?.toJson(),
        "api_credentials": apiCredentials?.toJson(),
        "test_publishable_key": testPublishableKey?.toJson(),
        "test_secret_key": testSecretKey?.toJson(),
        "publishable_key": publishableKey?.toJson(),
        "webhook": webhook?.toJson(),
        "test_webhook_secret": testWebhookSecret?.toJson(),
        "webhook_secret": webhookSecret?.toJson(),
        "inline_cc_form": inlineCcForm?.toJson(),
        "statement_descriptor": statementDescriptor?.toJson(),
        "short_statement_descriptor": shortStatementDescriptor?.toJson(),
        "capture": capture?.toJson(),
        "payment_request": paymentRequest?.toJson(),
        "payment_request_button_type": paymentRequestButtonType?.toJson(),
        "payment_request_button_theme": paymentRequestButtonTheme?.toJson(),
        "payment_request_button_locations": paymentRequestButtonLocations?.toJson(),
        "payment_request_button_size": paymentRequestButtonSize?.toJson(),
        "saved_cards": savedCards?.toJson(),
        "logging": logging?.toJson(),
        "upe_checkout_experience_enabled": upeCheckoutExperienceEnabled?.toJson(),
        "expiration": expiration?.toJson(),
    };

}

class AccessCode {
    AccessCode({
        required this.id,
        required this.label,
        required this.description,
        required this.type,
        required this.value,
        required this.accessCodeDefault,
        required this.tip,
        required this.placeholder,
        required this.options,
    });

    final String? id;
    final String? label;
    final String? description;
    final String? type;
    final String? value;
    final String? accessCodeDefault;
    final String? tip;
    final String? placeholder;
    final dynamic? options;

    factory AccessCode.fromJson(Map<String, dynamic> json){ 
        return AccessCode(
            id: json["id"],
            label: json["label"],
            description: json["description"],
            type: json["type"],
            value: json["value"],
            accessCodeDefault: json["default"],
            tip: json["tip"],
            placeholder: json["placeholder"],
            options: json["options"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "description": description,
        "type": type,
        "value": value,
        "default": accessCodeDefault,
        "tip": tip,
        "placeholder": placeholder,
        "options": options,
    };

}

class OptionsOptions {
    OptionsOptions({
        required this.flatRate,
        required this.freeShipping,
        required this.localPickup,
        required this.the0,
        required this.sandbox,
        required this.production,
        required this.authorize,
        required this.capture,
        required this.small,
        required this.optionsDefault,
        required this.large,
        required this.dark,
        required this.light,
        required this.lightOutline,
        required this.buy,
        required this.donate,
        required this.book,
        required this.sale,
        required this.authorization,
        required this.the15,
        required this.the16,
        required this.the19,
        required this.the20,
        required this.the21,
        required this.the22,
        required this.the23,
        required this.the24,
        required this.the25,
        required this.the26,
        required this.the107,
        required this.the150,
        required this.the165,
        required this.the265,
        required this.the267,
        required this.the1160,
        required this.the2675,
        required this.the2791,
        required this.the21551,
        required this.the24203,
        required this.the24305,
        required this.the29747,
        required this.the44599,
        required this.the44679,
        required this.the44706,
        required this.the44719,
        required this.the44737,
        required this.the44800,
        required this.the45703,
        required this.the45741,
        required this.the46136,
        required this.the47031,
        required this.the47516,
        required this.the53080,
        required this.the53525,
        required this.the54236,
        required this.the54237,
        required this.the55626,
        required this.the55627,
        required this.the55628,
        required this.the57381,
        required this.the57492,
        required this.the71612,
        required this.yes,
        required this.no,
    });

    final FlatRate? flatRate;
    final FreeShipping? freeShipping;
    final LocalPickup? localPickup;
    final String? the0;
    final String? sandbox;
    final String? production;
    final String? authorize;
    final String? capture;
    final String? small;
    final String? optionsDefault;
    final String? large;
    final String? dark;
    final String? light;
    final String? lightOutline;
    final String? buy;
    final String? donate;
    final String? book;
    final String? sale;
    final String? authorization;
    final String? the15;
    final String? the16;
    final String? the19;
    final String? the20;
    final String? the21;
    final String? the22;
    final String? the23;
    final String? the24;
    final String? the25;
    final String? the26;
    final String? the107;
    final String? the150;
    final String? the165;
    final String? the265;
    final String? the267;
    final String? the1160;
    final String? the2675;
    final String? the2791;
    final String? the21551;
    final String? the24203;
    final String? the24305;
    final String? the29747;
    final String? the44599;
    final String? the44679;
    final String? the44706;
    final String? the44719;
    final String? the44737;
    final String? the44800;
    final String? the45703;
    final String? the45741;
    final String? the46136;
    final String? the47031;
    final String? the47516;
    final String? the53080;
    final String? the53525;
    final String? the54236;
    final String? the54237;
    final String? the55626;
    final String? the55627;
    final String? the55628;
    final String? the57381;
    final String? the57492;
    final String? the71612;
    final String? yes;
    final String? no;

    factory OptionsOptions.fromJson(Map<String, dynamic> json){ 
        return OptionsOptions(
            flatRate: json["Flat rate"] == null ? null : FlatRate.fromJson(json["Flat rate"]),
            freeShipping: json["Free shipping"] == null ? null : FreeShipping.fromJson(json["Free shipping"]),
            localPickup: json["Local pickup"] == null ? null : LocalPickup.fromJson(json["Local pickup"]),
            the0: json["0"],
            sandbox: json["sandbox"],
            production: json["production"],
            authorize: json["authorize"],
            capture: json["capture"],
            small: json["small"],
            optionsDefault: json["default"],
            large: json["large"],
            dark: json["dark"],
            light: json["light"],
            lightOutline: json["light-outline"],
            buy: json["buy"],
            donate: json["donate"],
            book: json["book"],
            sale: json["sale"],
            authorization: json["authorization"],
            the15: json["15"],
            the16: json["16"],
            the19: json["19"],
            the20: json["20"],
            the21: json["21"],
            the22: json["22"],
            the23: json["23"],
            the24: json["24"],
            the25: json["25"],
            the26: json["26"],
            the107: json["107"],
            the150: json["150"],
            the165: json["165"],
            the265: json["265"],
            the267: json["267"],
            the1160: json["1160"],
            the2675: json["2675"],
            the2791: json["2791"],
            the21551: json["21551"],
            the24203: json["24203"],
            the24305: json["24305"],
            the29747: json["29747"],
            the44599: json["44599"],
            the44679: json["44679"],
            the44706: json["44706"],
            the44719: json["44719"],
            the44737: json["44737"],
            the44800: json["44800"],
            the45703: json["45703"],
            the45741: json["45741"],
            the46136: json["46136"],
            the47031: json["47031"],
            the47516: json["47516"],
            the53080: json["53080"],
            the53525: json["53525"],
            the54236: json["54236"],
            the54237: json["54237"],
            the55626: json["55626"],
            the55627: json["55627"],
            the55628: json["55628"],
            the57381: json["57381"],
            the57492: json["57492"],
            the71612: json["71612"],
            yes: json["yes"],
            no: json["no"],
        );
    }

    Map<String, dynamic> toJson() => {
        "Flat rate": flatRate?.toJson(),
        "Free shipping": freeShipping?.toJson(),
        "Local pickup": localPickup?.toJson(),
        "0": the0,
        "sandbox": sandbox,
        "production": production,
        "authorize": authorize,
        "capture": capture,
        "small": small,
        "default": optionsDefault,
        "large": large,
        "dark": dark,
        "light": light,
        "light-outline": lightOutline,
        "buy": buy,
        "donate": donate,
        "book": book,
        "sale": sale,
        "authorization": authorization,
        "15": the15,
        "16": the16,
        "19": the19,
        "20": the20,
        "21": the21,
        "22": the22,
        "23": the23,
        "24": the24,
        "25": the25,
        "26": the26,
        "107": the107,
        "150": the150,
        "165": the165,
        "265": the265,
        "267": the267,
        "1160": the1160,
        "2675": the2675,
        "2791": the2791,
        "21551": the21551,
        "24203": the24203,
        "24305": the24305,
        "29747": the29747,
        "44599": the44599,
        "44679": the44679,
        "44706": the44706,
        "44719": the44719,
        "44737": the44737,
        "44800": the44800,
        "45703": the45703,
        "45741": the45741,
        "46136": the46136,
        "47031": the47031,
        "47516": the47516,
        "53080": the53080,
        "53525": the53525,
        "54236": the54236,
        "54237": the54237,
        "55626": the55626,
        "55627": the55627,
        "55628": the55628,
        "57381": the57381,
        "57492": the57492,
        "71612": the71612,
        "yes": yes,
        "no": no,
    };

}

class FlatRate {
    FlatRate({
        required this.flatRate,
        required this.flatRate98,
        required this.flatRate100,
        required this.flatRate115,
    });

    final String? flatRate;
    final String? flatRate98;
    final String? flatRate100;
    final String? flatRate115;

    factory FlatRate.fromJson(Map<String, dynamic> json){ 
        return FlatRate(
            flatRate: json["flat_rate"],
            flatRate98: json["flat_rate:98"],
            flatRate100: json["flat_rate:100"],
            flatRate115: json["flat_rate:115"],
        );
    }

    Map<String, dynamic> toJson() => {
        "flat_rate": flatRate,
        "flat_rate:98": flatRate98,
        "flat_rate:100": flatRate100,
        "flat_rate:115": flatRate115,
    };

}

class FreeShipping {
    FreeShipping({
        required this.freeShipping,
        required this.freeShipping101,
        required this.freeShipping106,
        required this.freeShipping114,
    });

    final String? freeShipping;
    final String? freeShipping101;
    final String? freeShipping106;
    final String? freeShipping114;

    factory FreeShipping.fromJson(Map<String, dynamic> json){ 
        return FreeShipping(
            freeShipping: json["free_shipping"],
            freeShipping101: json["free_shipping:101"],
            freeShipping106: json["free_shipping:106"],
            freeShipping114: json["free_shipping:114"],
        );
    }

    Map<String, dynamic> toJson() => {
        "free_shipping": freeShipping,
        "free_shipping:101": freeShipping101,
        "free_shipping:106": freeShipping106,
        "free_shipping:114": freeShipping114,
    };

}

class LocalPickup {
    LocalPickup({
        required this.localPickup,
        required this.localPickup99,
        required this.localPickup103,
    });

    final String? localPickup;
    final String? localPickup99;
    final String? localPickup103;

    factory LocalPickup.fromJson(Map<String, dynamic> json){ 
        return LocalPickup(
            localPickup: json["local_pickup"],
            localPickup99: json["local_pickup:99"],
            localPickup103: json["local_pickup:103"],
        );
    }

    Map<String, dynamic> toJson() => {
        "local_pickup": localPickup,
        "local_pickup:99": localPickup99,
        "local_pickup:103": localPickup103,
    };

}

class Expiration {
    Expiration({
        required this.id,
        required this.label,
        required this.description,
        required this.type,
        required this.value,
        required this.expirationDefault,
        required this.tip,
        required this.placeholder,
    });

    final String? id;
    final String? label;
    final String? description;
    final String? type;
    final int? value;
    final int? expirationDefault;
    final String? tip;
    final String? placeholder;

    factory Expiration.fromJson(Map<String, dynamic> json){ 
        return Expiration(
            id: json["id"],
            label: json["label"],
            description: json["description"],
            type: json["type"],
            value: json["value"],
            expirationDefault: json["default"],
            tip: json["tip"],
            placeholder: json["placeholder"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "description": description,
        "type": type,
        "value": value,
        "default": expirationDefault,
        "tip": tip,
        "placeholder": placeholder,
    };

}

class PaymentRequestButtonLocations {
    PaymentRequestButtonLocations({
        required this.id,
        required this.label,
        required this.description,
        required this.type,
        required this.value,
        required this.paymentRequestButtonLocationsDefault,
        required this.tip,
        required this.placeholder,
        required this.options,
    });

    final String? id;
    final String? label;
    final String? description;
    final String? type;
    final List<String> value;
    final List<String> paymentRequestButtonLocationsDefault;
    final String? tip;
    final String? placeholder;
    final PaymentRequestButtonLocationsOptions? options;

    factory PaymentRequestButtonLocations.fromJson(Map<String, dynamic> json){ 
        return PaymentRequestButtonLocations(
            id: json["id"],
            label: json["label"],
            description: json["description"],
            type: json["type"],
            value: json["value"] == null ? [] : List<String>.from(json["value"]!.map((x) => x)),
            paymentRequestButtonLocationsDefault: json["default"] == null ? [] : List<String>.from(json["default"]!.map((x) => x)),
            tip: json["tip"],
            placeholder: json["placeholder"],
            options: json["options"] == null ? null : PaymentRequestButtonLocationsOptions.fromJson(json["options"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "description": description,
        "type": type,
        "value": value.map((x) => x).toList(),
        "default": paymentRequestButtonLocationsDefault.map((x) => x).toList(),
        "tip": tip,
        "placeholder": placeholder,
        "options": options?.toJson(),
    };

}

class PaymentRequestButtonLocationsOptions {
    PaymentRequestButtonLocationsOptions({
        required this.product,
        required this.cart,
        required this.checkout,
    });

    final String? product;
    final String? cart;
    final String? checkout;

    factory PaymentRequestButtonLocationsOptions.fromJson(Map<String, dynamic> json){ 
        return PaymentRequestButtonLocationsOptions(
            product: json["product"],
            cart: json["cart"],
            checkout: json["checkout"],
        );
    }

    Map<String, dynamic> toJson() => {
        "product": product,
        "cart": cart,
        "checkout": checkout,
    };

}
