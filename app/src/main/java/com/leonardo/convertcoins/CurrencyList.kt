package com.leonardo.convertcoins

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.leonardo.convertcoins.adapter.CurrencyAdapter
import com.leonardo.convertcoins.config.Constants
import com.leonardo.convertcoins.model.Currency

class CurrencyList : AppCompatActivity() {
    // id of the selected button from main
    private var buttonId = 0

    private lateinit var linearLayoutManager: LinearLayoutManager
    private lateinit var currencyAdapter: CurrencyAdapter
    private lateinit var currencyRecyclerView: RecyclerView

    private lateinit var currenciesList: ArrayList<Currency>;

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency_list)

        buttonId = intent.extras?.getInt(Constants.INTENT.ID)!!
        val currencies = intent.extras?.getSerializable(Constants.INTENT.CURRENCIES) as HashMap<String, String>

        currenciesList = ArrayList<Currency>()
        currencies.forEach { currency -> currenciesList.add(Currency(currency.key, currency.value)) }
        currenciesList.sort()

        initViewElements()
        println("CURRENCY LIST")
        println(currencies)
        println("BUTTON_ID")
        println(buttonId)
    }

    fun initViewElements() {
        linearLayoutManager = LinearLayoutManager(this)
        currencyAdapter = CurrencyAdapter(currenciesList)

        currencyRecyclerView = findViewById(R.id.currencyList)
        currencyRecyclerView.layoutManager = linearLayoutManager
        currencyRecyclerView.adapter = currencyAdapter

    }

    fun currencySelected(view: View) {
        intent = Intent()
        intent.putExtra("currency", "AUD")
        setResult(RESULT_OK, intent)
        finish()
    }
}