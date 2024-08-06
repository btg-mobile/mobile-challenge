package com.natanbf.currencyconversion.ui.event

sealed interface CurrencyEvent {
    data object Initial : CurrencyEvent
    data class ConvertedCurrency(
        val amount: String?
    ) : CurrencyEvent
}