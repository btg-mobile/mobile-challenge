package br.com.hugoyamashita.desafiobtg.converter

import br.com.hugoyamashita.currencyapi.CurrencyLayerApi
import br.com.hugoyamashita.desafiobtg.converter.CurrencyConverterContract.Presenter
import br.com.hugoyamashita.desafiobtg.converter.CurrencyConverterContract.View
import br.com.hugoyamashita.desafiobtg.model.ConversionRate
import br.com.hugoyamashita.desafiobtg.model.Currency
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers

class CurrencyConverterPresenter(private val currencyApi: CurrencyLayerApi) : Presenter {

    private var view: View? = null
    private var subscriber: Disposable? = null
    private val conversionRates =
        mutableListOf<br.com.hugoyamashita.currencyapi.model.ConversionRate>()

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

        subscriber = currencyApi.getConversionRateList()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .doOnSuccess { conversionRateList ->
                // Prepare data to notify the View
                view?.refreshCurrencyList(conversionRateList
                    .map { rate ->
                        Currency(rate.to)
                    }
                    .sortedBy { it.symbol })

                // Store local conversion rates
                conversionRates.clear()
                conversionRates.addAll(conversionRateList)

                view?.hideLoadingAnimation()
            }
            .doOnError {
                conversionRates.clear()
                view?.refreshCurrencyList(listOf())
                view?.hideLoadingAnimation()
            }
            .subscribe()
    }

    override fun calculateConvertedValue(value: Double, from: String, to: String) {
        var calculatedValue = value

        var rate = conversionRates.first { it.to == from }
        calculatedValue /= rate.rate

        rate = conversionRates.first { it.to == to }
        calculatedValue *= rate.rate

        view?.updateCalculatedValue(calculatedValue)
    }

}