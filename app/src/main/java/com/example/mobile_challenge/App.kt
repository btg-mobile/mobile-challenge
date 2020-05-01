package com.example.mobile_challenge

import android.app.Application
import com.example.mobile_challenge.utility.ClientApi

class App: Application() {

    companion object {
        lateinit var instance: App

        val clientApi: ClientApi by lazy {
            ClientApi()
        }
    }

    override fun onCreate() {
        super.onCreate()
        instance = this
    }
}