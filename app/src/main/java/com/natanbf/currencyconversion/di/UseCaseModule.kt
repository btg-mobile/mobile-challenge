package com.natanbf.currencyconversion.di

import com.natanbf.currencyconversion.data.local.DataStoreCurrency
import com.natanbf.currencyconversion.di.annotation.Dispatcher
import com.natanbf.currencyconversion.di.annotation.SelectDispatchers.Default
import com.natanbf.currencyconversion.di.annotation.SelectDispatchers.IO
import com.natanbf.currencyconversion.domain.repository.CurrencyConverterRepository
import com.natanbf.currencyconversion.domain.usecase.ConvertedCurrencyUseCase
import com.natanbf.currencyconversion.domain.usecase.ConvertedCurrencyUseCaseImpl
import com.natanbf.currencyconversion.domain.usecase.GetCurrentQuoteUseCase
import com.natanbf.currencyconversion.domain.usecase.GetCurrentQuoteUseCaseImpl
import com.natanbf.currencyconversion.domain.usecase.GetExchangeRatesUseCase
import com.natanbf.currencyconversion.domain.usecase.GetExchangeRatesUseCaseImpl
import com.natanbf.currencyconversion.domain.usecase.GetFromToUseCase
import com.natanbf.currencyconversion.domain.usecase.GetFromToUseCaseImpl
import com.natanbf.currencyconversion.domain.usecase.SaveCurrencyUseCase
import com.natanbf.currencyconversion.domain.usecase.SaveCurrencyUseCaseImpl
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import kotlinx.coroutines.CoroutineDispatcher
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object UseCaseModule {

    @Provides
    @Singleton
    fun provideGetExchangeRatesUseCase(repository: CurrencyConverterRepository): GetExchangeRatesUseCase =
        GetExchangeRatesUseCaseImpl(repository)


    @Provides
    @Singleton
    fun provideGetCurrentQuoteUseCase(repository: CurrencyConverterRepository): GetCurrentQuoteUseCase =
        GetCurrentQuoteUseCaseImpl(repository)

    @Provides
    @Singleton
    fun provideGetFromToUseCase(repository: CurrencyConverterRepository): GetFromToUseCase =
        GetFromToUseCaseImpl(repository)

    @Provides
    @Singleton
    fun provideConvertedCurrencyUseCase(
        repository: CurrencyConverterRepository,
        @Dispatcher(Default) coroutineDispatcher: CoroutineDispatcher
    ): ConvertedCurrencyUseCase =
        ConvertedCurrencyUseCaseImpl(repository, coroutineDispatcher)

    @Provides
    @Singleton
    fun provideSaveCurrency(
        dataStore: DataStoreCurrency,
        @Dispatcher(IO) coroutineDispatcher: CoroutineDispatcher
    ): SaveCurrencyUseCase = SaveCurrencyUseCaseImpl(dataStore, coroutineDispatcher)

}