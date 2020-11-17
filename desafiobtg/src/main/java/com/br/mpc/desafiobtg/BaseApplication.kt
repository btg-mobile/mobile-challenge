package com.br.mpc.desafiobtg

import android.app.Application
import com.br.mpc.desafiobtg.di.serviceModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.loadKoinModules
import org.koin.core.context.startKoin
import org.koin.core.context.unloadKoinModules

class BaseApplication: Application() {
    private val modules by lazy {
        listOf(serviceModule)
    }
    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@BaseApplication)
            loadKoinModules(modules)
        }
    }

    override fun onTerminate() {
        super.onTerminate()
        unloadKoinModules(modules)
    }
}