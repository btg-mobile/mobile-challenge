package io.felipeandrade.currencylayertest.usecase

import io.felipeandrade.data.CurrencyRepository
import java.math.BigDecimal
import java.math.RoundingMode

class ConvertUseCase(private val currencyRepository: CurrencyRepository) {
    suspend operator fun invoke(origin: String, target: String, value: BigDecimal): BigDecimal {
        val quotes = currencyRepository.loadLiveCurrencies(origin, target)
        val factor = quotes[target]?.factor ?: throw Exception("quota not found")

        return (value * factor).setScale(2, RoundingMode.HALF_EVEN)
    }
}