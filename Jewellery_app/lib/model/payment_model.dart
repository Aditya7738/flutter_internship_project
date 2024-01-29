class PaymentModel {
    PaymentModel({
        required this.id,
        required this.entity,
        required this.amount,
        required this.amountPaid,
        required this.amountDue,
        required this.currency,
        required this.receipt,
        required this.offerId,
        required this.status,
        required this.attempts,
        required this.notes,
        required this.createdAt,
    });

    final String? id;
    final String? entity;
    final int? amount;
    final int? amountPaid;
    final int? amountDue;
    final String? currency;
    final String? receipt;
    final dynamic offerId;
    final String? status;
    final int? attempts;
    final List<dynamic> notes;
    final int? createdAt;

    factory PaymentModel.fromJson(Map<String, dynamic> json){ 
        return PaymentModel(
            id: json["id"],
            entity: json["entity"],
            amount: json["amount"],
            amountPaid: json["amount_paid"],
            amountDue: json["amount_due"],
            currency: json["currency"],
            receipt: json["receipt"],
            offerId: json["offer_id"],
            status: json["status"],
            attempts: json["attempts"],
            notes: json["notes"] == null ? [] : List<dynamic>.from(json["notes"]!.map((x) => x)),
            createdAt: json["created_at"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "entity": entity,
        "amount": amount,
        "amount_paid": amountPaid,
        "amount_due": amountDue,
        "currency": currency,
        "receipt": receipt,
        "offer_id": offerId,
        "status": status,
        "attempts": attempts,
        "notes": notes.map((x) => x).toList(),
        "created_at": createdAt,
    };

}
