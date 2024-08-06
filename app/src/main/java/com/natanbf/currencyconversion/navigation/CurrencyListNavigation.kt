package com.natanbf.currencyconversion.navigation

import androidx.navigation.NavController
import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavType
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import com.natanbf.currencyconversion.navigation.route.Route
import com.natanbf.currencyconversion.ui.screen.CurrencyListScreen

const val ARGUMENTS_KEY = "ID"
fun NavController.navigateToCurrencyList(item: Boolean) {
    this.navigate(Route.CurrencyListRoute.selectedItem(item = item))
}

fun NavGraphBuilder.currencyListScreen() {
    composable(
        route = Route.CurrencyListRoute.route,
        arguments = listOf(navArgument(ARGUMENTS_KEY) {
            type = NavType.BoolType
        })
    ) {
        CurrencyListScreen()
    }
}