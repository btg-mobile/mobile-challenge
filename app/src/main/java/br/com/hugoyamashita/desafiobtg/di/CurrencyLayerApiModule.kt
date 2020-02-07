package br.com.hugoyamashita.desafiobtg.di

import br.com.hugoyamashita.currencyapi.CurrencyLayerApi
import org.kodein.di.Kodein
import org.kodein.di.generic.bind
import org.kodein.di.generic.singleton

internal val currencyLayerApiModule = Kodein.Module("currencyLayerApiModule") {

    bind<CurrencyLayerApi>() with singleton { CurrencyLayerApi.instance }

}