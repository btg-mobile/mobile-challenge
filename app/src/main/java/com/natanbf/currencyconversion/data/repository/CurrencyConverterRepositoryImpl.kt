package com.natanbf.currencyconversion.data.repository

import com.natanbf.currencyconversion.data.local.DataStoreCurrency
import com.natanbf.currencyconversion.data.remote.RemoteDataSource
import com.natanbf.currencyconversion.domain.model.CurrencyModel
import com.natanbf.currencyconversion.domain.repository.CurrencyConverterRepository
import com.natanbf.currencyconversion.util.networkBoundResource
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.onEach
import javax.inject.Inject

internal class CurrencyConverterRepositoryImpl @Inject constructor(
    private val remote: RemoteDataSource,
    private val dataStore: DataStoreCurrency,
    private val coroutineDispatcher: CoroutineDispatcher
) : CurrencyConverterRepository {

    override val getExchangeRates: Flow<CurrencyModel> = flow {
        networkBoundResource(
            query = {
                dataStore.read()
                    .map {
                        CurrencyModel(
                            exchangeRates = it.exchangeRates
                        )
                    }
            },
            fetch = {
                remote.getRemoteExchangeRates()
            },
            saveFetchResult = { data ->
                data.onSuccess { dataStore.save { copy(exchangeRates = it.currencies) } }
            },
            shouldFetch = { data ->
                data.currentQuote.isEmpty()
            }
        )
            .onEach { result -> result.onSuccess { emit(it) } }
            .collect()
    }
        .catch { emit(CurrencyModel(error = it.message)) }
        .flowOn(coroutineDispatcher)


    override val getCurrentQuote: Flow<CurrencyModel>
        get() = flow {
            networkBoundResource(
                query = {
                    dataStore.read()
                        .map {
                            CurrencyModel(
                                from = it.from,
                                to = it.to,
                                currentQuote = it.currentQuote
                            )
                        }
                },
                fetch = {
                    remote.getRemoteCurrentQuote()
                },
                saveFetchResult = { data ->
                   data.onSuccess {
                       it.quotes?.let { map ->
                           dataStore.save { copy(currentQuote = map) }
                       }
                   }
                },
                shouldFetch = { data ->
                    data.currentQuote.isEmpty()
                }
            )
                .onEach { result -> result.onSuccess { emit(it) } }
                .collect()
        }
            .catch { emit(CurrencyModel(error = it.message)) }
            .flowOn(coroutineDispatcher)

    override val getFromTo: Flow<CurrencyModel>
        get() = flow {
            dataStore.read()
                .onEach {
                    emit(
                        CurrencyModel(
                            from = it.from,
                            to = it.to,
                            currentQuote = it.currentQuote
                        )
                    )
                }
                .catch { emit(CurrencyModel(error = it.message)) }
                .collect()
        }
            .catch { emit(CurrencyModel(error = it.message)) }
            .flowOn(coroutineDispatcher)

}