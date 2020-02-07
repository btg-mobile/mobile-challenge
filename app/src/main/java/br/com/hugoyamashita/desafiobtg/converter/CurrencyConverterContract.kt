package br.com.hugoyamashita.desafiobtg.converter

import br.com.hugoyamashita.desafiobtg.model.ConversionRate
import br.com.hugoyamashita.desafiobtg.model.Currency

interface CurrencyConverterContract {

    interface View {
        fun showLoadingAnimation()
        fun hideLoadingAnimation()
        fun refreshCurrencyList(currencies: List<Currency>)
        fun updateCalculatedValue(value: Double)
    }

    interface Presenter {
        fun attachToView(view: View)
        fun detachFromView()
        fun loadCurrencyList()
        fun calculateConvertedValue(value: Double, from: String, to: String)
    }

}