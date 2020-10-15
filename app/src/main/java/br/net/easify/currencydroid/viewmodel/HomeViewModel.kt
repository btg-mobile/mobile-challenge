package br.net.easify.currencydroid.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import br.net.easify.currencydroid.MainApplication
import br.net.easify.currencydroid.api.CurrencyService
import br.net.easify.currencydroid.api.QuoteService
import br.net.easify.currencydroid.database.AppDatabase
import javax.inject.Inject

class HomeViewModel (application: Application) : AndroidViewModel(application) {

    @Inject
    lateinit var database: AppDatabase

    @Inject
    lateinit var currencyService: CurrencyService

    @Inject
    lateinit var quoteService: QuoteService

    init {
        (getApplication() as MainApplication).getAppComponent()?.inject(this)
    }
}