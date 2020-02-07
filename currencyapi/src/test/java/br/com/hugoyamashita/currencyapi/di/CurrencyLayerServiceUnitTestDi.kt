package br.com.hugoyamashita.currencyapi.di

import br.com.hugoyamashita.currencyapi.CurrencyLayerService
import br.com.hugoyamashita.currencyapi.model.ConversionRateListResponse
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
    bind<CurrencyLayerService>("serviceSuccessfulCurrenciesRequest") with provider {
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
    bind<CurrencyLayerService>("serviceUnsuccessfulCurrenciesRequest") with provider {
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

    /**
     * Mocks a successful request with some conversion rates.
     */
    bind<CurrencyLayerService>("serviceSuccessfulConversionRatesRequest") with provider {
        mockk<CurrencyLayerService> {
            every { getConversionRates() } returns Single.just(
                ConversionRateListResponse(
                    true,
                    "some terms",
                    "some privacy",
                    123456L,
                    "USD",
                    mapOf(
                        "USDBRL" to 4.26,
                        "USDEUR" to 0.91
                    )
                )
            )
        }
    }

    /**
     * Mocks a successful request with some conversion rates.
     */
    bind<CurrencyLayerService>("serviceRequestWithNoConversionRates") with provider {
        mockk<CurrencyLayerService> {
            every { getConversionRates() } returns Single.just(
                ConversionRateListResponse(
                    true,
                    "some terms",
                    "some privacy",
                    123456L,
                    "USD",
                    mapOf()
                )
            )
        }
    }

}