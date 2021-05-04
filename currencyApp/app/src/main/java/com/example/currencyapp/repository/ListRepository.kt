package com.example.currencyapp.repository

import com.example.currencyapp.network.service.CurrencyList
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch


class ListRepository(
    private val remoteCurrencyList : CurrencyList,
) {
    val scope = CoroutineScope(Job() + Dispatchers.Main)


    private fun getCurrencyListFromApi() {
        scope.launch {
            try {
                val currencyListData = remoteCurrencyList.getCurrencyList()

                if(currencyListData.isSuccessful){
                    val currencies = currencyListData.body()?.currencies
                    val typeKeys : MutableList<String> = mutableListOf()

                    currencies.let {
                        typeKeys.addAll(it!!.keys.toList())
                    }

                    print("typekeys $typeKeys")
                }


            }catch (e : Throwable) {
                print("THROW $e")
            }
        }
    }
}