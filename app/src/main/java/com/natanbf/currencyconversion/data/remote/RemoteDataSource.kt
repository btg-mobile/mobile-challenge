package com.natanbf.currencyconversion.data.remote

import com.natanbf.currencyconversion.domain.model.CurrentQuoteResponse
import com.natanbf.currencyconversion.domain.model.ExchangeRatesResponse
import com.natanbf.currencyconversion.util.Resource

interface RemoteDataSource {
    suspend fun getRemoteExchangeRates(): Resource<ExchangeRatesResponse>
    suspend fun getRemoteCurrentQuote(): Resource<CurrentQuoteResponse>
}