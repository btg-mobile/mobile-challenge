package br.com.hugoyamashita.currencyapi.di

import org.kodein.di.Kodein

internal val unitTestKodein = Kodein {

    extend(kodein)
    import(currencyLayerApiUnitTestDiModule)
    import(currencyLayerServiceUnitTestDiModule)

}