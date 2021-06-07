package br.com.vicentec12.mobilechallengebtg

import android.app.Application
import br.com.vicentec12.mobilechallengebtg.di.AppComponent
import br.com.vicentec12.mobilechallengebtg.di.DaggerAppComponent

class CurrencyApp : Application() {

    lateinit var mAppComponent: AppComponent

    override fun onCreate() {
        super.onCreate()
        mAppComponent = DaggerAppComponent.factory().create(this)
    }

}