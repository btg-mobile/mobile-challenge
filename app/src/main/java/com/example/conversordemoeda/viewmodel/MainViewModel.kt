package com.example.conversordemoeda.viewmodel

import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.ViewModel
import com.example.conversordemoeda.model.repositorio.MoedaRepository

class MainViewModel (moedaRepository: MoedaRepository): ViewModel(), LifecycleObserver {
}