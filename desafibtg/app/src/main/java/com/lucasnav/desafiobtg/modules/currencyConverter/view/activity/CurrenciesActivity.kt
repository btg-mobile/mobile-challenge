package com.lucasnav.desafiobtg.modules.currencyConverter.view.activity

import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SearchView
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.lucasnav.desafiobtg.R
import com.lucasnav.desafiobtg.modules.currencyConverter.adapter.CurrenciesAdapter
import com.lucasnav.desafiobtg.modules.currencyConverter.database.CurrenciesDatabase
import com.lucasnav.desafiobtg.modules.currencyConverter.database.CurrenciesDatabaseFactory
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor
import com.lucasnav.desafiobtg.modules.currencyConverter.repository.CurrencyRepository
import com.lucasnav.desafiobtg.modules.currencyConverter.util.CURRENCY_INPUT
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.CurrencyViewmodel
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.viewmodelFactory.CurrencyViewmodelFactory
import kotlinx.android.synthetic.main.activity_currencies.*
import kotlinx.android.synthetic.main.activity_currencies.view.*

class CurrenciesActivity : AppCompatActivity() {

    private lateinit var currencyViewmodel: CurrencyViewmodel
    private lateinit var currenciesAdapter: CurrenciesAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currencies)

        currenciesAdapter = CurrenciesAdapter(clickListener = {
            intent.putExtra(CURRENCY_INPUT, it)
            setResult(RESULT_OK, intent)
            finish()
        })

        configSearchView()

        setupRecyclerView()

        setupViewmodel()

        subscribeUI()

        currencyViewmodel.getCurrencies()
    }

    private fun setupRecyclerView() {
        with(recyclerviewCurrencies) {
            setHasFixedSize(true)
            adapter = currenciesAdapter
        }
    }

    private fun setupViewmodel() {

        val currenciesDb = CurrenciesDatabaseFactory.create(this).currenciesDao()
        val quotesDb = CurrenciesDatabaseFactory.create(this).quotesDao()
        val db = CurrenciesDatabase(currenciesDb, quotesDb)

        currencyViewmodel = ViewModelProvider(
            this,
            CurrencyViewmodelFactory(
                CurrencyInteractor(CurrencyRepository(db, this))
            )
        ).get(CurrencyViewmodel::class.java)
    }

    private fun subscribeUI() {
        with(currencyViewmodel) {

            onLoadFinished.observe(this@CurrenciesActivity, Observer {
                progressBar.visibility = View.GONE
            })

            onError.observe(this@CurrenciesActivity, Observer { errorMessage ->
                android.widget.Toast.makeText(
                    applicationContext,
                    "Nao foi possivel carregar",
                    android.widget.Toast.LENGTH_SHORT
                )
                    .show()

                android.util.Log.e("GET-CURRENCIES-ERROR", "error: $errorMessage")
            })

            currencies.observe(this@CurrenciesActivity, Observer { newCurrencies ->
                currenciesAdapter.update(newCurrencies)
            })
        }
    }

    private fun configSearchView() {
        toolbar.searchview.setOnQueryTextListener(onQueryTextListener)
    }

    private val onQueryTextListener = object : SearchView.OnQueryTextListener,
        android.widget.SearchView.OnQueryTextListener {
        override fun onQueryTextSubmit(query: String): Boolean {
            return true
        }

        override fun onQueryTextChange(query: String): Boolean {
            if (query.trim() == "") {
                currencyViewmodel.getCurrencies()
            } else {
                currencyViewmodel.searchCurrencies(query)
            }
            return true
        }
    }
}
