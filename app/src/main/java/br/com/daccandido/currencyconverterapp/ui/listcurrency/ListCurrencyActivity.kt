package br.com.daccandido.currencyconverterapp.ui.listcurrency

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DefaultItemAnimator
import androidx.recyclerview.widget.LinearLayoutManager
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.database.CurrencyDAO
import br.com.daccandido.currencyconverterapp.data.model.Currency
import br.com.daccandido.currencyconverterapp.data.model.KEY_CURRENCIES
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.ui.base.BaseActivity
import io.realm.OrderedRealmCollection
import io.realm.RealmResults
import kotlinx.android.synthetic.main.activyity_list_currencies.*

class ListCurrencyActivity: BaseActivity(), ClickItemList {

    private lateinit var  viewModel: ListCurrentViewModel
    private lateinit var list: RealmResults<Currency>
    private lateinit var adapter: ListCurrencyAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activyity_list_currencies)

        viewModel = ListCurrentViewModel
            .ViewModelFactory(CurrencyData(), CurrencyDAO())
            .create(ListCurrentViewModel::class.java)

        setObserve()
        getList("code")
        title = "Taxas de câmbio"
    }

    override fun onClick(currency: Currency) {
        val intentResult = Intent()
        intentResult.putExtra(KEY_CURRENCIES, currency)
        setResult(Activity.RESULT_OK, intentResult)
        finish()
    }

    private fun getList (sort:String) {
        list = viewModel.getListLocal(sort)
        if (list.isEmpty()) {
            viewModel.getList()
        } else {
            setUpRecyclerView()
        }
    }

    private fun setObserve() {
        viewModel.listCurrency.observe(this, Observer {
            if (it.currencies.isEmpty()) {
                progressBar3.visibility = View.GONE
                rvList.visibility = View.GONE
                tvError.text = getString(R.string.error_not_exchange_rates)
            } else {
                getList("code")
            }
        })

        viewModel.error.observe(this, Observer {
            progressBar3.visibility = View.GONE
            rvList.visibility = View.GONE
            tvError.text = getString(it)
        })

        viewModel.isLoading.observe(this, Observer {
            if (it) {
                progressBar3.visibility = View.VISIBLE
                rvList.visibility = View.GONE
            } else {
                progressBar3.visibility = View.GONE
                rvList.visibility = View.VISIBLE
            }
        })
    }

    private fun setUpRecyclerView () {
        adapter = ListCurrencyAdapter(list as OrderedRealmCollection<Currency>, this, this)
        rvList.layoutManager = LinearLayoutManager(this)
        rvList.adapter = adapter
        rvList.itemAnimator = DefaultItemAnimator()
    }
}