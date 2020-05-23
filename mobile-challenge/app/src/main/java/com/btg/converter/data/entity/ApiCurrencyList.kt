package com.btg.converter.data.entity

import com.btg.converter.domain.entity.currency.Currency
import com.btg.converter.domain.entity.currency.CurrencyList
import com.google.gson.annotations.SerializedName

data class ApiCurrencyList(
    @SerializedName("success") val success: Boolean,
    @SerializedName("terms") val terms: String,
    @SerializedName("privacy") val privacy: String,
    @SerializedName("currencies") val currencies: HashMap<String, String>
) {

    fun toDomainObject(): CurrencyList {
        return CurrencyList(
            success = success,
            terms = terms,
            privacy = privacy,
            currencies = currencies
                .map { Currency(code = it.key, name = it.value) }
                .sortedBy { it.name }
        )
    }
}