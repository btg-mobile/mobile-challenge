package br.com.andreldsr.btgcurrencyconverter.mock

import br.com.andreldsr.btgcurrencyconverter.domain.repositories.QuoteRepository
import br.com.andreldsr.btgcurrencyconverter.infra.repositories.QuoteRepositoryImpl
import br.com.andreldsr.btgcurrencyconverter.infra.services.ApiService
import br.com.andreldsr.btgcurrencyconverter.infra.services.CurrencyService
import retrofit2.awaitResponse
import java.lang.Exception

class QuoteMockRepositoryImpl : QuoteRepository {
    override suspend fun getQuote(from: String, to: String): Float {
        val quoteMap = mapOf("USDUSD" to 1f, "USDBRL" to 5.63f, "USDCAD" to 1.32f, "USDAED" to 3.62f)
        val quoteFrom = quoteMap["$baseQuoteName$from"] ?: throw Exception()
        val quoteTo = quoteMap["$baseQuoteName$to"] ?: throw Exception()
        return quoteTo / quoteFrom;
    }

    companion object{
        const val baseQuoteName = "USD"
        fun build(): QuoteMockRepositoryImpl {
            return QuoteMockRepositoryImpl()
        }
    }

}