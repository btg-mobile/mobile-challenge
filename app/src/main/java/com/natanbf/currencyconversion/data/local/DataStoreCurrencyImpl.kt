package com.natanbf.currencyconversion.data.local

import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.emptyPreferences
import androidx.datastore.preferences.core.stringPreferencesKey
import com.natanbf.currencyconversion.domain.model.DataStoreModel
import com.natanbf.currencyconversion.util.fromJson
import com.natanbf.currencyconversion.util.json
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.firstOrNull
import kotlinx.coroutines.flow.map
import java.io.IOException
import javax.inject.Inject

internal class DataStoreCurrencyImpl @Inject constructor(
    private val dataStore: DataStore<Preferences>
) : DataStoreCurrency {
    private object PreferencesKey {
        val list = stringPreferencesKey(name = "list")
        val live = stringPreferencesKey(name = "live")
        val from = stringPreferencesKey(name = "from")
        val to = stringPreferencesKey(name = "to")
    }

    override suspend fun save(completed: DataStoreModel.() -> DataStoreModel) {
        val data = read().firstOrNull()
        dataStore.edit { preferences ->
            data?.let {
                it.completed().apply {
                    if (exchangeRates.isNotEmpty()) preferences[PreferencesKey.list] = exchangeRates.json()
                    if (currentQuote.isNotEmpty()) preferences[PreferencesKey.live] = currentQuote.json()
                    if (from.isNotEmpty()) preferences[PreferencesKey.from] = from
                    if (to.isNotEmpty()) preferences[PreferencesKey.to] = to
                }
            } ?: DataStoreModel()
        }
    }

    override fun read(): Flow<DataStoreModel> {
        return dataStore.data
            .catch { exception ->
                if (exception is IOException) {
                    emit(emptyPreferences())
                } else {
                    throw exception
                }
            }
            .map { preferences ->
                DataStoreModel(
                    exchangeRates = preferences[PreferencesKey.list]?.fromJson<Map<String, String>>()
                        ?: emptyMap(),
                    currentQuote = preferences[PreferencesKey.live]?.fromJson<Map<String, Double>>()
                        ?: emptyMap(),
                    from = preferences[PreferencesKey.from]?.fromJson<String>() ?: String(),
                    to = preferences[PreferencesKey.to]?.fromJson<String>() ?: String(),
                )
            }
    }

}