package br.com.vicentec12.mobilechallengebtg.di

import android.content.Context
import br.com.vicentec12.mobilechallengebtg.data.source.data_source.currencies.CurrenciesDataSourceModule
import br.com.vicentec12.mobilechallengebtg.data.source.data_source.quotes.QuotesDataSourceModule
import br.com.vicentec12.mobilechallengebtg.data.source.local.LocalModule
import br.com.vicentec12.mobilechallengebtg.data.source.remote.RemoteModule
import br.com.vicentec12.mobilechallengebtg.ui.currencies.di.CurrenciesComponent
import br.com.vicentec12.mobilechallengebtg.ui.home.di.HomeComponent
import dagger.BindsInstance
import dagger.Component
import javax.inject.Singleton

@Singleton
@Component(
    modules = [
        AppModule::class,
        LocalModule::class,
        RemoteModule::class,
        DispatcherModule::class,
        CurrenciesDataSourceModule::class,
        QuotesDataSourceModule::class
    ]
)
interface AppComponent {

    @Component.Factory
    interface Factory {

        fun create(@BindsInstance mContext: Context): AppComponent

    }

    fun currenciesComponent(): CurrenciesComponent.Factory

    fun homeComponent(): HomeComponent.Factory

}