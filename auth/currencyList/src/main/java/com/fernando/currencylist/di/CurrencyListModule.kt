package com.fernando.currencylist.di

import com.fernando.currencylist.data.api.CurrencyListService
import com.fernando.currencylist.data.datasource.CurrencyListRemoteDataSource
import com.fernando.currencylist.data.datasource.CurrencyListRemoteDataSourceContract
import com.fernando.currencylist.domain.repository.CurrencyListRepository
import com.fernando.currencylist.domain.repository.CurrencyListRepositoryContract
import com.fernando.currencylist.domain.usecase.CurrencyListUseCase
import com.fernando.currencylist.domain.usecase.CurrencyListUseCaseContract
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import retrofit2.Retrofit
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
class CurrencyListModule {
    @Provides
    @Singleton
    fun provideCurrencyListService(retrofit: Retrofit): CurrencyListService =
        retrofit.create(CurrencyListService::class.java)

    @Provides
    @Singleton
    fun provideCurrencyListRemoteDataSourceContract(currencyListRemoteDataSourceContract: CurrencyListRemoteDataSource): CurrencyListRemoteDataSourceContract =
        currencyListRemoteDataSourceContract

    @Provides
    @Singleton
    fun provideCurrencyListRepositoryContract(currencyListRepositoryContract: CurrencyListRepository): CurrencyListRepositoryContract =
        currencyListRepositoryContract

    @Provides
    @Singleton
    fun provideCurrencyListUseCaseContract(currencyListUseCase: CurrencyListUseCase): CurrencyListUseCaseContract =
        currencyListUseCase
}