package com.btg.converter.presentation.view.currency.list

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.databinding.DataBindingUtil
import com.btg.converter.R
import com.btg.converter.databinding.ActivityListCurrenciesBinding
import com.btg.converter.domain.entity.currency.Currency
import com.btg.converter.domain.entity.currency.CurrencyList
import com.btg.converter.presentation.util.base.BaseActivity
import com.btg.converter.presentation.util.base.BaseViewModel
import com.btg.converter.presentation.util.extension.observe
import org.koin.android.viewmodel.ext.android.viewModel

class ListCurrenciesActivity : BaseActivity() {

    override val baseViewModel: BaseViewModel get() = _viewModel
    private val _viewModel: ListCurrenciesViewModel by viewModel()

    private lateinit var binding: ActivityListCurrenciesBinding
    private lateinit var adapter: ListCurrenciesAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_list_currencies)
        setupAdapter()
    }

    override fun subscribeUi() {
        super.subscribeUi()
        _viewModel.currencyList.observe(this, ::onCurrencyListReceived)
        _viewModel.placeholder.observe(this) { binding.placeholderView.setPlaceholder(it) }
    }

    private fun setupAdapter() {
        adapter = ListCurrenciesAdapter(::onCurrencySelected)
        binding.recyclerViewCurrencies.adapter = adapter
    }

    private fun onCurrencyListReceived(currencyList: CurrencyList?) {
        currencyList?.currencies?.let(adapter::submitList)
    }

    private fun onCurrencySelected(currency: Currency) {
        val intent = Intent()
        intent.putExtra(CURRENCY_EXTRA, currency)
        setResult(RESULT_OK, intent)
        finish()
    }

    companion object {
        const val CURRENCY_EXTRA = "CURRENCY_EXTRA"

        fun createIntent(context: Context) = Intent(context, ListCurrenciesActivity::class.java)
    }
}