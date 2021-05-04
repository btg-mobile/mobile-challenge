package com.leonardo.convertcoins.services

import com.leonardo.convertcoins.models.Rate
import java.math.BigDecimal
import java.math.RoundingMode

class ConvertService {

    fun convert(haveRate: Rate, wantRate: Rate, toConvertValue: BigDecimal): BigDecimal {
        if (haveRate.value <= 0 || wantRate.value <= 0 || toConvertValue <= BigDecimal.ZERO)
            return BigDecimal.ZERO

        return toConvertValue.multiply((wantRate.value / haveRate.value).toBigDecimal()).setScale(2, RoundingMode.FLOOR)
    }

    fun getCurrentRate(coin: String, quotes: Map<String, Double>): Double {
        return quotes["USD$coin"]!!
    }
}