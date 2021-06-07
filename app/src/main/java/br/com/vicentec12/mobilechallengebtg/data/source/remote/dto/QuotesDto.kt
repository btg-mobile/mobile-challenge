package br.com.vicentec12.mobilechallengebtg.data.source.remote.dto

import br.com.vicentec12.mobilechallengebtg.data.model.Quote

data class QuotesDto(
    val success: Boolean = false,
    val source: String = "",
    val quotes: Map<String, Double> = mapOf()
) {

    fun toQuoteList(): List<Quote> {
        val quotes = ArrayList<Quote>()
        this.quotes.forEach { (mCode, mValue) ->
            quotes.add(Quote(mCode, this.source, mValue))
        }
        return quotes
    }

}