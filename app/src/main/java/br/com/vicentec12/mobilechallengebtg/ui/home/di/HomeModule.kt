package br.com.vicentec12.mobilechallengebtg.ui.home.di

import androidx.lifecycle.ViewModel
import br.com.vicentec12.mobilechallengebtg.di.ActivityScope
import br.com.vicentec12.mobilechallengebtg.di.ViewModelKey
import br.com.vicentec12.mobilechallengebtg.ui.home.HomeViewModel
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap

@Module
abstract class HomeModule {

    @Binds
    @IntoMap
    @ViewModelKey(HomeViewModel::class)
    @ActivityScope
    abstract fun bindsHomeViewModel(mViewModel: HomeViewModel): ViewModel

}