package com.geocdias.convecurrency

import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity

object ExchangeRateFakeProvider {
    fun rateList(): List<ExchangeRateEntity> = listOf(
        ExchangeRateEntity(1, fromCurrency = "USD", toCurrency = "AED", rate =  3.672982),
        ExchangeRateEntity(2, fromCurrency = "USD", toCurrency = "AFN", rate =  57.8936),
        ExchangeRateEntity(3, fromCurrency = "USD", toCurrency = "ALL", rate =  126.1652),
        ExchangeRateEntity(4, fromCurrency = "USD", toCurrency = "AMD", rate =  475.306),
        ExchangeRateEntity(5, fromCurrency = "USD", toCurrency = "ANG", rate =  1.78952),
        ExchangeRateEntity(6, fromCurrency = "USD", toCurrency = "AOA", rate =  109.216875),
        ExchangeRateEntity(7, fromCurrency = "USD", toCurrency = "ARS", rate =  8.901966),
        ExchangeRateEntity(8, fromCurrency = "USD", toCurrency = "AUD", rate =  1.269072),
        ExchangeRateEntity(9, fromCurrency = "USD", toCurrency = "AWG", rate =  1.792375),
        ExchangeRateEntity(10, fromCurrency = "USD", toCurrency = "AZN", rate =  1.04945),
        ExchangeRateEntity(11, fromCurrency = "USD", toCurrency = "BAM", rate =  1.757305)
    )

}
