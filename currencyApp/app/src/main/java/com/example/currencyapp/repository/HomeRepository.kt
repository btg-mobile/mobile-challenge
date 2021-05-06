package com.example.currencyapp.repository

import com.example.currencyapp.network.service.CurrencyLive
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class HomeRepository(private val remoteCurrencyLive: CurrencyLive) {
    private val scope = CoroutineScope(Job() + Dispatchers.Main)


    fun getCurrencyLiveFromApi() {
        scope.launch {
            try {
                val currencyLive = remoteCurrencyLive.getCurrencyLive()

                if(currencyLive.isSuccessful) {
                    // a chamada pode ser de sucesso mas dar erro no body
                    val currencies = currencyLive.body()?.quotes
                    val currencyKeys : MutableList<String> = mutableListOf()
                    val currencyLiveList : MutableList<Map<String, Double?>> = mutableListOf()

                    currencies?.let {
                        currencyKeys.addAll(it.keys.toList())

                        for(key in currencyKeys)
                            currencyLiveList.add(mapOf(key.substring(key.length/2) to it[key]))
                    }

                    println("list $currencyLiveList")
                }
            }catch (e : Throwable) {
                println("THROW $e")
            }
        }
    }
}