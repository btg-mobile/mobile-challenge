package br.com.vicentec12.mobilechallengebtg.data.source.data_source.quotes

import br.com.vicentec12.mobilechallengebtg.data.model.Quote
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.local.Local
import br.com.vicentec12.mobilechallengebtg.data.source.remote.Remote
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class QuotesRepository @Inject constructor(
    @Local private val mLocalDataSource: QuotesDataSource,
    @Remote private val mRemoteDataSource: QuotesDataSource
) : QuotesDataSource {

    override suspend fun live() = when (val mResult = mRemoteDataSource.live()) {
        is Result.Success -> {
            insert(mResult.data)
            mResult
        }
        is Result.Error -> {
            when (val mResultLocal = mLocalDataSource.live()) {
                is Result.Success -> mResultLocal
                is Result.Error -> mResult
            }
        }
    }

    override suspend fun insert(mQuotes: List<Quote>) = mLocalDataSource.insert(mQuotes)

}