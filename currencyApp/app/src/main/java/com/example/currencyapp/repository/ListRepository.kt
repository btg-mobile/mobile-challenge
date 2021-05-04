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
        println("Chamou pelo menos")
        scope.launch {
            try {
                val currencyListData = remoteCurrencyList.getCurrencyList()

                if(currencyListData.isSuccessful){
                    val currencies = currencyListData.body()?.currencies
                    val typeKeys : MutableList<String> = mutableListOf()

                    currencies.let {
                        typeKeys.addAll(it!!.keys.toList())
                    }

                    println("typekeys $typeKeys")
                }


            }catch (e : Throwable) {
                println("THROW $e")
            }
        }
    }
}