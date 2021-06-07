package br.com.vicentec12.mobilechallengebtg.data.source.data_source.currencies

import br.com.vicentec12.mobilechallengebtg.data.source.local.Local
import br.com.vicentec12.mobilechallengebtg.data.source.remote.Remote
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class CurrenciesDataSourceModule {

    @Singleton
    @Binds
    abstract fun bindsCurrenciesRepository(mRepository: CurrenciesRepository): CurrenciesDataSource

    @Singleton
    @Binds
    @Remote
    abstract fun bindsCurrenciesRemoteDataSource(mRemoteDataSource: CurrenciesRemoteDataSource): CurrenciesDataSource

    @Singleton
    @Binds
    @Local
    abstract fun bindsCurrenciesLocalDataSource(mLocalDataSource: CurrenciesLocalDataSource): CurrenciesDataSource

}