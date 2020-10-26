package br.com.andreldsr.btgcurrencyconverter.infra.repositories

import br.com.andreldsr.btgcurrencyconverter.domain.repositories.QuoteRepository
import br.com.andreldsr.btgcurrencyconverter.infra.services.ApiService
import br.com.andreldsr.btgcurrencyconverter.infra.services.CurrencyService
import retrofit2.awaitResponse
import java.lang.Exception

class QuoteRepositoryImpl(private val currencyService: CurrencyService) : QuoteRepository {
    override suspend fun getQuote(from: String, to: String): Float {
        val response = currencyService.getQuote().awaitResponse()
        if (!response.isSuccessful)
            throw Exception()
        val quoteMap = response.body()?.quotes
        val quoteFrom = quoteMap?.get("$baseQuoteName$from")?.toFloat() ?: throw Exception()
        val quoteTo = quoteMap["$baseQuoteName$to"]?.toFloat() ?: throw Exception()
        return quoteTo / quoteFrom;
    }

    companion object {
        private val baseQuoteName = "USD"
        fun build(): QuoteRepositoryImpl {
            return QuoteRepositoryImpl(ApiService.service)
        }
    }
}