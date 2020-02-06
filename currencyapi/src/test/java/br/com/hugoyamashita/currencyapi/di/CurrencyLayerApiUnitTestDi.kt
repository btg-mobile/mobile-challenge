package br.com.hugoyamashita.currencyapi.di

import br.com.hugoyamashita.currencyapi.CurrencyLayerApi
import br.com.hugoyamashita.currencyapi.exception.CurrencyApiException
import br.com.hugoyamashita.currencyapi.model.Currency
import io.mockk.every
import io.mockk.mockk
import io.reactivex.Single
import org.kodein.di.Kodein
import org.kodein.di.generic.bind
import org.kodein.di.generic.instance
import org.kodein.di.generic.provider

internal val currencyLayerApiUnitTestDiModule = Kodein.Module("UnitTestCurrencyLayerApi") {

    /**
     * Mocks a request that returns 3 fixed currencies.
     */
    bind<CurrencyLayerApi>("apiWithFixed3Currencies") with provider {
        mockk<CurrencyLayerApi> {
            every { getCurrencyList() } returns Single.just(
                listOf(
                    Currency("BRL", "Real"),
                    Currency("EUR", "Euro"),
                    Currency("USD", "Dólar norte americano")
                )
            )
        }
    }

    /**
     * Mocks a request that generates an error.
     */
    bind<CurrencyLayerApi>("apiWithRequestError") with provider {
        mockk<CurrencyLayerApi> {
            every { getCurrencyList() } returns Single.create {
                it.onError(CurrencyApiException("Mocked error", Throwable()))
            }
        }
    }

    bind<CurrencyLayerApi>("apiWithServiceWithNoCurrencies") with provider {
        CurrencyLayerApi(instance("serviceRequestWithNoCurrencies"))
    }

}