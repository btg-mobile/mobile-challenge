package com.natanbf.currencyconversion.di

import com.natanbf.currencyconversion.di.annotation.Dispatcher
import com.natanbf.currencyconversion.di.annotation.SelectDispatchers.IO
import com.natanbf.currencyconversion.di.annotation.SelectDispatchers.Main
import com.natanbf.currencyconversion.di.annotation.SelectDispatchers.Default
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

@Module
@InstallIn(SingletonComponent::class)
object DispatchersModule {

    @Provides
    @Dispatcher(IO)
    fun providesIODispatcher(): CoroutineDispatcher = Dispatchers.IO

    @Provides
    @Dispatcher(Main)
    fun providesMainDispatcher(): CoroutineDispatcher = Dispatchers.Main

    @Provides
    @Dispatcher(Default)
    fun providesDefaultDispatcher(): CoroutineDispatcher = Dispatchers.Default

}