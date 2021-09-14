package com.rafao1991.mobilechallenge.moneyexchange.data.reposiroty

import com.rafao1991.mobilechallenge.moneyexchange.data.local.dao.QuoteDAO
import com.rafao1991.mobilechallenge.moneyexchange.data.local.entity.QuoteEntity
import com.rafao1991.mobilechallenge.moneyexchange.data.remote.CurrencyApi
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.map

class QuoteRepository(private val quoteDAO: QuoteDAO) {
    private val api = CurrencyApi.service

    fun getQuotesFromRemote(): Flow<Map<String, Double>> {
        return flow {
            getFromApi()
        }
    }

    fun getQuotes(): Flow<Map<String, Double>> {
        return quoteDAO.getQuotes().map {
            fromEntity(it)
        }
    }

    private suspend fun fromEntity(quotes: List<QuoteEntity>): Map<String, Double> {
        return if (quotes.isNotEmpty()) {
            val result = HashMap<String, Double>()
            quotes.forEach { entry ->
                result[entry.id] = entry.quote
            }
            result
        } else {
            getFromApi()
        }
    }

    private suspend fun getFromApi(): Map<String, Double> {
        val quotes = api.getLiveQuotes().quotes
        quotes.forEach { (id, quote) ->
            quoteDAO.insert(QuoteEntity(id, quote))
        }
        return quotes
    }
}