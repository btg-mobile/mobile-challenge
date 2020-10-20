package com.helano.repository.data

import com.helano.network.responses.CurrenciesResponse
import com.helano.network.responses.QuotesResponse
import com.helano.network.services.CurrencyLayerService
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class RemoteDataSource @Inject constructor(private val service: CurrencyLayerService) {

    suspend fun currencies() : CurrenciesResponse {
        return service.list("a7422a6feb33438eb81bf5d341977c4c")
    }

    suspend fun quotes() : QuotesResponse {
        return service.live("a7422a6feb33438eb81bf5d341977c4c")
    }
}