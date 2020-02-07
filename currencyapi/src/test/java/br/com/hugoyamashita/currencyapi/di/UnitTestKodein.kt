package br.com.hugoyamashita.currencyapi.di

import org.kodein.di.Kodein

internal val unitTestKodein = Kodein {

    extend(apiKodein)
    import(currencyLayerApiUnitTestDiModule)
    import(currencyLayerServiceUnitTestDiModule)

}