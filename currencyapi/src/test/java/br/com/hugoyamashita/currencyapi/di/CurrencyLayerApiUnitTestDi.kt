package br.com.hugoyamashita.currencyapi.di

import br.com.hugoyamashita.currencyapi.CurrencyLayerApi
import br.com.hugoyamashita.currencyapi.exception.CurrencyApiException
import br.com.hugoyamashita.currencyapi.model.ConversionRate
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
     * Mocks a currency list request that returns 3 fixed currencies.
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
     * Mocks a currency list request that generates an error.
     */
    bind<CurrencyLayerApi>("apiWithCurrencyRequestError") with provider {
        mockk<CurrencyLayerApi> {
            every { getCurrencyList() } returns Single.create {
                it.onError(CurrencyApiException("Mocked error", Throwable()))
            }
        }
    }

    /**
     * Mocks a conversion rate list request that returns 2 fixed conversion rates.
     */
    bind<CurrencyLayerApi>("apiWithFixed2ConversionRates") with provider {
        mockk<CurrencyLayerApi> {
            every { getConversionRateList() } returns Single.just(
                listOf(
                    ConversionRate("USD", "BRL", 4.26),
                    ConversionRate("USD", "EUR", 0.91)
                )
            )
        }
    }

    /**
     * Mocks a currency conversion list request that generates an error.
     */
    bind<CurrencyLayerApi>("apiWithConversionRateRequestError") with provider {
        mockk<CurrencyLayerApi> {
            every { getCurrencyList() } returns Single.create {
                it.onError(CurrencyApiException("Mocked error", Throwable()))
            }
        }
    }

}