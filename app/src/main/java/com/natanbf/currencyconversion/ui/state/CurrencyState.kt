package com.natanbf.currencyconversion.ui.state

data class CurrencyState(
    val isLoading: Boolean = false,
    val isError: String? = null,
    val valueFrom: String = String(),
    val valueTo: String = String(),
    val selectedTextFrom: String = String(),
    val selectedTextTo: String = String()
)