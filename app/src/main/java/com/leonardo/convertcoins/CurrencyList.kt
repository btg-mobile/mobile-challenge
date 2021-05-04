package com.leonardo.convertcoins

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.leonardo.convertcoins.adapters.CurrencyAdapter
import com.leonardo.convertcoins.config.Constants
import com.leonardo.convertcoins.models.Currency

import kotlinx.android.synthetic.main.activity_currency_list.*

class CurrencyList : AppCompatActivity() {
    // id of the selected button from main
    private var buttonId = 0

    private lateinit var linearLayoutManager: LinearLayoutManager
    private lateinit var currencyAdapter: CurrencyAdapter

    private val currenciesList = ArrayList<Currency>();

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency_list)

        buttonId = intent.extras?.getInt("ID")!!
        val currencies = intent.extras?.getSerializable("CURRENCIES") as HashMap<String, String>

        currencies.forEach { currency ->
            currenciesList.add(Currency(currency.key, currency.value))
        }
        currenciesList.sort()
        initViewElements()
    }

    private fun initViewElements() {
        linearLayoutManager = LinearLayoutManager(this)
        currencyAdapter = CurrencyAdapter(currenciesList)

        currencyList.layoutManager = linearLayoutManager
        currencyList.adapter = currencyAdapter
        configSearchView()
    }

    private fun configSearchView() {
        // allows all the search bar to be clickable
        currencySearchView.setOnClickListener { currencySearchView.isIconified = false }
        currencySearchView.setOnQueryTextListener(object : androidx.appcompat.widget.SearchView.OnQueryTextListener {
            override fun onQueryTextChange(newText: String?): Boolean {
                currencyAdapter.filter.filter(newText)
                return false
            }

            override fun onQueryTextSubmit(query: String?): Boolean {
                return false
            }
        })
    }

    fun currencySelected(coin: String) {
        intent = Intent()
        intent.putExtra("ID", buttonId)
        intent.putExtra("CURRENCIES", coin)
        setResult(RESULT_OK, intent)
        finish()
    }
}
