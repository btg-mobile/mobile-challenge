package com.helano.network.repositories

import com.helano.network.services.CurrencyLayerService
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class Repository @Inject constructor(private val service: CurrencyLayerService) {

    suspend fun currencies() {
        service.list("a7422a6feb33438eb81bf5d341977c4c")
    }

    suspend fun quotes() {
        service.live("a7422a6feb33438eb81bf5d341977c4c")
    }
}