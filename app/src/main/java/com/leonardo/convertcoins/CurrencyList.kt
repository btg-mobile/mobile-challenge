package com.leonardo.convertcoins

import com.leonardo.convertcoins.config.RecyclerViewEmptyObserver
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.leonardo.convertcoins.adapters.CurrencyAdapter
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

    /**
     * Init view elements and set needed listeners
     */
    private fun initViewElements() {
        linearLayoutManager = LinearLayoutManager(this)
        currencyAdapter = CurrencyAdapter(currenciesList)

        // set layout manager and adapter
        currency_recycler_view.layoutManager = linearLayoutManager
        currency_recycler_view.adapter = currencyAdapter
        // config adapter to check if list is empty
        val rvEmptyObserver = RecyclerViewEmptyObserver(currency_recycler_view, empty_currency_recycler_view)
        currencyAdapter.registerAdapterDataObserver(rvEmptyObserver)

        configSearchView()
    }

    /**
     * Config search view setting the full horizontal bar clickable triggering adapter.filter
     * each time user types a new value on it
     */
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

    /**
     * Triggered when user clicks on a list item saving needed values inside intent and return it
     * to main activity with setResult() and finish()
     * @param coin selected  as AUD
     */
    fun currencySelected(coin: String) {
        intent = Intent()
        intent.putExtra("ID", buttonId)
        intent.putExtra("CURRENCIES", coin)
        setResult(RESULT_OK, intent)
        finish()
    }
}
