package com.gft.data.mapper

import com.gft.data.model.CurrencyLabelListModel
import com.gft.data.model.CurrencyValueListModel
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.CurrencyValueList

class CurrencyDataEntityMapper {
    fun mapToEntity(data: CurrencyLabelListModel?): CurrencyLabelList? = CurrencyLabelList(
        success = data?.success,
        terms = data?.terms,
        privacy = data?.privacy,
        currencies = data?.currencies
    )

    fun mapToEntity(data: CurrencyValueListModel?): CurrencyValueList? = CurrencyValueList(
        success = data?.success,
        terms = data?.terms,
        privacy = data?.privacy,
        source = data?.source,
        quotes = data?.quotes
    )
}
