package com.natanbf.currencyconversion.di

import com.natanbf.currencyconversion.data.remote.RemoteDataSourceImpl
import com.natanbf.currencyconversion.data.remote.api.CurrencyConverterApi
import com.natanbf.currencyconversion.data.remote.RemoteDataSource
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton
@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {

    @Singleton
    @Provides
    fun provideCurrencyConverterApi(): CurrencyConverterApi = Retrofit.Builder()
        .baseUrl("https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/")
        .addConverterFactory(GsonConverterFactory.create())
        .build()
        .create(CurrencyConverterApi::class.java)


    @Singleton
    @Provides
    fun provideRemoteDataSource(api: CurrencyConverterApi): RemoteDataSource =
        RemoteDataSourceImpl(api)


//    @Singleton
//    @Provides
//    fun provide
}