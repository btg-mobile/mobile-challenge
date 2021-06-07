package br.com.vicentec12.mobilechallengebtg.di

import br.com.vicentec12.mobilechallengebtg.ui.currencies.di.CurrenciesComponent
import br.com.vicentec12.mobilechallengebtg.ui.home.di.HomeComponent
import dagger.Module

@Module(subcomponents = [HomeComponent::class, CurrenciesComponent::class])
abstract class AppModule