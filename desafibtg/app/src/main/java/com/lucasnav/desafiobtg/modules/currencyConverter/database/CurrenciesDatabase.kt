package com.lucasnav.desafiobtg.modules.currencyConverter.database

import android.annotation.SuppressLint
import android.util.Log
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import io.reactivex.Completable
import io.reactivex.CompletableObserver
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers

class CurrenciesDatabase(
    private val db: CurrenciesDao
) {

    @SuppressLint("CheckResult")
    fun getCurrencies(
        onSuccess: (currencies: List<Currency>) -> Unit,
        onError: (message: String) -> Unit
    ) {

        db.getCurrencies()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({ currencies ->
                currencies?.let {
                    onSuccess(it)
                }
            }, { error ->
                onError(error.message.toString())
            })

    }

    fun saveCurrencies(currencies: List<Currency>) {

        Completable.fromAction {
            db.deleteAndInsert(currencies)
        }.subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread())
            .subscribe(object : CompletableObserver {
                override fun onComplete() {
                    Log.d("SAVE-CURRENCIES", "SALVO COM SUCESSO")
                }

                override fun onSubscribe(d: Disposable) {
                }

                override fun onError(e: Throwable) {
                }
            })
    }
}