package br.com.hugoyamashita.currencyapi

import br.com.hugoyamashita.currencyapi.di.apiKodein
import br.com.hugoyamashita.currencyapi.exception.CurrencyApiException
import br.com.hugoyamashita.currencyapi.model.ConversionRate
import br.com.hugoyamashita.currencyapi.model.Currency
import io.reactivex.Single
import io.reactivex.schedulers.Schedulers
import org.kodein.di.generic.instance


class CurrencyLayerApi(private val service: CurrencyLayerService) {

    companion object {

        /**
         * Simple Singleton of the API instance.
         * This is not a lazy load!
         */
        val instance: CurrencyLayerApi by apiKodein.instance()

    }

    /**
     * Returns a Single with the list of currencies accepted by the API.
     */
    fun getCurrencyList(): Single<List<Currency>> =
        Single.create<List<Currency>> { emitter ->
            val response = service.getCurrencies()

            response
                .subscribeOn(Schedulers.io())
                .doOnSuccess {
                    // Emits an error if there is something wrong with the request
                    if (!it.success || it.currencies.isEmpty()) {
                        emitter.onError(CurrencyApiException("Failed to request currencies"))

                        return@doOnSuccess
                    }

                    // Emits a success event with the sorted currencies
                    emitter.onSuccess(it.currencies
                        .map { currency ->
                            Currency(currency.key, currency.value)
                        }
                        .sortedBy { currency -> currency.symbol })
                }
                .doOnError { throwable ->
                    throw CurrencyApiException(throwable)
                }
                .subscribe()
        }

    /**
     * Returns a Single with the list of conversion rates accepted by the API.
     */
    fun getConversionRateList(): Single<List<ConversionRate>> =
        Single.create<List<ConversionRate>> { emitter ->
            val response = service.getConversionRates()

            response
                .subscribeOn(Schedulers.io())
                .doOnSuccess {
                    // Emits an error if there is something wrong with the request
                    if (!it.success || it.quotes.isEmpty()) {
                        emitter.onError(CurrencyApiException("Failed to request conversion rates"))

                        return@doOnSuccess
                    }

                    // Emits a success event with the conversion rates
                    emitter.onSuccess(it.quotes
                        .map { quote ->
                            ConversionRate(quote.key.substring(0, 3), quote.key.substring(3), quote.value)
                        })
                }
                .doOnError { throwable ->
                    throw CurrencyApiException(throwable)
                }
                .subscribe()
        }

}