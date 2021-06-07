package br.com.vicentec12.mobilechallengebtg.data.source.data_source.quotes

import br.com.vicentec12.mobilechallengebtg.data.model.Quote
import br.com.vicentec12.mobilechallengebtg.data.source.Result

interface QuotesDataSource {

    suspend fun live(): Result<List<Quote>>

    suspend fun insert(mQuotes: List<Quote>): Int

}