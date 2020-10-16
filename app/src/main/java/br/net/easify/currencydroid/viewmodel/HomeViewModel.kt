package br.net.easify.currencydroid.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import br.net.easify.currencydroid.MainApplication
import br.net.easify.currencydroid.api.CurrencyService
import br.net.easify.currencydroid.api.QuoteService
import br.net.easify.currencydroid.api.model.Currency
import br.net.easify.currencydroid.database.AppDatabase
import br.net.easify.currencydroid.util.DatabaseUtils
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.observers.DisposableSingleObserver
import io.reactivex.schedulers.Schedulers
import javax.inject.Inject

class HomeViewModel(application: Application) : AndroidViewModel(application) {

    private val disposable = CompositeDisposable()

    @Inject
    lateinit var database: AppDatabase

    @Inject
    lateinit var currencyService: CurrencyService

    init {
        (getApplication() as MainApplication).getAppComponent()?.inject(this)

        loadCurrencies()
    }

    override fun onCleared() {
        super.onCleared()

        disposable.clear()
    }

    private fun loadCurrencies() {

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

}
