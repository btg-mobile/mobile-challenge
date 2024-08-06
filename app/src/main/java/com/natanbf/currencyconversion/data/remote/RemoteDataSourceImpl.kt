package com.natanbf.currencyconversion.data.remote

import com.natanbf.currencyconversion.data.remote.api.CurrencyConverterApi
import com.natanbf.currencyconversion.domain.model.CurrentQuoteResponse
import com.natanbf.currencyconversion.domain.model.ExchangeRatesResponse
import com.natanbf.currencyconversion.util.Constant.ERROR_NETWORK
import com.natanbf.currencyconversion.util.Resource
import javax.inject.Inject

internal class RemoteDataSourceImpl @Inject constructor(private val api: CurrencyConverterApi) :
    RemoteDataSource {
    override suspend fun getRemoteExchangeRates(): Resource<ExchangeRatesResponse> {
        return try {
            val response = api.getExchangeRates()
            if (response.success) {
                Resource.Success(response)
            } else {
                Resource.Error(message = ERROR_NETWORK)
            }
        } catch (e: Exception) {
            Resource.Error(message = e.message ?: ERROR_NETWORK)
        }
    }

    override suspend fun getRemoteCurrentQuote(): Resource<CurrentQuoteResponse> {
        return try {
            val response = api.getCurrentQuote()
            response.success?.let {
                if (it) Resource.Success(response)
                else Resource.Error(ERROR_NETWORK)
            } ?: Resource.Error(ERROR_NETWORK)
        } catch (e: Exception) {
            Resource.Error(message = e.message ?: ERROR_NETWORK)
        }
    }

}