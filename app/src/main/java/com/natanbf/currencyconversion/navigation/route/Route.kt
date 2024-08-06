package com.natanbf.currencyconversion.navigation.route

import com.natanbf.currencyconversion.navigation.ARGUMENTS_KEY

sealed class Route(val route: String) {
    data object CurrencyConverterRoute : Route("CurrencyConverterRoute")
    data object CurrencyListRoute : Route("CurrencyListRoute/{$ARGUMENTS_KEY}") {
        fun selectedItem(item: Boolean): String {
            return "CurrencyListRoute/$item"
        }
    }
}