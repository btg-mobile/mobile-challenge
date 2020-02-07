package br.com.hugoyamashita.desafiobtg.currencylist

import br.com.hugoyamashita.desafiobtg.model.Currency

interface CurrencyListContract {

    interface View {
        fun showLoadingAnimation()
        fun hideLoadingAnimation()
        fun refreshCurrencyList(currencies: List<Currency>)
    }

    interface Presenter {
        fun attachToView(view: View)
        fun detachFromView()
        fun loadCurrencyList()
    }

}