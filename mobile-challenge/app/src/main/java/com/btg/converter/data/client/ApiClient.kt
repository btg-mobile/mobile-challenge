package com.btg.converter.data.client

import com.btg.converter.data.entity.ApiCurrencyList
import com.btg.converter.data.entity.ApiCurrentQuotes
import com.btg.converter.data.util.request.RequestHandler

class ApiClient constructor(
    private val apiService: ApiService
) : RequestHandler() {

    suspend fun getCurrencyList(): ApiCurrencyList? {
        return makeRequest(apiService.getCurrencyList())
    }

    suspend fun getCurrentQuotes(): ApiCurrentQuotes? {
        return makeRequest(apiService.getCurrentQuotes())
    }
}