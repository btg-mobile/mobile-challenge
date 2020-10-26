package br.com.andreldsr.btgcurrencyconverter.domain.usecases

import br.com.andreldsr.btgcurrencyconverter.domain.repositories.QuoteRepository

interface GetQuote {
    suspend fun getQuote(from: String, to: String): Float
}

class GetQuoteFromUsdImpl(private val quoteRepository: QuoteRepository) : GetQuote{
    override suspend fun getQuote(from: String, to: String): Float {
        return quoteRepository.getQuote(from, to)
    }

}