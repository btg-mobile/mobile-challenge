package com.natanbf.currencyconversion.ui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.compositionLocalOf
import androidx.compose.ui.Modifier
import com.natanbf.currencyconversion.navigation.CurrencyConverterNavHost
import com.natanbf.currencyconversion.ui.AppState
import com.natanbf.currencyconversion.ui.rememberAppState
import com.natanbf.currencyconversion.ui.theme.CurrencyConversionTheme
import dagger.hilt.android.AndroidEntryPoint

internal val LocalContentComposition =
    compositionLocalOf<AppState> { error("Error AppState Composition") }

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    private lateinit var appState: AppState

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            appState = rememberAppState()

            CurrencyConversionTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    CurrencyConverterNavHost(appState = appState)
                }
            }
        }
    }
}