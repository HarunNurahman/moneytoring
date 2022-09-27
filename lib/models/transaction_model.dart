class TransactionModel {
  TransactionModel({
    this.idTransaction,
    this.idUser,
    this.type,
    this.date,
    this.total,
    this.detail,
    this.createdAt,
    this.updatedAt,
  });

  String? idTransaction;
  String? idUser;
  String? type;
  String? date;
  String? total;
  String? detail;
  String? createdAt;
  String? updatedAt;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        idTransaction: json["id_transaction"],
        idUser: json["id_user"],
        type: json["type"],
        date: json["date"],
        total: json["total"],
        detail: json["detail"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_transaction": idTransaction,
        "id_user": idUser,
        "type": type,
        "date": date,
        "total": total,
        "detail": detail,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
