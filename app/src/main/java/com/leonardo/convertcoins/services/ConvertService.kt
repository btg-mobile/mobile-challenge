package com.leonardo.convertcoins.services

import com.leonardo.convertcoins.models.Rate
import java.math.BigDecimal
import java.math.RoundingMode
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.util.*

class ConvertService {

    fun convert(haveRate: Rate, wantRate: Rate, toConvertValue: BigDecimal): BigDecimal {
        if (haveRate.value <= 0 || wantRate.value <= 0 || toConvertValue <= BigDecimal.ZERO)
            return BigDecimal.ZERO

        return toConvertValue.multiply((wantRate.value / haveRate.value).toBigDecimal()).setScale(4, RoundingMode.FLOOR)
    }

    fun getCurrentRate(coin: String, quotes: Map<String, Double>): Double {
        return quotes["USD$coin"]!!
    }

    fun getFormattedValue(convertedValue: BigDecimal): String {
        val otherSymbols = DecimalFormatSymbols(Locale.ROOT)
        otherSymbols.decimalSeparator = ','
        otherSymbols.groupingSeparator = '.'
        val df = DecimalFormat("#,##0.00", otherSymbols)
        return df.format(convertedValue)
    }

}