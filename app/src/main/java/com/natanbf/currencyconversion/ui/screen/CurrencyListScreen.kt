package com.natanbf.currencyconversion.ui.screen

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.Clear
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SearchBar
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Devices
import androidx.compose.ui.tooling.preview.Preview
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.natanbf.currencyconversion.ui.LocalContentComposition
import com.natanbf.currencyconversion.ui.event.CurrencyListEvent
import com.natanbf.currencyconversion.ui.viewmodel.CurrencyListViewModel
import com.natanbf.currencyconversion.util.convertMapToList

@Composable
fun CurrencyListScreen(viewModel: CurrencyListViewModel = hiltViewModel()) {
    val appState = LocalContentComposition.current

    val uiState by viewModel.uiState.collectAsStateWithLifecycle()
    val query by viewModel.query.collectAsStateWithLifecycle()
    val exchangeRates by viewModel.filteredExchangeRates.collectAsStateWithLifecycle()

    CurrencyListContent(
        list = exchangeRates,
        query = query,
        active = uiState.active,
        onActiveChange = {
            viewModel.sendEvent(event = CurrencyListEvent.SetActive(it))
        },
        onQueryChangeEvent = {
            viewModel.sendEvent(event = CurrencyListEvent.UpdateQuery(it))
        },
        onNavigation = {
            viewModel.sendEvent(event = CurrencyListEvent.OnNavigation)
        },
        onValueChangedEvent = {
            viewModel.sendEvent(event = CurrencyListEvent.SaveCurrency(it))
        }
    )

    LaunchedEffect(uiState.goBack) {
        if (uiState.goBack) appState.navController.popBackStack()
    }
}

@Composable
private fun CurrencyListContent(
    list: Map<String, String>,
    query: String = String(),
    active: Boolean = false,
    onActiveChange: (Boolean) -> Unit,
    onValueChangedEvent: (String) -> Unit,
    onQueryChangeEvent: (String) -> Unit,
    onNavigation: () -> Unit
) {

    Column(modifier = Modifier.fillMaxSize()) {
        CenterAlignedTopAppBar(
            title = { Text(text = "List") },
            navigationIcon = {
                IconButton(onClick = { onNavigation() }) {
                    Icon(
                        imageVector = Icons.AutoMirrored.Filled.ArrowBack,
                        contentDescription = String(),
                        tint = MaterialTheme.colorScheme.onSurface
                    )
                }
            },
            modifier = Modifier.fillMaxWidth()
        )

        SearchBar(
            modifier = Modifier.fillMaxWidth(),
            placeholder = { Text(text = "Search") },
            query = query,
            onQueryChange = {
                onQueryChangeEvent(it)
            },
            onSearch = { onQueryChangeEvent(it) },
            active = active,
            onActiveChange = { onActiveChange(it) },
            leadingIcon = {
                Icon(
                    imageVector = Icons.Default.Search,
                    contentDescription = "Clear",
                    tint = MaterialTheme.colorScheme.onSurface
                )
            },
            trailingIcon = {
                IconButton(onClick = {
                    if (query.isNotEmpty()) {
                        onQueryChangeEvent("")
                    } else {
                        onActiveChange(false)
                    }
                }) {
                    Icon(
                        imageVector = Icons.Default.Clear,
                        contentDescription = "Clear",
                        tint = MaterialTheme.colorScheme.onSurface
                    )
                }
            }
        ) {
            if (active)
                CurrencyList(
                    list = list,
                    onValueChangedEvent = onValueChangedEvent
                )
        }

        if (active.not()) CurrencyList(
            list = list,
            onValueChangedEvent = onValueChangedEvent
        )

    }
}

@Composable
private fun CurrencyList(
    modifier: Modifier = Modifier,
    list: Map<String, String>,
    onValueChangedEvent: (String) -> Unit
) {
    LazyColumn(
        modifier = modifier
            .fillMaxWidth()
    ) {
        itemsIndexed(list.convertMapToList()) { index, item ->
            DropdownMenuItem(
                text = { Text(text = item) },
                onClick = {
                    onValueChangedEvent(list.toList()[index].first)
                }
            )
        }
    }
}


@Preview(showBackground = true, device = Devices.NEXUS_7)
@Composable
private fun CurrencyListScreenPreview() {
    CurrencyListContent(onNavigation = {}, onValueChangedEvent = {},
        list = mapOf("USD" to "United States Dollar", "BRL" to "Brazilian Real", "EUR" to "Euro"),
        query = "constituam",
        active = false,
        onActiveChange = {},
        onQueryChangeEvent = {})
}