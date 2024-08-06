package com.natanbf.currencyconversion.navigation

import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import com.natanbf.currencyconversion.ui.LocalContentComposition
import com.natanbf.currencyconversion.navigation.route.Route
import com.natanbf.currencyconversion.ui.AppState

@Composable
fun CurrencyConverterNavHost(
    appState: AppState,
    modifier: Modifier = Modifier,
    startDestination: String = Route.CurrencyConverterRoute.route
) {
    CompositionLocalProvider(LocalContentComposition provides appState) {
        NavHost(
            navController = appState.navController,
            startDestination = startDestination,
            modifier = modifier,
        ) {
            currencyConverterScreen()
            currencyListScreen()
        }
    }
}