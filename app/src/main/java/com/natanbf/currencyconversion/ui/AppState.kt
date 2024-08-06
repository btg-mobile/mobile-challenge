package com.natanbf.currencyconversion.ui

import androidx.compose.runtime.Composable
import androidx.compose.runtime.Stable
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.navigation.NavHostController
import androidx.navigation.compose.rememberNavController
import kotlinx.coroutines.CoroutineScope

@Stable
class AppState(
    val navController: NavHostController,
    val coroutineScope: CoroutineScope
) {

    fun navigateTo(route: String) {
        navController.navigate(route)
    }

}

@Composable
fun rememberAppState(
    coroutineScope: CoroutineScope = rememberCoroutineScope(),
    navController: NavHostController = rememberNavController(),
): AppState {
    return remember(
        navController,
        coroutineScope
    ) {
        AppState(
            navController,
            coroutineScope
        )
    }
}