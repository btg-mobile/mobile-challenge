package br.com.vicentec12.mobilechallengebtg.data.source.data_source.quotes

import br.com.vicentec12.mobilechallengebtg.R
import br.com.vicentec12.mobilechallengebtg.data.model.Quote
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.local.dao.QuoteDao
import br.com.vicentec12.mobilechallengebtg.data.source.local.entity.QuoteEntity
import br.com.vicentec12.mobilechallengebtg.di.IoDispatcher
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.withContext
import javax.inject.Inject

class QuotesLocalDataSource @Inject constructor(
    private val mQuoteDao: QuoteDao,
    @IoDispatcher private val mDispatcher: CoroutineDispatcher
) : QuotesDataSource {

    override suspend fun live() = withContext(mDispatcher) {
        val mResult = mQuoteDao.list()
        val mQuotes = ArrayList<Quote>()
        mResult.forEach {
            mQuotes.add(it.toQuote())
        }
        if (mQuotes.isEmpty())
            Result.Error(R.string.message_error_list_quotes)
        else
            Result.Success(mQuotes, R.string.message_successful_list_quotes)
    }

    override suspend fun insert(mQuotes: List<Quote>) = withContext(mDispatcher) {
        val mQuotesEntity = ArrayList<QuoteEntity>()
        mQuotes.forEach {
            mQuotesEntity.add(it.toQuoteEntity())
        }
        mQuoteDao.insert(mQuotesEntity)
        R.string.message_successful_insert_quotes
    }

}