//
//  Created by Aref Hosseini on 7th October 2019.
//

package io.adtrace.sdk.flutter;

import java.text.NumberFormat;
import java.text.ParsePosition;

public class AdTraceUtils {
    private static NumberFormat numberFormat = NumberFormat.getInstance();

    public static boolean isNumber(String numberString) {
        if (numberString == null) {
            return false;
        }
        if (numberString.length() == 0) {
            return false;
        }

        ParsePosition position = new ParsePosition(0);
        numberFormat.parse(numberString, position);
        return numberString.length() == position.getIndex();
    }
}