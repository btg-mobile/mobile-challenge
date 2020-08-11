package com.gft.domain.usecases

import com.gft.domain.repository.CurrencyRepository

class Convert(private val repository: CurrencyRepository) {
    suspend operator fun invoke(from: String, to: String, value: Double) =
    repository.convert(from, to, value)
}