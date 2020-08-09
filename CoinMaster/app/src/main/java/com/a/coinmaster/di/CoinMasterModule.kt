package com.a.coinmaster.di

import com.a.coinmaster.api.CoinMasterApi
import com.a.coinmaster.api.retrofit.RetrofitConfig
import dagger.Module
import dagger.Provides

@Module
class CoinMasterModule {
    @Provides
    fun providesServiceApi(): CoinMasterApi = RetrofitConfig()
        .getServiceApi(CoinMasterApi::class.java)
}