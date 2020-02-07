package br.com.hugoyamashita.desafiobtg.di

import br.com.hugoyamashita.desafiobtg.converter.CurrencyConverterContract
import br.com.hugoyamashita.desafiobtg.converter.CurrencyConverterPresenter
import br.com.hugoyamashita.desafiobtg.currencylist.CurrencyListContract
import br.com.hugoyamashita.desafiobtg.currencylist.CurrencyListPresenter
import org.kodein.di.Kodein
import org.kodein.di.generic.bind
import org.kodein.di.generic.instance
import org.kodein.di.generic.singleton

val presentersModule = Kodein.Module("Presenters") {

    bind<CurrencyListContract.Presenter>() with singleton {
        CurrencyListPresenter(instance())
    }

    bind<CurrencyConverterContract.Presenter>() with singleton {
        CurrencyConverterPresenter(instance())
    }

}