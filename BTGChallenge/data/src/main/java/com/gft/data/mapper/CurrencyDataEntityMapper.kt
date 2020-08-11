package com.gft.data.mapper

import com.gft.data.model.CurrencyLabelModel
import com.gft.data.model.CurrencyLabelListModel
import com.gft.data.model.CurrencyValueListModel
import com.gft.data.model.CurrencyValueModel
import com.gft.domain.entities.CurrencyLabel
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValue
import com.gft.domain.entities.CurrencyValueList

class CurrencyDataEntityMapper constructor() {
    fun mapToEntity(data: CurrencyLabelListModel?): CurrencyLabelList? = CurrencyLabelList(
        success = data?.success,
        terms = data?.terms,
        privacy = data?.privacy,
        currencies = mapCurrenciesToEntity(data?.currencies)
    )

    private fun mapCurrenciesToEntity(currencies: List<CurrencyLabelModel>?)
            : List<CurrencyLabel> = currencies?.map { mapLabelToEntity(it) } ?: emptyList()

    private fun mapLabelToEntity(response: CurrencyLabelModel): CurrencyLabel = CurrencyLabel(
        nome = response.nome,
        codigo = response.codigo
    )

    fun mapToEntity(data: CurrencyValueListModel?): CurrencyValueList? = CurrencyValueList(
        success = data?.success,
        terms = data?.terms,
        privacy = data?.privacy,
        source = data?.source,
        quotes = mapQuotesToEntity(data?.quotes)
    )

    private fun mapQuotesToEntity(quotes: List<CurrencyValueModel>?)
            : List<CurrencyValue> = quotes?.map { mapValueToEntity(it) } ?: emptyList()

    private fun mapValueToEntity(response: CurrencyValueModel): CurrencyValue = CurrencyValue(
        moedas = response.moedas,
        valor = response.valor
    )
}
