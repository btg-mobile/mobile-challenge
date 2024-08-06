package com.natanbf.currencyconversion.di

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.preferencesDataStore
import com.natanbf.currencyconversion.data.local.DataStoreCurrency
import com.natanbf.currencyconversion.data.local.DataStoreCurrencyImpl
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "currency_ds")

@Module
@InstallIn(SingletonComponent::class)
object DataStoreModule {
    @Provides
    @Singleton
    fun provideDataStoreCurrency(@ApplicationContext context: Context): DataStoreCurrency =
        DataStoreCurrencyImpl(context.dataStore)
}