package com.example.currencyapp.repository

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.currencyapp.database.dao.CurrencyDao
import com.example.currencyapp.database.entity.Currency
import com.example.currencyapp.network.service.CurrencyList
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch


class ListRepository(
        private val localData : CurrencyDao,
) {
    private val scope = CoroutineScope(Job() + Dispatchers.Main)


    fun getCurrencyListFromApi() : LiveData<List<Currency>> {
        val list: MutableLiveData<List<Currency>> = MutableLiveData()
        scope.launch {
            try {
                list.value = getLocalCurrencies()

            }catch (e : Throwable) {
                println("THROW $e")
            }
        }

        return list
    }

    private suspend fun getLocalCurrencies(): List<Currency> {
        try {
            return localData.getAllCurrencies()
        } catch (e: Throwable) {
            throw Exception(e)
        }
    }
}