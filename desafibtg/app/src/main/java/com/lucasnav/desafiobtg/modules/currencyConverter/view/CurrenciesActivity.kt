package com.lucasnav.desafiobtg.modules.currencyConverter.view

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.lucasnav.desafiobtg.R
import com.lucasnav.desafiobtg.modules.currencyConverter.adapter.CurrenciesAdapter
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor
import com.lucasnav.desafiobtg.modules.currencyConverter.repository.CurrencyRepository
import com.lucasnav.desafiobtg.modules.currencyConverter.util.CURRENCY_INPUT
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.CurrencyViewmodel
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.CurrencyViewmodelFactory
import kotlinx.android.synthetic.main.activity_currencies.*

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

        currencyViewmodel = ViewModelProvider(
            this,
            CurrencyViewmodelFactory(
                CurrencyInteractor(CurrencyRepository())
            )
        ).get(CurrencyViewmodel::class.java)
    }

    private fun subscribeUI() {
        with(currencyViewmodel) {

            onLoadFinished.observe(this@CurrenciesActivity, Observer {
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
}
