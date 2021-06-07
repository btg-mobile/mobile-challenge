package br.com.vicentec12.mobilechallengebtg.data.source.remote

import br.com.vicentec12.mobilechallengebtg.data.source.remote.service.CurrenciesService
import br.com.vicentec12.mobilechallengebtg.data.source.remote.service.QuotesService
import dagger.Module
import dagger.Provides
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit
import javax.inject.Singleton

@Module
object RemoteModule {

    private const val BASE_URL = "https://btg-mobile-challenge.herokuapp.com/"

    @Provides
    @Singleton
    @JvmStatic
    fun provideRetrofit(mOkHttpClient: OkHttpClient): Retrofit = Retrofit.Builder()
        .addConverterFactory(GsonConverterFactory.create())
        .client(mOkHttpClient)
        .baseUrl(BASE_URL)
        .build()

    @Provides
    @Singleton
    @JvmStatic
    fun provideOkHttpClient(): OkHttpClient {
        val mInterceptor = HttpLoggingInterceptor()
        mInterceptor.level = HttpLoggingInterceptor.Level.BODY
        return OkHttpClient.Builder().addInterceptor(mInterceptor)
            .connectTimeout(100, TimeUnit.SECONDS)
            .readTimeout(100, TimeUnit.SECONDS).build()
    }

    @Provides
    @Singleton
    @JvmStatic
    fun provideCurrenciesService(mRetrofit: Retrofit): CurrenciesService =
        mRetrofit.create(CurrenciesService::class.java)

    @Provides
    @Singleton
    @JvmStatic
    fun provideQuotesService(mRetrofit: Retrofit): QuotesService =
        mRetrofit.create(QuotesService::class.java)

}