package br.com.vicentec12.mobilechallengebtg.data.source.data_source.currencies

import br.com.vicentec12.mobilechallengebtg.R
import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.remote.dto.CurrenciesDto
import br.com.vicentec12.mobilechallengebtg.data.source.remote.service.CurrenciesService
import br.com.vicentec12.mobilechallengebtg.di.IoDispatcher
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.withContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class CurrenciesRemoteDataSource @Inject constructor(
    private val mCurrenciesService: CurrenciesService,
    @IoDispatcher private val mDispatchers: CoroutineDispatcher
) : CurrenciesDataSource {

    override suspend fun list(): Result<List<Currency>> = withContext(mDispatchers) {
        try {
            val response = mCurrenciesService.list()
            if (response.isSuccessful && response.body()?.success == true) {
                val currencies = response.body() ?: CurrenciesDto()
                Result.Success(
                    currencies.toCurrencyList(),
                    R.string.message_successful_list_currencies
                )
            } else
                Result.Error(R.string.message_error_list_currencies)
        } catch (e: Exception) {
            Result.Error(R.string.message_error_internet_connection)
        }
    }

    override suspend fun insert(mCurrencies: List<Currency>) = 0

}