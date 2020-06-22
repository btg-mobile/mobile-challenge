package com.example.currencyconverter.presentation.currencies

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.currencyconverter.R
import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.infrastructure.database.DatabaseInstance
import com.example.currencyconverter.logic.CurrenciesInteractor
import com.example.currencyconverter.presentation.converter.MessageView
import io.reactivex.disposables.CompositeDisposable
import kotlinx.android.synthetic.main.activity_currencies.*

class CurrenciesActivity : AppCompatActivity(), MessageView, CurrencyListView {

    private val compositeDisposable = CompositeDisposable()
    private var currenciesInteractor : CurrenciesInteractor? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currencies)
        currenciesRecyclerView.layoutManager = LinearLayoutManager(this)

        val service = DatabaseInstance()
        service.onCreate()
        currenciesRecyclerView.adapter = CurrencyAdapter(this, ArrayList(service.getCurrencies()))
        service.onDestroy()

        currenciesInteractor = CurrenciesInteractor(this as CurrencyListView)
    }

    fun onCurrencySelected(view: View) {
        val selectedCurrency = view.tag as Currency
        currenciesInteractor?.onCurrencySelected(selectedCurrency)
    }

    override fun finishWithResultingCurrency(currency: Currency) {
        val resultIntent = Intent()
        resultIntent.putExtra("selectedCurrency", currency)
        setResult(Activity.RESULT_OK, resultIntent)
        finish()
    }

    override fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }

    override fun onDestroy() {
        compositeDisposable.dispose()
        currenciesInteractor?.onDestroy()
        super.onDestroy()
    }
}
