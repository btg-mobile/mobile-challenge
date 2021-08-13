package com.br.cambio.data.repository

import com.br.cambio.data.datasource.RemoteDataSource
import com.br.cambio.domain.mapper.PriceToPresentationMapper
import com.br.cambio.domain.repository.PricesRepository
import com.br.cambio.presentation.mapper.QuotaPresentation

class PricesRepositoryImpl(
    private val remoteDataSource: RemoteDataSource,
) : PricesRepository {

    private val mapper = PriceToPresentationMapper()

    override suspend fun getPrices(): QuotaPresentation {
        return mapper.map(remoteDataSource.getPrices())
    }
}