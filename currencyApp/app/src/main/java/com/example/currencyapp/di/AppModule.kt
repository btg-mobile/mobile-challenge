package com.example.currencyapp.di

import androidx.room.Room
import com.example.currencyapp.database.AppDatabase
import com.example.currencyapp.network.provideCurrencyListService
import com.example.currencyapp.network.provideCurrencyLiveService
import com.example.currencyapp.network.provideRetrofit
import com.example.currencyapp.repository.HomeRepository
import com.example.currencyapp.repository.ListRepository
import com.example.currencyapp.ui.fragment.currencyList.CurrencyListViewModel
import com.example.currencyapp.ui.fragment.home.HomeViewModel
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module

val networkModule = module {
    factory { provideCurrencyLiveService(get()) }
    factory { provideCurrencyListService(get()) }
    single { provideRetrofit() }
}

val databaseModule = module {
    single {
        Room.databaseBuilder(
                get(),
                AppDatabase::class.java,
                //BuildConfig.DATABASE_NAME
                "currency-database"
        ).build()
    }
}

val resourceModule = module {
    single { get<AppDatabase>().currencyDao() }

    single { ListRepository(get()) }

    single { HomeRepository(get(), get(), get()) }
}

val viewModelModule = module {
    viewModel {
        HomeViewModel(get())
    }
    viewModel {
        CurrencyListViewModel(get())
    }
}

