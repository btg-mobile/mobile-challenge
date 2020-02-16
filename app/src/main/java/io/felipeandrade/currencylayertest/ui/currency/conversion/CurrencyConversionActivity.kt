package io.felipeandrade.currencylayertest.ui.currency.conversion

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import io.felipeandrade.currencylayertest.R
import kotlinx.android.synthetic.main.activity_currency_conversion.*
import org.koin.androidx.viewmodel.ext.android.viewModel

class CurrencyConversionActivity : AppCompatActivity() {

    private val viewModel: CurrencyConversionViewModel by viewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency_conversion)
        observeLiveData()
    }

    private fun observeLiveData() {
        viewModel.inputCurrency.observe(this, Observer {
            it?.let{input ->
                btn_currency_in.text = input.currency.name
                et_input_amount.setText(input.currency.symbol)
            }
        })

        viewModel.outputCurrency.observe(this, Observer {
            it?.let{output ->
                btn_currency_out.text = output.currency.name
                tv_output_value.text = "${output.currency.symbol} ${output.currency.value}"
            }
        })
    }
}