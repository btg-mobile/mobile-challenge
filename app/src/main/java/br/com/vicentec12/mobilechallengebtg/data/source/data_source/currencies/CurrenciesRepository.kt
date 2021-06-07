package br.com.vicentec12.mobilechallengebtg.data.source.data_source.currencies

import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.local.Local
import br.com.vicentec12.mobilechallengebtg.data.source.remote.Remote
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class CurrenciesRepository @Inject constructor(
    @Local private val mLocalDataSource: CurrenciesDataSource,
    @Remote private val mRemoteDataSource: CurrenciesDataSource
) : CurrenciesDataSource {

    override suspend fun list() = when (val mResult = mRemoteDataSource.list()) {
        is Result.Success -> {
            insert(mResult.data)
            mResult
        }
        is Result.Error -> {
            when (val mResultLocal = mLocalDataSource.list()) {
                is Result.Success -> mResultLocal
                is Result.Error -> mResult
            }
        }
    }

    override suspend fun insert(mCurrencies: List<Currency>) = mLocalDataSource.insert(mCurrencies)

}