package com.a.coinmaster.di

import com.a.coinmaster.view.MainActivity
import dagger.Component

@Component(modules = [CoinMasterModule::class])
interface CoinMasterComponent {
    fun injectMainActivity(mainActivity: MainActivity)
}