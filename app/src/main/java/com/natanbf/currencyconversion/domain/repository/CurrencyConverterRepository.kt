package com.natanbf.currencyconversion.domain.repository

import com.natanbf.currencyconversion.domain.model.CurrencyModel
import kotlinx.coroutines.flow.Flow

interface CurrencyConverterRepository {
    val getExchangeRates: Flow<CurrencyModel>
    val getCurrentQuote: Flow<CurrencyModel>
    val getFromTo: Flow<CurrencyModel>
}