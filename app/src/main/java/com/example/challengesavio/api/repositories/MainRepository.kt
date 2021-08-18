package com.example.challengesavio.api.repositories

import com.example.challengesavio.api.services.RetrofitService

class MainRepository constructor(private val retrofitService: RetrofitService) {

    fun getAllCurrencies() = retrofitService.searchCurrencies()
    fun getAllQuotes() = retrofitService.searchQuotes()
}