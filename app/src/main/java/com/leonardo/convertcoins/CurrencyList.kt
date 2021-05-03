package com.leonardo.convertcoins

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.leonardo.convertcoins.adapter.CurrencyAdapter
import com.leonardo.convertcoins.config.Constants
import com.leonardo.convertcoins.model.Currency

import kotlinx.android.synthetic.main.activity_currency_list.*

class CurrencyList : AppCompatActivity() {
    // id of the selected button from main
    private var buttonId = 0

    private lateinit var linearLayoutManager: LinearLayoutManager
    private lateinit var currencyAdapter: CurrencyAdapter

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

    private fun initViewElements() {
        linearLayoutManager = LinearLayoutManager(this)
        currencyAdapter = CurrencyAdapter(currenciesList)

        currencyList.layoutManager = linearLayoutManager
        currencyList.adapter = currencyAdapter
        configSearchView()

    }

    private fun configSearchView() {
        currencySearchView.setOnQueryTextListener(object : androidx.appcompat.widget.SearchView.OnQueryTextListener {
            override fun onQueryTextChange(newText: String?): Boolean {
                currencyAdapter.filter.filter(newText)
                return false
            }

            override fun onQueryTextSubmit(query: String?): Boolean {
                return false
            }
        })

        // allows all the search bar to be clickable
        currencySearchView.setOnClickListener { currencySearchView.isIconified = false }
    }

    fun currencySelected(coin: String) {
        intent = Intent()
        intent.putExtra(Constants.INTENT.CURRENCIES, coin)
        setResult(RESULT_OK, intent)
        finish()
    }
}
