package br.com.andreldsr.btgcurrencyconverter.presenter.ui

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.andreldsr.btgcurrencyconverter.R
import br.com.andreldsr.btgcurrencyconverter.infra.repositories.CurrencyRepositoryImpl
import br.com.andreldsr.btgcurrencyconverter.mock.CurrencyMockRepositoryImpl
import br.com.andreldsr.btgcurrencyconverter.presenter.adapter.CurrencyListItemAdapter
import br.com.andreldsr.btgcurrencyconverter.presenter.base.BaseActivity
import br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel.CurrencyListViewModel
import kotlinx.android.synthetic.main.activity_currency_list.*
import kotlinx.android.synthetic.main.include_toolbar.*

class CurrencyListActivity : BaseActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency_list)

        setupToolbar(toolbarMain, R.string.currency_list_title, true)

        currency_selected_item_initials.text = intent.extras?.get(INITIALS) as CharSequence?
        currency_selected_item_name.text = intent.extras?.get(NAME) as CharSequence?

        val viewModel: CurrencyListViewModel = CurrencyListViewModel.ViewModelFactory(
            CurrencyMockRepositoryImpl.build()).create(CurrencyListViewModel::class.java)

        viewModel.currencyLiveData.observe(this, Observer {
            it.let { currencyList ->
                with(currency_list_recycle_view){
                    layoutManager = LinearLayoutManager(this@CurrencyListActivity, RecyclerView.VERTICAL, false)
                    setHasFixedSize(true)
                    adapter = CurrencyListItemAdapter(currencyList){

                    }
                }
            }
        })
        viewModel.getCurrencies()
    }

    companion object {
        private const val INITIALS = "INITIALS"
        private const val NAME = "NAME"

        fun getStartIntent(context: Context, initials: String, name: String): Intent {
            return Intent(context, CurrencyListActivity::class.java).apply {
                putExtra(INITIALS, initials)
                putExtra(NAME, name)
            }
        }
    }

}