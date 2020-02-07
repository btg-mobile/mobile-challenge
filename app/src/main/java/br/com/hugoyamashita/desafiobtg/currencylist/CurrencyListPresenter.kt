package br.com.hugoyamashita.desafiobtg.currencylist

import br.com.hugoyamashita.currencyapi.CurrencyLayerApi
import br.com.hugoyamashita.desafiobtg.model.Currency
import br.com.hugoyamashita.desafiobtg.currencylist.CurrencyListContract.Presenter
import br.com.hugoyamashita.desafiobtg.currencylist.CurrencyListContract.View
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers

class CurrencyListPresenter(private val currencyApi: CurrencyLayerApi) : Presenter {

    private var view: View? = null
    private var subscriber: Disposable? = null
    private val currencies = mutableListOf<br.com.hugoyamashita.currencyapi.model.Currency>()

    override fun attachToView(view: View) {
        this.view = view
    }

    override fun detachFromView() {
        view = null
        subscriber?.dispose()
    }

    override fun loadCurrencyList() {
        view?.showLoadingAnimation()
        subscriber?.dispose()

        subscriber = currencyApi.getCurrencyList()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .doOnSuccess { currencyList ->
                // Refresh local currency list
                currencies.clear()
                currencies.addAll(currencyList)

                // Send data to the View
                view?.refreshCurrencyList(currencyList.map { currency ->
                    Currency(currency.symbol, currency.name)
                })
                view?.hideLoadingAnimation()
            }
            .doOnError {
                view?.refreshCurrencyList(listOf())
                view?.hideLoadingAnimation()
            }
            .subscribe()
    }

    override fun filterCurrencyList(filter: String) {
        view?.refreshCurrencyList(currencies
            .filter {
                it.symbol.toLowerCase().contains(filter.toLowerCase()) ||
                        it.name!!.toLowerCase().contains(filter.toLowerCase())
            }
            .map { Currency(it.symbol, it.name) })
    }

}