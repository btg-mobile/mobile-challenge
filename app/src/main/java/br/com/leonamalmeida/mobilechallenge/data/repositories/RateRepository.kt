package br.com.leonamalmeida.mobilechallenge.data.repositories

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.data.Result
import br.com.leonamalmeida.mobilechallenge.data.source.local.RateLocalDataSource
import br.com.leonamalmeida.mobilechallenge.data.source.remote.RateRemoteDataSource
import br.com.leonamalmeida.mobilechallenge.util.setSchedulers
import io.reactivex.disposables.CompositeDisposable
import java.text.SimpleDateFormat
import java.util.*

/**
 * Created by Leo Almeida on 29/06/20.
 */

interface RateRepository {

    fun makeConversion(
        originCode: String,
        destinyCode: String,
        amount: Float
    ): LiveData<Result<Pair<String, Float>>>
}

@Suppress("UnstableApiUsage")
class RateRepositoryImpl(
    private val remoteDataSource: RateRemoteDataSource,
    private val localDataSource: RateLocalDataSource
) : RateRepository {

    private val disposable = CompositeDisposable()

    override fun makeConversion(
        originCode: String,
        destinyCode: String,
        amount: Float
    ): LiveData<Result<Pair<String, Float>>> {
        val data = MutableLiveData<Result<Pair<String, Float>>>()

        getRealTimeRateFromRemote(data)

        disposable.add(
            localDataSource.getRealTimeRate()
                .filter { it.isNotEmpty() }
                .map { calculateConversion(originCode, destinyCode, amount) }
                .setSchedulers()
                .subscribe(
                    { data.value = Result.Success(it) },
                    {
                        it.printStackTrace()
                        data.value = Result.Error(R.string.fetch_rate_default_error_message)
                    })
        )

        return data
    }

    private fun calculateConversion(
        originCode: String,
        destinyCode: String,
        amount: Float
    ): Pair<String, Float> {
        val origin = localDataSource.getRateByCode(originCode)
        val destiny = localDataSource.getRateByCode(destinyCode).value
        val lastUpdate = getFullDateTime(origin.lastUpdate)
        return Pair(lastUpdate, (amount / origin.value) * destiny)
    }

    private fun getFullDateTime(dateInMillis: Long): String =
        SimpleDateFormat("dd/MM/yyyy HH:mm", Locale.getDefault()).format(Date(dateInMillis))

    private fun getRealTimeRateFromRemote(data: MutableLiveData<Result<Pair<String, Float>>>) {
        disposable.add(
            remoteDataSource.getRealTimeRate()
                .doOnSubscribe { data.postValue(Result.Loading(true)) }
                .doOnTerminate { data.postValue(Result.Loading(false)) }
                .flatMapCompletable { localDataSource.saveRates(it) }
                .setSchedulers()
                .subscribe({}, {
                    it.printStackTrace()
                    data.value = Result.Error(R.string.fetch_rate_default_error_message)
                })
        )
    }
}