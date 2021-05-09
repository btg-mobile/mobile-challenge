package com.geocdias.convecurrency.di

import com.geocdias.convecurrency.data.database.dao.CurrencyDao
import com.geocdias.convecurrency.data.database.dao.ExchangeRateDao
import com.geocdias.convecurrency.data.network.CurrencyClient
import com.geocdias.convecurrency.repository.CurrencyRepository
import com.geocdias.convecurrency.repository.CurrencyRepositoryImpl
import com.geocdias.convecurrency.util.*
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Singleton
    @Provides
    fun provideCurrencyRepository(currencyDao: CurrencyDao, exchangeRateDao: ExchangeRateDao, currencyClient: CurrencyClient, mapper: CurrencyMapper): CurrencyRepository =
        CurrencyRepositoryImpl(currencyDao, exchangeRateDao, currencyClient, mapper)

    @Provides
    fun providesDispachers(): DispacherProvider = object : DispacherProvider {
        override val main: CoroutineDispatcher
            get() = Dispatchers.Main
        override val io: CoroutineDispatcher
            get() = Dispatchers.IO
        override val default: CoroutineDispatcher
            get() = Dispatchers.Default
        override val unconfined: CoroutineDispatcher
            get() = Dispatchers.Unconfined
    }

    @Provides
    fun provideCurrencyMapper(): CurrencyMapper =
        CurrencyMapper(RemoteCurrencyListToDb(), RemoteExchangeRateToDb(), CurrencyEntityToModel(), ExchangeRateEntityToModel())
}
