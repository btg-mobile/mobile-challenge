package com.gft.data.mapper

import com.gft.data.model.CurrencyLabelModel
import com.gft.data.model.CurrencyListModel
import com.gft.domain.entities.CurrencyLabel
import com.gft.domain.entities.CurrencyList

class CurrencyDataEntityMapper constructor() {
    fun mapToEntity(data: CurrencyListModel?): CurrencyList? = CurrencyList(
        success = data?.success,
        terms = data?.terms,
        privacy = data?.privacy,
        currencies = mapCurrenciesToEntity(data?.currencies)
    )

    private fun mapCurrenciesToEntity(currencies: List<CurrencyLabelModel>?)
            : List<CurrencyLabel> = currencies?.map { mapArticleToEntity(it) } ?: emptyList()

    private fun mapArticleToEntity(response: CurrencyLabelModel): CurrencyLabel = CurrencyLabel(
        nome = response.nome,
        codigo = response.codigo
    )
}
