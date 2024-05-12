class AdTracePlayStorePurchase {
  String? productId;
  String? purchaseToken;

  AdTracePlayStorePurchase(this.productId, this.purchaseToken);

  Map<String, String?> get toMap {
    Map<String, String?> purchaseMap = new Map<String, String?>();

    if (productId != null) {
      purchaseMap['productId'] = productId;
    }
    if (purchaseToken != null) {
      purchaseMap['purchaseToken'] = purchaseToken;
    }

    return purchaseMap;
  }
}
