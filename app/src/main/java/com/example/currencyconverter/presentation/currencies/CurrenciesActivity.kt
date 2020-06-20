package com.example.currencyconverter.presentation.currencies

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.currencyconverter.R
import com.example.currencyconverter.entity.Currency
import kotlinx.android.synthetic.main.activity_currencies.*

class CurrenciesActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currencies)


        currenciesRecyclerView.layoutManager = LinearLayoutManager(this)

        var mock = ArrayList<Currency>()
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        mock.add(Currency("USD", "American Dollar", 12.90))
        currenciesRecyclerView.adapter = CurrencyAdapter(this, mock)
    }
}
