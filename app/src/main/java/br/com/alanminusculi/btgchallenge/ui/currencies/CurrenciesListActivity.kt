package br.com.alanminusculi.btgchallenge.ui.currencies

import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.View
import androidx.appcompat.widget.SearchView
import androidx.databinding.DataBindingUtil
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout.OnRefreshListener
import br.com.alanminusculi.btgchallenge.R
import br.com.alanminusculi.btgchallenge.adapters.CurrenciesAdapter
import br.com.alanminusculi.btgchallenge.data.local.models.Currency
import br.com.alanminusculi.btgchallenge.databinding.ActivityCurrenciesListBinding
import br.com.alanminusculi.btgchallenge.services.CurrencyService
import br.com.alanminusculi.btgchallenge.services.CurrencyValueService
import br.com.alanminusculi.btgchallenge.ui.ActivityBase
import java.util.*

class CurrenciesListActivity : ActivityBase(), SearchView.OnQueryTextListener {

    private var searching: Boolean = false
    private var binding: ActivityCurrenciesListBinding? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_currencies_list)
        setUpSwipeRefreshLayout()
        load()
    }

    private fun setUpSwipeRefreshLayout() {
        val swipeRefreshLayout: SwipeRefreshLayout = findViewById(R.id.swiperefresh)
        swipeRefreshLayout.setOnRefreshListener(getOnRefreshListener(swipeRefreshLayout))
    }

    private fun getOnRefreshListener(swipeRefreshLayout: SwipeRefreshLayout): OnRefreshListener {
        return OnRefreshListener {
            sync()
            swipeRefreshLayout.isRefreshing = false
        }
    }

    private fun sync() {
        showProgressDialog()
        Thread {
            try {
                CurrencyService(applicationContext).sync()
                CurrencyValueService(applicationContext).sync()
                dismissProgressDialog()
            } catch (exception: Exception) {
                dismissProgressDialog()
                showAlertDialog(getString(R.string.dialog_title_atencao), exception.message, null)
            } finally {
                load()
            }
        }.start()
    }

    private fun load() {
        showProgressDialog()
        Thread {
            var currencies: List<Currency> = ArrayList<Currency>()
            try {
                currencies = CurrencyService(applicationContext).findAll()
                dismissProgressDialog()
            } catch (exception: Exception) {
                dismissProgressDialog()
                showAlertDialog(getString(R.string.dialog_title_atencao), exception.message, null)
            } finally {
                list(currencies)
            }
        }.start()
    }

    private fun list(currencies: List<Currency>) {
        runOnUiThread {
            if (currencies.size == 0) binding!!.textInfo.setText(R.string.no_currencies_found) else {
                binding!!.textInfo.visibility = View.GONE
                binding!!.listCurrencies.adapter = CurrenciesAdapter(this@CurrenciesListActivity, currencies)
                binding!!.listCurrencies.setOnItemClickListener { parent, view, position, id -> select(view.id) }
            }
        }
    }

    private fun select(id: Int) {
        Thread {
            val currency: Currency = CurrencyService(applicationContext).findById(id)
            runOnUiThread {
                val intent = Intent()
                intent.putExtra(Currency::class.java.name, currency)
                setResult(RESULT_OK, intent)
                finish()
            }
        }.start()
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.currencies_list_menu, menu)
        return true
    }

    override fun onPrepareOptionsMenu(menu: Menu): Boolean {
        val searchView = menu.findItem(R.id.action_search).actionView as SearchView
        searchView.setOnQueryTextListener(this)
        return super.onPrepareOptionsMenu(menu)
    }

    override fun onQueryTextSubmit(query: String): Boolean {
        search(query)
        return false
    }

    override fun onQueryTextChange(newText: String): Boolean {
        if (newText.isEmpty()) {
            load()
            return true
        }
        return false
    }

    private fun search(query: String) {
        if (searching) return
        showProgressDialog()
        Thread {
            searching = true
            var currencies: List<Currency> = ArrayList()
            try {
                currencies = CurrencyService(applicationContext).find(query)
                dismissProgressDialog()
            } catch (exception: Exception) {
                dismissProgressDialog()
                showAlertDialog(getString(R.string.dialog_title_atencao), exception.message, null)
            } finally {
                searching = false
                list(currencies)
            }
        }.start()
    }
}