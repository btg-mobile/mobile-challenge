package com.br.cambio.data.mapper

import com.br.cambio.data.model.Currency
import com.br.cambio.domain.model.CurrencyDomain
import com.br.cambio.utils.Mapper

class CurrencyToDomainMapper : Mapper<Currency, CurrencyDomain> {

    override fun map(source: Currency): CurrencyDomain {
        return CurrencyDomain(
            symbol = source.key.orEmpty(),
            name = source.value.orEmpty()
        )
    }
}