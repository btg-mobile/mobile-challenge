package com.natanbf.currencyconversion.ui.event

sealed interface CurrencyListEvent {
    data class SaveCurrency(val selected: String) : CurrencyListEvent
    data class UpdateQuery(val query: String) : CurrencyListEvent
    data class SetActive(val active: Boolean) : CurrencyListEvent
    data object OnNavigation : CurrencyListEvent
}