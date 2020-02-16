package io.felipeandrade.currencylayertest.ui.currency.selection

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import io.felipeandrade.currencylayertest.R
import kotlinx.android.synthetic.main.activity_simple_list.*
import org.koin.android.ext.android.inject
import org.koin.androidx.viewmodel.ext.android.viewModel

class CurrencySelectionActivity : AppCompatActivity() {

    companion object {
        const val SELECTED_CURRENCY_ID = "SELECTED_CURRENCY_ID"
    }

    private val viewModel: CurrencySelectionViewModel by viewModel()
    private val adapter: CurrencyListAdapter by inject()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_simple_list)
        initRecyclerView()
        observeLiveData()
    }

    private fun initRecyclerView() {
        rv_list.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        adapter.onItemClicked = { viewModel.itemClicked(it) }
        rv_list.adapter = adapter
    }

    private fun observeLiveData() {

        viewModel.characterList.observe(this, Observer {
            adapter.setData(it)
        })

        viewModel.selectedCurrency.observe(this, Observer {
            it?.let { currency ->
                val intent = Intent()
                intent.putExtra(SELECTED_CURRENCY_ID, currency.id)
                setResult(Activity.RESULT_OK, intent)
                finish()
            }
        })
    }
}