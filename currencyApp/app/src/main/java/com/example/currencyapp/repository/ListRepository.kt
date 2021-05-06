package com.example.currencyapp.repository

import com.example.currencyapp.network.service.CurrencyList
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch


class ListRepository(
    private val remoteCurrencyList : CurrencyList,
) {
    private val scope = CoroutineScope(Job() + Dispatchers.Main)


    fun getCurrencyListFromApi() {
        scope.launch {
            try {
                val currencyListData = remoteCurrencyList.getCurrencyList()

                if(currencyListData.isSuccessful) {
                    // a chamada pode ser de sucesso mas dar erro no body
                    val currencies = currencyListData.body()?.currencies
                    val typeKeys : MutableList<String> = mutableListOf()
                    val currencyList : MutableList<Map<String, String?>> = mutableListOf()

                    currencies.let {
                        typeKeys.addAll(it!!.keys.toList())

                        for (key in typeKeys){
                            currencyList.add(mapOf(key to it[key]))
                        }
                    }

                    println("list $currencyList")
                }


            }catch (e : Throwable) {
                println("THROW $e")
            }
        }
    }
}