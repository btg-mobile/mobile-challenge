package com.example.convertermoeda.ui.viewmodel.state

sealed class MainState {
    data class GetCoversao(val value: Double): MainState()
    data class IsErro(val error: String): MainState()
}