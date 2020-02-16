package io.felipeandrade.currencylayertest.usecase

import io.felipeandrade.data.CurrencyRepository
import java.util.*

class LoadSupportedCurrenciesUseCase(private val currencyRepository: CurrencyRepository) {
    suspend operator fun invoke(): List<Currency> = currencyRepository.loadAll()
}