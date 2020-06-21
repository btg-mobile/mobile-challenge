package com.br.btgteste.presentation.list

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.ProgressBar
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SearchView
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.RecyclerView
import com.br.btgteste.R
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.infrastructure.isVisible
import org.koin.android.viewmodel.ext.android.viewModel


class ListCurrencyActivity : AppCompatActivity(), ListCurrencyAdapter.OnListClickItem {

    private val rvCurrencies: RecyclerView by lazy { findViewById<RecyclerView>(R.id.CurrenciesRecyclerView) }
    private val svCurrencies: SearchView by lazy { findViewById<SearchView>(R.id.svFilterList) }
    private val pbList: ProgressBar by lazy { findViewById<ProgressBar>(R.id.pbList) }

    private val viewModel: ListCurrencyViewModel by viewModel()
    private  val adapter: ListCurrencyAdapter by lazy { ListCurrencyAdapter(this) }

    private lateinit var listCurrencies: List<Currency>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list_currency)
        viewModel.getCurrencies()
        observeCurrenciesResponse()
        setupListener()
        setupViews()
    }

    private fun setupViews() {
        val actionbar = supportActionBar
        actionbar?.setDisplayHomeAsUpEnabled(true)
        actionbar?.title = "Listagem de moedas"
    }

    private fun setupListener() {
        svCurrencies.setOnQueryTextListener(object: SearchView.OnQueryTextListener{
            override fun onQueryTextSubmit(query: String): Boolean =
                adapter.updateList(viewModel.performFiltering(query, listCurrencies))

            override fun onQueryTextChange(query: String): Boolean =
                adapter.updateList(viewModel.performFiltering(query, listCurrencies))
        })
        svCurrencies.setOnCloseListener { adapter.updateList(listCurrencies) }
    }

    private fun observeCurrenciesResponse() {
        viewModel.liveDataResponse.observe(this, Observer {
            pbList.isVisible(false)
            if (it is ApiResult.Success) {
                listCurrencies = it.data
                adapter.updateList(listCurrencies)
                rvCurrencies.adapter = adapter
            } else if (it is ApiResult.Error) {

            }
        })
    }

    override fun onSupportNavigateUp(): Boolean {
        onBackPressed()
        return true
    }
    override fun onItemClick(currency: Currency) {
        setResult(Activity.RESULT_OK, Intent().also { it.putExtra(CURRENCY, currency) })
        finish()
    }

    companion object {
        const val CURRENCY = "currency"
    }
}
