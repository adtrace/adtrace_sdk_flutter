class AdTraceAppStorePurchase {
  String? receipt;
  String? productId;
  String? transactionId;

  AdTraceAppStorePurchase(this.receipt, this.productId, this.transactionId);

  Map<String, String?> get toMap {
    Map<String, String?> purchaseMap = new Map<String, String?>();

    if (receipt != null) {
      purchaseMap['receipt'] = receipt;
    }
    if (productId != null) {
      purchaseMap['productId'] = productId;
    }
    if (transactionId != null) {
      purchaseMap['transactionId'] = transactionId;
    }

    return purchaseMap;
  }
}
