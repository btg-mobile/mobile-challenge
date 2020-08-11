package com.gft.domain.usecases

import com.gft.domain.repository.CurrencyRepository

class GetAllLabels(private val repository: CurrencyRepository) {
    suspend operator fun invoke() = repository.getAllLabels()
}