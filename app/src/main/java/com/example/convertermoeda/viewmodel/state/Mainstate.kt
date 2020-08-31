package com.example.convertermoeda.viewmodel.state

sealed class MainState {
    data class IsErro(val error: String): MainState()
}