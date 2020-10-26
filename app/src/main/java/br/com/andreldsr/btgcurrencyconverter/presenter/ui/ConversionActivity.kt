package br.com.andreldsr.btgcurrencyconverter.presenter.ui

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.lifecycle.observe
import br.com.andreldsr.btgcurrencyconverter.R
import br.com.andreldsr.btgcurrencyconverter.infra.repositories.QuoteRepositoryImpl
import br.com.andreldsr.btgcurrencyconverter.presenter.base.BaseActivity
import br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel.CurrencyConversionViewModel
import kotlinx.android.synthetic.main.activity_conversion.*
import kotlinx.android.synthetic.main.include_toolbar.*
import java.lang.NumberFormatException
import java.text.DecimalFormat
import java.text.NumberFormat

class ConversionActivity : BaseActivity() {
    val viewModel = CurrencyConversionViewModel.ViewModelFactory(QuoteRepositoryImpl.build()).create(
        CurrencyConversionViewModel::class.java
    )
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_conversion)

        setupToolbar(toolbarMain, R.string.conversion_title)

        val nf: NumberFormat = DecimalFormat.getInstance()
        nf.maximumFractionDigits = 2

        val fromText = currency_conversion_from_value
        val toText = currency_conversion_to_value
        toText.isEnabled = false

        val fromLabel = currency_conversion_from_initials
        val toLabel = currency_conversion_to_initials


        viewModel.currencyToValue.observe(this){
            toText.setText(nf.format(it))
        }
        viewModel.currencyFrom.observe(this){
            fromLabel.text = it.initials
        }
        viewModel.currencyTo.observe(this){
            toLabel.text = it.initials
        }
        viewModel.quote.observe(this){
            val fromName = viewModel.currencyFrom.value?.name
            val toName = viewModel.currencyTo.value?.name
            val quoteValue = nf.format(viewModel.quote.value)
            fromText.text = null
            currency_conversion_quote_tv.text = "1 $fromName\n= \n$quoteValue $toName"
        }

        fromText.addTextChangedListener(object :TextWatcher{
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                val fValue = try{s.toString().toFloat()}catch (e: NumberFormatException){0f}
                viewModel.calculate(fValue)
            }
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun afterTextChanged(s: Editable?) {}

        })
        viewModel.loadQuote()
    }

    fun swapCurrencies(view: View){
        viewModel.swapCurrencies()
    }

    fun changeFromCurrency(view: View){
        val currency = viewModel.currencyFrom.value
        val intent = CurrencyListActivity.getStartIntent(this@ConversionActivity, currency!!.initials, currency.name)
        this@ConversionActivity.startActivity(intent)
    }
}