package com.leonardo.convertcoins.services

import com.leonardo.convertcoins.models.Rate
import java.math.RoundingMode

class ConvertService {

    fun convert(haveRate: Rate, wantRate: Rate, toConvertValue: Double): Double {
        if (haveRate.value < 0 || wantRate.value < 0 || toConvertValue <= 0)
            return 0.0
        println(wantRate)
        println(haveRate)

        return ((wantRate.value / haveRate.value) * toConvertValue).toBigDecimal().setScale(2, RoundingMode.FLOOR).toDouble()
    }

    fun getCurrentRate(coin: String, quotes: Map<String, Double>): Double {
        return quotes["USD$coin"]!!
    }
}