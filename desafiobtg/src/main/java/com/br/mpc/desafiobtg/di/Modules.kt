package com.br.mpc.desafiobtg.di

import com.br.mpc.desafiobtg.StateViewModel
import com.br.mpc.desafiobtg.repository.CurrencyLayerAPI
import com.br.mpc.desafiobtg.ui.MainViewModel
import com.br.mpc.desafiobtg.utils.RetrofitUtil
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val serviceModule = module {
    factory { RetrofitUtil.createService(CurrencyLayerAPI::class.java) }
    viewModel { MainViewModel() }
}