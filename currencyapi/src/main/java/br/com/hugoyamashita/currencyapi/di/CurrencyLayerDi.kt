package br.com.hugoyamashita.currencyapi.di

import br.com.hugoyamashita.currencyapi.BuildConfig
import br.com.hugoyamashita.currencyapi.CurrencyLayerApi
import br.com.hugoyamashita.currencyapi.CurrencyLayerService
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import org.kodein.di.Kodein
import org.kodein.di.generic.bind
import org.kodein.di.generic.instance
import org.kodein.di.generic.provider
import retrofit2.CallAdapter
import retrofit2.Converter
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory

val apiKodein = Kodein {

    bind<Interceptor>("access_key") with provider {
        Interceptor { chain ->
            val original = chain.request()

            val newHttpUrl = original.url()
                .newBuilder()
                .addQueryParameter("access_key", BuildConfig.CURRENCY_LAYER_ACCESS_KEY)
                .build()

            val request = original.newBuilder()
                .url(newHttpUrl)
                .build()

            chain.proceed(request)
        }
    }

    bind<OkHttpClient>("with_access_key") with provider {
        OkHttpClient.Builder()
            .addInterceptor(instance("access_key"))
            .build()
    }

    bind<Converter.Factory>("json") with provider { GsonConverterFactory.create() }

    bind<CallAdapter.Factory>() with provider { RxJava2CallAdapterFactory.create() }

    bind<Retrofit>() with provider {
        Retrofit.Builder()
            .baseUrl(BuildConfig.CURRENCY_LAYER_BASE_URL)
            .addCallAdapterFactory(instance())
            .addConverterFactory(instance("json"))
            .client(instance("with_access_key"))
            .build()
    }

    bind<CurrencyLayerService>() with provider {
        instance<Retrofit>().create(CurrencyLayerService::class.java)
    }

    bind<CurrencyLayerApi>() with provider { CurrencyLayerApi(instance()) }

}