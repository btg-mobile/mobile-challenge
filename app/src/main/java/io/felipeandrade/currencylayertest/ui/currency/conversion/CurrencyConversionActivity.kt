package io.felipeandrade.currencylayertest.ui.currency.conversion

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.KeyEvent
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import io.felipeandrade.currencylayertest.R
import io.felipeandrade.currencylayertest.ui.currency.selection.CurrencySelectionActivity
import kotlinx.android.synthetic.main.activity_currency_conversion.*
import org.koin.androidx.viewmodel.ext.android.viewModel
import java.math.BigDecimal

class CurrencyConversionActivity : AppCompatActivity() {

    companion object {
        const val INPUT_REQ_CODE = 1
        const val OUTPUT_REQ_CODE = 2
    }

    private val viewModel: CurrencyConversionViewModel by viewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency_conversion)
        observeLiveData()
        initUiEvents()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        viewModel.onActivityResult(requestCode, resultCode, data)
    }

    private fun observeLiveData() {
        viewModel.inputCurrency.observe(this, Observer {
            it?.let { currency -> btn_currency_in.text = currency.name }
        })

        viewModel.inputValue.observe(this, Observer {
            it?.let { value -> et_input_amount.setText("$value") }
        })

        viewModel.outputCurrency.observe(this, Observer {
            it?.let { currency -> btn_currency_out.text = currency.name }
        })

        viewModel.outputValue.observe(this, Observer {
            it?.let { data -> tv_output_value.text = currencyFormat(data.currency.symbol, data.value) }
        })

        viewModel.selectCurrencyCode.observe(this, Observer {
            it?.let { navigateToCurrencySelection(it) }
        })
    }

    private fun currencyFormat(symbol: String, value: BigDecimal): String {
        return "$symbol $value"
    }

    private fun initUiEvents() {
        btn_currency_in.setOnClickListener { viewModel.inputBtnClicked() }
        btn_currency_out.setOnClickListener { viewModel.outputBtnClicked() }

        et_input_amount.setOnFinishTyping { viewModel.inputValueUpdated(et_input_amount.text.toString()) }
    }

    private fun navigateToCurrencySelection(reqCode: Int) {
        val intent = Intent(this, CurrencySelectionActivity::class.java)
        startActivityForResult(intent, reqCode)
    }
}

private fun EditText.setOnFinishTyping(function: () -> Unit) {
    setOnEditorActionListener(TextView.OnEditorActionListener { _, actionId, event ->
        if (actionId == EditorInfo.IME_ACTION_SEARCH ||
            actionId == EditorInfo.IME_ACTION_DONE ||
            event != null &&
            event.action == KeyEvent.ACTION_DOWN &&
            event.keyCode == KeyEvent.KEYCODE_ENTER
        ) {

            if (event == null || !event.isShiftPressed) {
                // the user is done typing.

                val imm =
                    context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                imm.hideSoftInputFromWindow(windowToken, 0)

                clearFocus()

                function.invoke()
                return@OnEditorActionListener true
            }
        }
        false
    })
}

