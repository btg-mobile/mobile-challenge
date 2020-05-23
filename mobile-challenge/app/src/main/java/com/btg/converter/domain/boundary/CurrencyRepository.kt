package com.btg.converter.domain.boundary

import com.btg.converter.domain.entity.currency.CurrencyList
import com.btg.converter.domain.entity.quote.CurrentQuotes

interface CurrencyRepository {

    suspend fun getCurrencyList(): CurrencyList?
    suspend fun getCurrentQuotes(): CurrentQuotes?
}