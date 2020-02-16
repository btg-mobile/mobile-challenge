package io.felipeandrade.currencylayertest.ui.currency.conversion

import android.content.Intent
import android.os.Bundle
import android.view.KeyEvent
import android.view.inputmethod.EditorInfo
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import io.felipeandrade.currencylayertest.R
import io.felipeandrade.currencylayertest.ui.currency.selection.CurrencySelectionActivity
import kotlinx.android.synthetic.main.activity_currency_conversion.*
import org.koin.androidx.viewmodel.ext.android.viewModel

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

    private fun observeLiveData() {
        viewModel.inputCurrency.observe(this, Observer {
            it?.let { input ->
                btn_currency_in.text = input.currency.name
                et_input_amount.setText(input.currency.symbol)
            }
        })

        viewModel.outputCurrency.observe(this, Observer {
            it?.let { output ->
                btn_currency_out.text = output.currency.name
                tv_output_value.text = "${output.currency.symbol} ${output.currency.value}"
            }
        })

        viewModel.selectCurrencyCode.observe(this, Observer {
            it?.let { navigateToCurrencySelection(it) }
        })
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
                function.invoke()
                return@OnEditorActionListener true
            }
        }
        false
    })
}

