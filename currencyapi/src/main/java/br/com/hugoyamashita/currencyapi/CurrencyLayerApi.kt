package br.com.hugoyamashita.currencyapi

import br.com.hugoyamashita.currencyapi.exception.CurrencyApiException
import br.com.hugoyamashita.currencyapi.model.Currency
import io.reactivex.Single
import io.reactivex.schedulers.Schedulers


class CurrencyLayerApi(private val service: CurrencyLayerService) {

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

                    emitter.onSuccess(it.currencies
                        .map { responseCurrency ->
                            Currency(responseCurrency.key, responseCurrency.value)
                        }
                        .sortedBy { currency -> currency.symbol })
                }
                .doOnError { throwable ->
                    throw CurrencyApiException(throwable)
                }
                .subscribe()
        }

}