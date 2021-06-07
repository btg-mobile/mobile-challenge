package br.com.vicentec12.mobilechallengebtg.data.source.data_source.quotes

import br.com.vicentec12.mobilechallengebtg.R
import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.data.model.Quote
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.remote.dto.QuotesDto
import br.com.vicentec12.mobilechallengebtg.data.source.remote.service.QuotesService
import br.com.vicentec12.mobilechallengebtg.di.IoDispatcher
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.withContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class QuotesRemoteDataSource @Inject constructor(
    private val mQuotesService: QuotesService,
    @IoDispatcher private val mDispatchers: CoroutineDispatcher
) : QuotesDataSource {

    override suspend fun live(): Result<List<Quote>> = withContext(mDispatchers) {
        try {
            val response = mQuotesService.live()
            if (response.isSuccessful && response.body()?.success == true) {
                val quotes = response.body() ?: QuotesDto()
                Result.Success(quotes.toQuoteList(), R.string.message_successful_list_quotes)
            } else
                Result.Error(R.string.message_error_list_quotes)
        } catch (e: Exception) {
            Result.Error(R.string.message_error_internet_connection)
        }
    }

    override suspend fun insert(mQuotes: List<Quote>) = 0

}