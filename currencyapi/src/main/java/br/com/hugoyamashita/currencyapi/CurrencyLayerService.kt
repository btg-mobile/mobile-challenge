package br.com.hugoyamashita.currencyapi

import br.com.hugoyamashita.currencyapi.model.ConversionRateListResponse
import br.com.hugoyamashita.currencyapi.model.CurrencyListResponse
import io.reactivex.Single
import retrofit2.http.GET

interface CurrencyLayerService {

    @GET("/list")
    fun getCurrencies(): Single<CurrencyListResponse>

    @GET("/live")
    fun getConversionRates(): Single<ConversionRateListResponse>

}