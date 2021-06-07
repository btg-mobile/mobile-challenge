package br.com.vicentec12.mobilechallengebtg.ui.home.di

import br.com.vicentec12.mobilechallengebtg.di.ActivityScope
import br.com.vicentec12.mobilechallengebtg.ui.home.HomeActivity
import dagger.Subcomponent

@ActivityScope
@Subcomponent(modules = [HomeModule::class])
interface HomeComponent {

    @Subcomponent.Factory
    interface Factory {

        fun create(): HomeComponent

    }

    fun inject(mActivity: HomeActivity)

}