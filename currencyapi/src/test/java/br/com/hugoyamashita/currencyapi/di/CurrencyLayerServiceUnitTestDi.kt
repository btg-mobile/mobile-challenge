package br.com.hugoyamashita.currencyapi.di

import br.com.hugoyamashita.currencyapi.CurrencyLayerService
import br.com.hugoyamashita.currencyapi.model.CurrencyListResponse
import io.mockk.every
import io.mockk.mockk
import io.reactivex.Single
import org.kodein.di.Kodein
import org.kodein.di.generic.bind
import org.kodein.di.generic.provider

internal val currencyLayerServiceUnitTestDiModule = Kodein.Module("UnitTestCurrencyLayerService") {

    /**
     * Mocks a successful request with some currencies.
     */
    bind<CurrencyLayerService>("serviceSuccessfulRequest") with provider {
        mockk<CurrencyLayerService> {
            every { getCurrencies() } returns Single.just(
                CurrencyListResponse(
                    true,
                    "some terms",
                    "some privacy",
                    mapOf(
                        "BRL" to "Real",
                        "EUR" to "Euro",
                        "USD" to "Dólar norte americano"
                    )
                )
            )
        }
    }

    /**
     * Mocks an unsuccessful request.
     */
    bind<CurrencyLayerService>("serviceUnsuccessfulRequest") with provider {
        mockk<CurrencyLayerService> {
            every { getCurrencies() } returns Single.just(
                CurrencyListResponse(
                    false,
                    "some terms",
                    "some privacy",
                    mapOf(
                        "BRL" to "Real",
                        "EUR" to "Euro",
                        "USD" to "Dólar norte americano"
                    )
                )
            )
        }
    }

    /**
     * Mocks a request that returns 3 fixed currencies.
     */
    bind<CurrencyLayerService>("serviceRequestWithNoCurrencies") with provider {
        mockk<CurrencyLayerService> {
            every { getCurrencies() } returns Single.just(
                CurrencyListResponse(true, "some terms", "some privacy", mapOf())
            )
        }
    }

}