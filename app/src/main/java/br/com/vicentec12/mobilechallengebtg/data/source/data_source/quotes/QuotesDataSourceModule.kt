package br.com.vicentec12.mobilechallengebtg.data.source.data_source.quotes

import br.com.vicentec12.mobilechallengebtg.data.source.local.Local
import br.com.vicentec12.mobilechallengebtg.data.source.remote.Remote
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class QuotesDataSourceModule {

    @Singleton
    @Binds
    abstract fun bindsQuotesRepository(mRepository: QuotesRepository): QuotesDataSource

    @Singleton
    @Binds
    @Remote
    abstract fun bindsQuotesRemoteDataSource(mRemoteDataSource: QuotesRemoteDataSource): QuotesDataSource

    @Singleton
    @Binds
    @Local
    abstract fun bindsQuotesLocalDataSource(mLocalDataSource: QuotesLocalDataSource): QuotesDataSource

}