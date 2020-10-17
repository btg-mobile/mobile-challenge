package br.net.easify.currencydroid.viewmodel

import android.app.Application
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import br.net.easify.currencydroid.MainApplication
import br.net.easify.currencydroid.api.CurrencyService
import br.net.easify.currencydroid.api.model.Currency
import br.net.easify.currencydroid.database.AppDatabase
import br.net.easify.currencydroid.model.ConversionValues
import br.net.easify.currencydroid.services.RateService
import br.net.easify.currencydroid.util.Constants
import br.net.easify.currencydroid.util.DatabaseUtils
import br.net.easify.currencydroid.util.SharedPreferencesUtil
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.observers.DisposableSingleObserver
import io.reactivex.schedulers.Schedulers
import java.text.SimpleDateFormat
import java.util.*
import javax.inject.Inject

class HomeViewModel(application: Application) : AndroidViewModel(application) {

    private val disposable = CompositeDisposable()

    val bannerText by lazy { MutableLiveData<String>() }
    val lastUpdateText by lazy { MutableLiveData<String>() }
    val conversionValues by lazy { MutableLiveData<ConversionValues>() }
    val fromValue by lazy { MutableLiveData<br.net.easify.currencydroid.database.model.Currency>() }
    val toValue by lazy { MutableLiveData<br.net.easify.currencydroid.database.model.Currency>() }

    @Inject
    lateinit var database: AppDatabase

    @Inject
    lateinit var currencyService: CurrencyService

    @Inject
    lateinit var sharedPreferencesUtil: SharedPreferencesUtil

    private val onRateServiceUpdate: BroadcastReceiver =
        object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val lastRateUpdate = sharedPreferencesUtil.getLastRateUpdate()
                bannerText.value = generateBannerText()
                lastUpdateText.value = formatLastUpdateText(lastRateUpdate)
            }
        }

    init {
        (getApplication() as MainApplication).getAppComponent()?.inject(this)
        loadCurrenciesFromDbOrApi()
        setupBroadcastReceiver()
        setupInformationData()
        setupInputAndOutputValues()
        loadDefaultCurrencies()
    }

    override fun onCleared() {
        super.onCleared()
        disposable.clear()
    }

    private fun loadCurrenciesFromDbOrApi() {

        if ( database.currencyDao().getCount() > 0 )
            return

        disposable.add(
            currencyService.list()
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(object : DisposableSingleObserver<Currency>() {
                    override fun onSuccess(res: Currency) {
                        if (res.success) {
                            val currencies =
                                DatabaseUtils.mapToCurrency(res.currencies)

                            database.currencyDao().insert(currencies)
                        }
                    }

                    override fun onError(e: Throwable) {
                        e.printStackTrace()
                    }
                })
        )
    }

    private fun generateBannerText(): String {
        val quotes = database.quoteDao().getAll()

        var bannerText = "| "

        for (quote in quotes) {
            bannerText += quote.conversion.substring(3)
            bannerText += ": "
            bannerText += quote.rate.toString()
            bannerText += " | "
        }

        return bannerText
    }

    private fun formatLastUpdateText(timeStamp: Long): String {
        return try {
            val sdf = SimpleDateFormat("dd/MM/yyyy HH:mm")
            val netDate = Date(timeStamp * 1000)
            sdf.format(netDate)
        } catch (e: Exception) {
            e.toString()
        }
    }

    private fun setupInformationData() {
        bannerText.value = generateBannerText()
        val lastRateUpdate = sharedPreferencesUtil.getLastRateUpdate()
        if (lastRateUpdate > 0)
            lastUpdateText.value = formatLastUpdateText(lastRateUpdate)
    }

    private fun setupBroadcastReceiver() {
        val serviceIntent = IntentFilter(RateService.rateServiceUpdate)
        LocalBroadcastManager.getInstance(getApplication())
            .registerReceiver(onRateServiceUpdate, serviceIntent)
    }

    private fun setupInputAndOutputValues() {
        conversionValues.value = ConversionValues("", "")
    }

    fun loadDefaultCurrencies() {
        getFromCurrency()
        getToCurrency()
    }

    private fun getFromCurrency() {
        val fromCurrency = sharedPreferencesUtil.getFromCurrency()
        fromValue.value = database.currencyDao().getCurrency(fromCurrency)
    }

    private fun getToCurrency() {
        val toCurrency = sharedPreferencesUtil.getToCurrency()
        toValue.value = database.currencyDao().getCurrency(toCurrency)
    }

    fun updateFromCurrency(id: Long) {
        val currency = database.currencyDao().getCurrency(id)
        currency?.let {
            sharedPreferencesUtil.setFromCurrency(currency.currencyId)
            fromValue.value = it
        }
    }

    fun updateToCurrency(id: Long) {
        val currency = database.currencyDao().getCurrency(id)
        currency?.let {
            sharedPreferencesUtil.setToCurrency(currency.currencyId)
            toValue.value = it
        }
    }

    fun calculate() {
        val from = fromValue.value!!
        val to = toValue.value!!
        val values = conversionValues.value!!
        val value = values.from
        if ( value.isNotEmpty() ) {
            val exchange = calculateExchange(value.toFloat(), from.currencyId, to.currencyId)
            values.to = exchange.toString()
            conversionValues.value = values
        } else {
            values.to = "0.0"
            conversionValues.value = values
        }
    }

    private fun calculateExchange(value: Float, from: String, to: String): Float {
        return if (from == Constants.usDollar) {
            val rate = dollarRate(to)
            (value * rate)
        } else {
            val fromRate = dollarRate(from)
            val toRate = dollarRate(to)
            val valueInDollar = (value / fromRate)
            (valueInDollar * toRate)
        }
    }

    private fun dollarRate(currency: String): Float {
        val sqliteLikeExpression = "___$currency"
        val quote = database.quoteDao().getQuote(sqliteLikeExpression)
        return quote.rate
    }

    fun invertCurrencies() {
        val from = fromValue.value!!
        val to = toValue.value!!
        toValue.value = from
        fromValue.value = to
        val values = conversionValues.value!!
        val valueFrom = values.from
        val valueTo = values.to
        if ( valueFrom.isNotEmpty() ) {
            values.from = valueTo
            values.to = valueFrom
            conversionValues.value = values
        }
    }

    fun clearConvertedValue() {
        setupInputAndOutputValues()
    }
}
