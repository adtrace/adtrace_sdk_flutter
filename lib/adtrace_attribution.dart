//
//  Created by Aref Hosseini on 7th October 2019.
//

class AdTraceAttribution {
  String trackerToken;
  String trackerName;
  String network;
  String campaign;
  String adgroup;
  String creative;
  String clickLabel;
  String adid;

  static AdTraceAttribution fromMap(dynamic map) {
    AdTraceAttribution attribution = new AdTraceAttribution();
    try {
      attribution.trackerToken = map['trackerToken'];
      attribution.trackerName = map['trackerName'];
      attribution.network = map['network'];
      attribution.campaign = map['campaign'];
      attribution.adgroup = map['adgroup'];
      attribution.creative = map['creative'];
      attribution.clickLabel = map['clickLabel'];
      attribution.adid = map['adid'];
    } catch (e) {
      print('[AdTraceFlutter]: Failed to create AdTraceAttribution object from given map object. Details: ' + e.toString());
    }
    return attribution;
  }
}