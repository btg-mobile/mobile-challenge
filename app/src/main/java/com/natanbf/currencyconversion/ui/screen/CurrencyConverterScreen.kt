package com.natanbf.currencyconversion.ui.screen

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.KeyboardArrowRight
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.VerticalDivider
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Devices
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.natanbf.currencyconversion.navigation.navigateToCurrencyList
import com.natanbf.currencyconversion.ui.LocalContentComposition
import com.natanbf.currencyconversion.ui.component.CustomCircularIndicator
import com.natanbf.currencyconversion.ui.event.CurrencyEvent
import com.natanbf.currencyconversion.ui.viewmodel.CurrencyConverterViewModel

@Composable
fun CurrencyConverterScreen(viewModel: CurrencyConverterViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    val appState = LocalContentComposition.current
    var userLoggedIn by remember { mutableStateOf(false) }
    var isSelectedFrom by remember { mutableStateOf(false) }

    if (state.isLoading) CustomCircularIndicator()
    else CurrencyConverterContent(
            selectedFrom = state.selectedTextFrom,
            selectedTo = state.selectedTextTo,
            valueFrom = state.valueFrom,
            valueTo = state.valueTo,
            onNavigation = { item ->
                isSelectedFrom = item
                userLoggedIn = true
            },
            onValueChangedEvent = { amount ->
                viewModel.sendEvent(
                    event = CurrencyEvent.ConvertedCurrency(
                        amount = amount
                    )
                )
            }
        )

    LaunchedEffect(Unit, userLoggedIn) {
        if (userLoggedIn) appState.navController.navigateToCurrencyList(isSelectedFrom)
        else viewModel.sendEvent(event = CurrencyEvent.Initial)
    }

}

@Composable
private fun CurrencyConverterContent(
    selectedFrom: String,
    selectedTo: String,
    valueFrom: String,
    valueTo: String,
    onNavigation: (isSelectedFrom: Boolean) -> Unit,
    onValueChangedEvent: (amount: String) -> Unit
) {
    Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
        Row {
            Column(
                modifier = Modifier,
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                TextField(
                    value = valueFrom,
                    keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
                    onValueChange = { text ->
                        onValueChangedEvent(text)
                    },
                    trailingIcon = {
                        Row(
                            modifier = Modifier
                                .clickable {
                                    onNavigation(true)
                                },
                            horizontalArrangement = Arrangement.spacedBy(8.dp),
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            VerticalDivider(
                                modifier = Modifier
                                    .height(48.dp)
                            )
                            Text(text = selectedFrom)
                            Icon(
                                imageVector = Icons.AutoMirrored.Filled.KeyboardArrowRight,
                                contentDescription = String()
                            )
                        }
                    }
                )

                TextField(
                    value = valueTo,
                    readOnly= true,
                    keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
                    onValueChange = { },
                    trailingIcon = {
                        Row(
                            modifier = Modifier
                                .clickable {
                                    onNavigation(false)
                                },
                            horizontalArrangement = Arrangement.spacedBy(8.dp),
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            VerticalDivider(
                                modifier = Modifier
                                    .height(48.dp)
                            )
                            Text(text = selectedTo)
                            Icon(
                                imageVector = Icons.AutoMirrored.Filled.KeyboardArrowRight,
                                contentDescription = String()
                            )
                        }
                    }
                )
            }
        }
    }
}

@Preview(
    showBackground = true,
    device = Devices.NEXUS_7
)
@Composable
private fun CurrencyConverterPreview() {
    val selectedText: String by remember {
        mutableStateOf("BRL")
    }

    val selectedValueTo: String by remember {
        mutableStateOf("USD")
    }
    val valueFrom: String by rememberSaveable {
        mutableStateOf("Dolar")
    }

    val valueTo: String by rememberSaveable {
        mutableStateOf("Real")
    }

    Column(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Center) {
        CurrencyConverterContent(
            selectedFrom = selectedText,
            selectedTo = selectedValueTo,
            valueFrom = valueFrom,
            valueTo = valueTo,
            onValueChangedEvent = { amount -> },
            onNavigation = {},
        )
    }
}
