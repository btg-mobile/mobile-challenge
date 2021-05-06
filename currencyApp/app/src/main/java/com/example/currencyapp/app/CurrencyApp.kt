package com.example.currencyapp.app

import android.app.Application
import com.example.currencyapp.di.currencyListModule
import com.example.currencyapp.di.currencyLiveModule
import com.example.currencyapp.di.networkModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class CurrencyApp : Application() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@CurrencyApp)
            modules(
                listOf(
                    networkModule,
                    currencyListModule,
                    currencyLiveModule
                )
            )
        }
    }
}