package br.com.daccandido.currencyconverterapp.ui.convertcurrency

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.lifecycle.Observer
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.model.Currency
import br.com.daccandido.currencyconverterapp.data.model.KEY_CURRENCIES
import br.com.daccandido.currencyconverterapp.data.model.KEY_DOLLAR
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.extensions.formatCurrency
import br.com.daccandido.currencyconverterapp.ui.base.BaseActivity
import br.com.daccandido.currencyconverterapp.ui.listcurrency.ListCurrencyActivity
import br.com.daccandido.currencyconverterapp.utils.safeLet
import kotlinx.android.synthetic.main.activity_convert_currency.*

class ConvertCurresncyActivity: BaseActivity(), View.OnClickListener{

    private lateinit var viewModel: ConvertCurresncyViewModel

    private val codeFrom  = 100
    private val codeTo = 101

    private var currencyFromCode: String = "BRL"
    private var currencyToCode: String = "USD"

    private var currencyFromName = "Brazilian Real"
    private var currencyToName = "United States Dollar"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_convert_currency)

        viewModel = ConvertCurresncyViewModel
            .ViewModelFactory(CurrencyData())
            .create(ConvertCurresncyViewModel::class.java)

        currencyCodeFrom.text = currencyFromCode
        currencyCodeTo.text = currencyToCode

        currencyNameFrom.text = currencyFromName
        currencyNameTo.text = currencyToName

        setObserve()

    }

    override fun onStart() {
        super.onStart()
        llCurrencyFrom.setOnClickListener(this)
        llCurrencyTo.setOnClickListener(this)
        btConvert.setOnClickListener(this)
    }

    override fun onClick(view: View?) {
        view?.let {
            when(it.id) {
                llCurrencyFrom?.id ->{
                    Intent(this, ListCurrencyActivity::class.java).apply {
                        startActivityForResult(this, codeFrom)
                    }
                }
                llCurrencyTo?.id-> {
                    Intent(this, ListCurrencyActivity::class.java).apply {
                        startActivityForResult(this, codeTo)
                    }
                }
                btConvert.id -> {
                    convertValue()
                }
                else -> {}
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?) {
        intent?.let {  data ->
            super.onActivityResult(requestCode, resultCode, data)
            if (requestCode == codeFrom) {
                if (resultCode == Activity.RESULT_OK) {
                    data.getParcelableExtra<Currency>(KEY_CURRENCIES)?.let{ currency ->
                        currencyCodeFrom?.text = currency.code
                        currencyNameFrom?.text = currency.name
                        currencyFromCode = currency.code
                    }
                }
            } else {
                if (resultCode == Activity.RESULT_OK) {
                    data.getParcelableExtra<Currency>(KEY_CURRENCIES)?.let{ currency ->
                        currencyCodeTo?.text = currency.code
                        currencyNameTo?.text = currency.name
                        currencyToCode = currency.code
                    }
                }
            }
        }
    }

    private fun setObserve () {
        viewModel.quotes.observe(this, Observer { quote ->
            if (currencyToCode == KEY_DOLLAR) {
                val sourceValue = quote.quotes["$KEY_DOLLAR$currencyFromCode"]
                sourceValue?.let {
                    val valueConverted = edValueForConvert.text.toString().toDouble() * it
                    resultConvert.setText(valueConverted.formatCurrency(currencyToCode))
                }
            } else {
                val valueText = edValueForConvert.text.toString().toDouble()
                val sourceValue = quote.quotes["$KEY_DOLLAR$currencyFromCode"]
                val targetValue = quote.quotes["$KEY_DOLLAR$currencyToCode"]

                safeLet(sourceValue, targetValue) { _sourceValue, _targetValue ->
                    val sourceValueConverted = _sourceValue * valueText
                    val targetValueConverted = _targetValue * valueText
                    resultConvert.setText(
                        (sourceValueConverted * targetValueConverted)
                            .formatCurrency(currencyToCode)
                    )
                }
            }
            progressBar2.visibility = View.GONE

        })
    }

    private fun convertValue () {
        if (edValueForConvert.text.isEmpty()) {
            edValueForConvert.error = getString(R.string.field_required)
        } else {
            progressBar2.visibility = View.VISIBLE
            viewModel.getQuote("$currencyToCode,$currencyFromCode")
        }
    }


}