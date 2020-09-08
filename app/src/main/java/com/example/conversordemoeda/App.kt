package com.example.conversordemoeda

import android.app.Application
import com.example.conversordemoeda.di.BASE_URL
import com.example.conversordemoeda.di.setUpDI

class App: Application() {

    override fun onCreate() {
        super.onCreate()
        BASE_URL = getUrlBase()
        setUpDI()
    }

    private fun getUrlBase() = BuildConfig.BASE_URL
}