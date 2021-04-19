package com.fernando.currencyexchange.presentation

import android.os.Bundle
import android.widget.*
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import com.fernando.currencyexchange.R
import dagger.hilt.android.AndroidEntryPoint


@AndroidEntryPoint
class CurrencyExchangeActivity : AppCompatActivity() {
    private val mainViewModel by viewModels<CurrencyExchangeViewModel>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency_exchange)
        setObservable()
        setButtonListener()
    }

    private fun setObservable() {
        mainViewModel.exchangesSupported.observe(this, Observer {
            fromSpinnerSetup(it)
            toSpinnerSetup(it)
        })

        mainViewModel.currencyExchanged.observe(this, Observer {
            teste(it)
        })
    }

    private fun teste(currency: String) {
        val text = findViewById<TextView>(R.id.currencyConverted)
        text.text = currency
    }

    private fun fromSpinnerSetup(currencyList: List<String>) {
        val spinner: Spinner = findViewById(R.id.fromSpinner)
        ArrayAdapter(this, android.R.layout.simple_spinner_item, currencyList).also { adapter ->
            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            spinner.adapter = adapter
        }
    }

    private fun toSpinnerSetup(currencyList: List<String>) {
        val spinner: Spinner = findViewById(R.id.toSpinner)
        ArrayAdapter(this, android.R.layout.simple_spinner_item, currencyList).also { adapter ->
            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            spinner.adapter = adapter
        }
    }

    private fun setButtonListener() {
        val editText = findViewById<EditText>(R.id.editText)
        val button = findViewById<Button>(R.id.button)
        val spinnerFrom: Spinner = findViewById(R.id.fromSpinner)
        val spinnerTo: Spinner = findViewById(R.id.fromSpinner)

        button.setOnClickListener {
            val fromText = (spinnerFrom.selectedView as TextView).text.toString()
            val toText = (spinnerTo.selectedView as TextView).text.toString()

            mainViewModel.convert(fromText, toText, editText.editableText.toString())
        }
    }
}