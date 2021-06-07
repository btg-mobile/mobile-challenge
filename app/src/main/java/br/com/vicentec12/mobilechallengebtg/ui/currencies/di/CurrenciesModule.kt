package br.com.vicentec12.mobilechallengebtg.ui.currencies.di

import androidx.lifecycle.ViewModel
import br.com.vicentec12.mobilechallengebtg.di.ActivityScope
import br.com.vicentec12.mobilechallengebtg.di.ViewModelKey
import br.com.vicentec12.mobilechallengebtg.ui.currencies.CurrenciesViewModel
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap

@Module
abstract class CurrenciesModule {

    @Binds
    @IntoMap
    @ViewModelKey(CurrenciesViewModel::class)
    @ActivityScope
    abstract fun bindsCurrenciesViewModel(mViewModel: CurrenciesViewModel): ViewModel

}