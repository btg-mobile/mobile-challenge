@file:JvmName("Providers")
package com.example.convertermoeda.provider

import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProviders
import com.example.convertermoeda.repository.ListaMoedasRepository
import com.example.convertermoeda.retrofit.AppRetrofit
import com.example.convertermoeda.retrofit.service.ServiceApi
import com.example.convertermoeda.repository.MainRepository
import com.example.convertermoeda.usecase.ListaMoedasUseCase
import com.example.convertermoeda.usecase.MainUseCase
import com.example.convertermoeda.ui.viewmodel.ListaMoedasViewModel
import com.example.convertermoeda.ui.viewmodel.MainViewModel

fun providerMainViewModel(activity: AppCompatActivity): MainViewModel =
    ViewModelProviders.of(activity).get(MainViewModel::class.java)

fun providerListaMoedasViewModel(activity: AppCompatActivity): ListaMoedasViewModel =
    ViewModelProviders.of(activity).get(ListaMoedasViewModel::class.java)

fun providerApi(): ServiceApi =
    AppRetrofit.service

fun providerMainUseCase(): MainUseCase =
    MainUseCase(MainRepository())

fun providerListaMoedasUseCase(): ListaMoedasUseCase =
    ListaMoedasUseCase(ListaMoedasRepository())