package br.com.vicentec12.mobilechallengebtg.data.source.data_source.currencies

import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.data.source.Result

interface CurrenciesDataSource {

    suspend fun list(): Result<List<Currency>>

    suspend fun insert(mCurrencies: List<Currency>): Int

}