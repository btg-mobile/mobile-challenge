package com.rafao1991.mobilechallenge.moneyexchange.data.reposiroty

import com.rafao1991.mobilechallenge.moneyexchange.data.local.dao.CurrencyDAO
import com.rafao1991.mobilechallenge.moneyexchange.data.local.dao.SelectedCurrencyDAO
import com.rafao1991.mobilechallenge.moneyexchange.data.local.entity.CurrencyEntity
import com.rafao1991.mobilechallenge.moneyexchange.data.local.entity.SelectedCurrencyEntity
import com.rafao1991.mobilechallenge.moneyexchange.data.remote.CurrencyApi
import com.rafao1991.mobilechallenge.moneyexchange.util.Currency
import kotlinx.coroutines.flow.*

class CurrencyRepository(
    private val currencyDAO: CurrencyDAO,
    private val selectedCurrencyDAO: SelectedCurrencyDAO
) {
    private val api = CurrencyApi.service

    fun getCurrenciesFromRemote(): Flow<Map<String, String>> {
        return flow {
            getFromApi()
        }
    }

    fun getCurrencies(): Flow<Map<String, String>> {
        return currencyDAO.getCurrencies().map {
            fromEntity(it)
        }
    }

    private suspend fun fromEntity(currencies: List<CurrencyEntity>): Map<String, String> {
        return if (currencies.isNotEmpty()) {
            val result = HashMap<String, String>()
            currencies.forEach { entry ->
                result[entry.id] = entry.name
            }
            result
        } else {
            getFromApi()
        }
    }

    private suspend fun getFromApi(): Map<String, String> {
        val currencies = api.getList().currencies

        currencies.forEach { (id, name) ->
            currencyDAO.insert(CurrencyEntity(id, name))
        }

        return currencies
    }

    suspend fun setSelectedCurrency(id: String, type: Currency, name: String) {
        selectedCurrencyDAO.deleteSelectedCurrency(type)
        selectedCurrencyDAO.insert(SelectedCurrencyEntity(id, type, name))
    }

    suspend fun getSelectedCurrency(type: Currency): String {
        return selectedCurrencyDAO.getSelectedCurrency(type)
    }
}