package com.fernando.currencyexchange.di

import com.fernando.currencyexchange.data.api.CurrencyExchangeService
import com.fernando.currencyexchange.data.datasource.CurrencyExchangeRemoteDataSource
import com.fernando.currencyexchange.data.datasource.CurrencyExchangeRemoteDataSourceContract
import com.fernando.currencyexchange.domain.repository.CurrencyExchangeRepository
import com.fernando.currencyexchange.domain.repository.CurrencyExchangeRepositoryContract
import com.fernando.currencyexchange.domain.usecase.CurrencyExchangeUseCase
import com.fernando.currencyexchange.domain.usecase.CurrencyExchangeUseCaseContract
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import retrofit2.Retrofit
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
class CurrencyExchangeModule {
    @Provides
    @Singleton
    fun provideCurrencyExchangeService(retrofit: Retrofit): CurrencyExchangeService =
        retrofit.create(CurrencyExchangeService::class.java)

    @Provides
    @Singleton
    fun provideCurrencyExchangeRemoteDataSourceContract(currencyExchangeRemoteDataSourceContract: CurrencyExchangeRemoteDataSource): CurrencyExchangeRemoteDataSourceContract =
        currencyExchangeRemoteDataSourceContract

    @Provides
    @Singleton
    fun provideCurrencyExchangeRepositoryContract(currencyExchangeRepositoryContract: CurrencyExchangeRepository): CurrencyExchangeRepositoryContract =
        currencyExchangeRepositoryContract

    @Provides
    @Singleton
    fun provideCurrencyExchangeUseCaseContract(currencyExchangeUseCase: CurrencyExchangeUseCase): CurrencyExchangeUseCaseContract =
        currencyExchangeUseCase
}