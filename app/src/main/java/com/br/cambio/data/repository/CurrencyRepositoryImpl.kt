package com.br.cambio.data.repository

import com.br.cambio.data.datasource.RemoteDataSource
import com.br.cambio.domain.mapper.CurrencyToPresentationMapper
import com.br.cambio.domain.repository.CurrencyRepository
import com.br.cambio.presentation.mapper.ExchangePresentation

class CurrencyRepositoryImpl(
    private val remoteDataSource: RemoteDataSource,
) : CurrencyRepository {

    private val mapper = CurrencyToPresentationMapper()

    override suspend fun getCurrencies(): ExchangePresentation {
        return mapper.map(remoteDataSource.getCurrencies())
    }
}