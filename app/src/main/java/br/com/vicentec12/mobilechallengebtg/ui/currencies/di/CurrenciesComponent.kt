package br.com.vicentec12.mobilechallengebtg.ui.currencies.di

import br.com.vicentec12.mobilechallengebtg.di.ActivityScope
import br.com.vicentec12.mobilechallengebtg.ui.currencies.CurrenciesActivity
import dagger.Subcomponent

@ActivityScope
@Subcomponent(modules = [CurrenciesModule::class])
interface CurrenciesComponent {

    @Subcomponent.Factory
    interface Factory {

        fun create(): CurrenciesComponent

    }

    fun inject(mActivity: CurrenciesActivity)

}