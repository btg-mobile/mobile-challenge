package br.com.vicentec12.mobilechallengebtg.data.source.data_source.currencies

import br.com.vicentec12.mobilechallengebtg.R
import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.local.dao.CurrencyDao
import br.com.vicentec12.mobilechallengebtg.data.source.local.entity.CurrencyEntity
import br.com.vicentec12.mobilechallengebtg.di.IoDispatcher
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.withContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class CurrenciesLocalDataSource @Inject constructor(
    private val mCurrencyDao: CurrencyDao,
    @IoDispatcher private val mDispatcher: CoroutineDispatcher
) : CurrenciesDataSource {

    override suspend fun list() = withContext(mDispatcher) {
        val mResult = mCurrencyDao.list()
        val mCurrencies = ArrayList<Currency>()
        mResult.forEach {
            mCurrencies.add(it.toCurrency())
        }
        if (mCurrencies.isEmpty())
            Result.Error(R.string.message_error_list_currencies)
        else
            Result.Success(mCurrencies, R.string.message_successful_list_currencies)
    }

    override suspend fun insert(mCurrencies: List<Currency>) = withContext(mDispatcher) {
        val mCurriencesEntity = ArrayList<CurrencyEntity>()
        mCurrencies.forEach {
            mCurriencesEntity.add(it.toCurrencyEntity())
        }
        mCurrencyDao.insert(mCurriencesEntity)
        R.string.message_successful_insert_quotes
    }

}