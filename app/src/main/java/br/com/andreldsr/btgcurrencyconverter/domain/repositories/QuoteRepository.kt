package br.com.andreldsr.btgcurrencyconverter.domain.repositories

interface QuoteRepository {
    suspend fun getQuote(from: String, to: String): Float
}