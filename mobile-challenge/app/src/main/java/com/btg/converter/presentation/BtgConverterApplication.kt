package com.btg.converter.presentation

import android.app.Application
import com.btg.converter.presentation.di.interactorModule
import com.btg.converter.presentation.di.networkingModule
import com.btg.converter.presentation.di.repositoryModule
import com.btg.converter.presentation.di.viewModelModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class BtgConverterApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@BtgConverterApplication)
            modules(
                listOf(
                    networkingModule(),
                    viewModelModule(),
                    repositoryModule(),
                    interactorModule()
                )
            )
        }
    }
}