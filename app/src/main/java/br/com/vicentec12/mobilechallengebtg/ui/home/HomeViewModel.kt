package br.com.vicentec12.mobilechallengebtg.ui.home

import android.content.Intent
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.data.model.Quote
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.data_source.currencies.CurrenciesDataSource
import br.com.vicentec12.mobilechallengebtg.data.source.data_source.quotes.QuotesDataSource
import br.com.vicentec12.mobilechallengebtg.di.ActivityScope
import br.com.vicentec12.mobilechallengebtg.extension.currencyToDouble
import br.com.vicentec12.mobilechallengebtg.ui.home.HomeActivity.Companion.EXTRA_CURRENCY_SELECTED
import br.com.vicentec12.mobilechallengebtg.ui.home.HomeActivity.Companion.EXTRA_IS_FROM
import br.com.vicentec12.mobilechallengebtg.util.Event
import kotlinx.coroutines.launch
import javax.inject.Inject

@ActivityScope
class HomeViewModel @Inject constructor(
    private val mRepository: QuotesDataSource
) : ViewModel() {

    private val _message = MutableLiveData<Event<Int>>()
    val message: LiveData<Event<Int>>
        get() = _message

    private val _loading = MutableLiveData<Event<Boolean>>()
    val loading: LiveData<Event<Boolean>>
        get() = _loading

    private val _currencyFrom = MutableLiveData<String>()
    val currencyFrom: LiveData<String>
        get() = _currencyFrom

    private val _currencyTo = MutableLiveData<String>()
    val currencyTo: LiveData<String>
        get() = _currencyTo

    val currencyFromValue = MutableLiveData<String>()

    val currencyToValue = MutableLiveData<String>()

    init {
        _currencyFrom.value = "USD"
        _currencyTo.value = "USD"
        currencyFromValue.value = "0"
        currencyToValue.value = "0"
    }

    fun convertCurrency() = viewModelScope.launch {
        _loading.value = Event(true)
        when (val result = mRepository.live()) {
            is Result.Success -> {
                val mValueConverted = convertCurrency(
                    currencyFromValue.value,
                    _currencyFrom.value ?: "USD",
                    _currencyTo.value ?: "USD",
                    result.data!!
                )
                currencyToValue.value = String.format("%.2f", mValueConverted)
            }
            is Result.Error -> _message.value = Event(result.message)
        }
        _loading.value = Event(false)
    }

    private fun convertCurrency(
        mValue: String?,
        mFromCurrency: String,
        mToAfter: String,
        mQuotes: List<Quote>
    ): Double {
        val mValueDouble = mValue?.currencyToDouble() ?: 0.0
        val mQuotesMap = mutableMapOf<String, Double>()
        var mSource = ""
        mQuotes.forEach { mQuote ->
            if (mQuote.code == "${mQuote.source}$mFromCurrency" || mQuote.code == "${mQuote.source}$mToAfter") {
                mSource = mQuote.source
                mQuotesMap[mQuote.code] = mQuote.value
            }
        }
        return (mValueDouble / (mQuotesMap["$mSource$mFromCurrency"] ?: 1.0) *
                (mQuotesMap["$mSource$mToAfter"] ?: 0.0))
    }

    fun receiverValues(mData: Intent?) {
        mData?.let {
            val mCurrency = (mData.getParcelableExtra(EXTRA_CURRENCY_SELECTED) as? Currency)
            if (mData.getBooleanExtra(EXTRA_IS_FROM, false))
                _currencyFrom.value = mCurrency?.code ?: "USD"
            else {
                currencyToValue.value = "0"
                _currencyTo.value = mCurrency?.code ?: "USD"
            }
        }
    }

}