package br.net.easify.currencydroid.di.module

import android.app.Application
import br.net.easify.currencydroid.api.CurrencyService
import br.net.easify.currencydroid.api.QuoteService
import br.net.easify.currencydroid.database.AppDatabase
import dagger.Module
import dagger.Provides
import javax.inject.Singleton

@Module
class AppModule(private var application: Application) {

    @Provides
    @Singleton
    fun providesApplication(): Application {
        return application
    }

    @Provides
    @Singleton
    fun providesAppDatabase(application: Application): AppDatabase {
        return AppDatabase.getAppDataBase(application)
    }

    @Provides
    fun providesCurrencyService(): CurrencyService {
        return CurrencyService()
    }

    @Provides
    fun providesQuoteService(): QuoteService {
        return QuoteService()
    }
}