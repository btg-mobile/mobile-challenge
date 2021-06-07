package br.com.vicentec12.mobilechallengebtg.data.source.remote.dto

import br.com.vicentec12.mobilechallengebtg.data.model.Currency

data class CurrenciesDto(
    val success: Boolean = false,
    val currencies: Map<String, String> = mapOf()
) {

    fun toCurrencyList(): List<Currency> {
        val currencies = ArrayList<Currency>()
        var mId = 1L
        this.currencies.forEach { (mCode, mName) ->
            currencies.add(Currency(mId, mName, mCode))
            mId++
        }
        return currencies
    }

}