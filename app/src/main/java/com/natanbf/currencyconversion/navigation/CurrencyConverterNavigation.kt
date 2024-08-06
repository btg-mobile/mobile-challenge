package com.natanbf.currencyconversion.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import com.natanbf.currencyconversion.navigation.route.Route
import com.natanbf.currencyconversion.ui.screen.CurrencyConverterScreen

fun NavGraphBuilder.currencyConverterScreen() {
    composable(
        route = Route.CurrencyConverterRoute.route
    ) {
        CurrencyConverterScreen()
    }
}