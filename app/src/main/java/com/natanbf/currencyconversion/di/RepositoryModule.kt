package com.natanbf.currencyconversion.di

import com.natanbf.currencyconversion.data.local.DataStoreCurrency
import com.natanbf.currencyconversion.data.repository.CurrencyConverterRepositoryImpl
import com.natanbf.currencyconversion.domain.repository.CurrencyConverterRepository
import com.natanbf.currencyconversion.data.remote.RemoteDataSource
import com.natanbf.currencyconversion.di.annotation.Dispatcher
import com.natanbf.currencyconversion.di.annotation.SelectDispatchers.IO
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import kotlinx.coroutines.CoroutineDispatcher

@Module
@InstallIn(SingletonComponent::class)
object RepositoryModule {

    @Provides
    fun provideCurrencyConverterRepository(
        remote: RemoteDataSource, dataStore: DataStoreCurrency,
        @Dispatcher(IO) coroutineDispatcher: CoroutineDispatcher
    ): CurrencyConverterRepository =
        CurrencyConverterRepositoryImpl(remote, dataStore, coroutineDispatcher)

}