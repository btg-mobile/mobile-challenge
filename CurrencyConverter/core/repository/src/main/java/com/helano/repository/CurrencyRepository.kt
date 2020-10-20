package com.helano.repository

interface CurrencyRepository {

    suspend fun currencies(): Map<String, String>
}