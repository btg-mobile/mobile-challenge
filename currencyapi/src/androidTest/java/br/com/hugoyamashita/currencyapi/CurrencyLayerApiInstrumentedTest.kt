package br.com.hugoyamashita.currencyapi

import android.util.Log
import androidx.test.ext.junit.runners.AndroidJUnit4
import br.com.hugoyamashita.currencyapi.di.kodein
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import org.hamcrest.CoreMatchers
import org.hamcrest.MatcherAssert
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.kodein.di.generic.instance

@RunWith(AndroidJUnit4::class)
class CurrencyLayerApiInstrumentedTest {

    @Test
    fun myTest() {
        val service: CurrencyLayerService by kodein.instance()

        val list = service.getCurrencies()
        list
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .doOnSuccess {
                Log.i("TESTE", "${it}")
            }
            .doOnError {
                Log.i("TESTE", "ERROR: $it")
            }
            .subscribe()
    }

}