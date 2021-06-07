package br.com.vicentec12.mobilechallengebtg.data.source.local

import android.content.Context
import androidx.room.Room
import dagger.Module
import dagger.Provides
import javax.inject.Singleton

@Module
object LocalModule {

    @Singleton
    @Provides
    fun providesAppDatabase(mContext: Context) =
        Room.databaseBuilder(mContext, AppDatabase::class.java, AppDatabase.DATABASE_NAME).build()

    @Provides
    @Singleton
    fun providesCurrencyDao(mAppDatabase: AppDatabase) = mAppDatabase.getCurrencyDao()

    @Provides
    @Singleton
    fun providesQuoteDao(mAppDatabase: AppDatabase) = mAppDatabase.getQuoteDao()

}