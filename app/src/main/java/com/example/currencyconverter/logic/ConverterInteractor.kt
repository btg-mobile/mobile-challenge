package com.example.currencyconverter.logic

import android.content.Intent
import android.util.Log
import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.infrastructure.database.CurrenciesDatabase
import com.example.currencyconverter.infrastructure.network.CurrencyAPIService
import com.example.currencyconverter.infrastructure.network.ListRetrofitResponse
import com.example.currencyconverter.infrastructure.network.LiveRetrofitResponse
import com.example.currencyconverter.presentation.converter.ConverterView
import com.example.currencyconverter.presentation.converter.ErrorTreatmentView
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers

class ConverterInteractor (val converterView : ConverterView,
                           val errorTreatmentView : ErrorTreatmentView,
                           val database: CurrenciesDatabase,
                           val compositeDisposable: CompositeDisposable) {

    val ORIGINAL_REQUEST_CODE = 101
    val CONVERTED_REQUEST_CODE = 102

    var originalCurrency : Currency? = null
    var convertedCurrency : Currency? = null
    var originalValue : Double? = null

    fun refreshCurrencies() {
        //first call get the currencies symbols and names
        compositeDisposable.add(
            CurrencyAPIService.create().getCurrencyList()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({

                val listResponse = it

                //second call to get the quotes for all the currencies
                compositeDisposable.add(
                    CurrencyAPIService.create().getLiveQuotes()
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ liveResponse ->
                        val currencyList = toCurrencyList(listResponse, liveResponse)
                        saveToDatabase(currencyList)
                    }, {
                        throwError("Network error")
                    })
                )

            }, {
                throwError("Network error")
            })
        )
    }

    fun toCurrencyList(listResponse: ListRetrofitResponse, liveResponse: LiveRetrofitResponse) : List<Currency> {
        val currencies = listResponse.currencies.toList()
        val quotes = liveResponse.quotes.toList()

        return currencies.map{

            var price = 0.0

            quotes.find { value ->
                value.first == ("USD"+it.first)
            }?.apply { price = this.second }

            Currency(
                symbol =  it.first,
                name = it.second,
                quote = price
            )
        }
    }

    fun saveToDatabase(list : List<Currency>) {
        list.forEach { database.currencyDao.insertCurrency(it) }
        Log.i("Currencies persisted!", " OK")
    }

    fun treatActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        when(requestCode) {
            ORIGINAL_REQUEST_CODE -> originalCurrency = data?.getParcelableExtra("currency")
            CONVERTED_REQUEST_CODE -> convertedCurrency = data?.getParcelableExtra("currency")
        }
    }

    fun openListForCurrencySelection(requestCode: Int) {
        converterView.showCurrencyList(requestCode)
    }

    fun selectOriginalCurrency() {
        openListForCurrencySelection(ORIGINAL_REQUEST_CODE)
    }

    fun selectTargetCurrency() {
        openListForCurrencySelection(CONVERTED_REQUEST_CODE)
    }

    private fun allValuesFullfilled() : Boolean {
        if (originalValue == null) {
            throwError("Fill the original Value field")
            return false
        }
        if (originalCurrency == null) {
            throwError("Select the original currency")
            return false
        }
        if (convertedCurrency == null) {
            throwError("Select the target currency of the conversion")
            return false
        }
        return true
    }

    fun convert() {
        if(allValuesFullfilled()) {
            val finalValue = calculateConvertedValue()
            converterView.setConvertedValueText(String.format("%.2f", finalValue))
        }
    }

    fun calculateConvertedValue() : Double = originalValue!! * convertedCurrency!!.quote / originalCurrency!!.quote

    fun throwError(message : String) {
        errorTreatmentView.showErrorMessage(message)
    }
}