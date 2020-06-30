package br.com.leonamalmeida.mobilechallenge.ui.main

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.doOnTextChanged
import androidx.lifecycle.Observer
import br.com.leonamalmeida.mobilechallenge.util.EXTRA_CURRENCY
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.util.haveNetwork
import br.com.leonamalmeida.mobilechallenge.util.snack
import br.com.leonamalmeida.mobilechallenge.ui.currency.CurrencyActivity
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.activity_main.*

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {

    private val viewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setToolbar()
        setListeners()
        setObservers()
        mainSr.isEnabled = false
    }

    private fun setToolbar() {
        setSupportActionBar(toolbar)
        title = getString(R.string.activity_main_title)
    }

    private fun setListeners() {
        originTv.setOnClickListener { viewModel.onOriginClick() }
        destinyTv.setOnClickListener { viewModel.onDestinyClick() }
        convertBtn.setOnClickListener { viewModel.convert(amountTv.text.toString()) }

        amountTv.doOnTextChanged { text, _, _, _ ->
            convertBtn.isEnabled = !text.isNullOrBlank()
            if (text.isNullOrEmpty()) {
                resultValueLabelTv.visibility = View.GONE
                resultValueCv.visibility = View.GONE
                lastUpdateTv.visibility = View.GONE
            }
        }
    }

    private fun setObservers() {
        viewModel.run {
            originCurrency.observe(this@MainActivity, Observer {
                originTv.text = it
                lastUpdateTv.visibility = View.GONE
                resultValueLabelTv.visibility = View.GONE
                resultValueCv.visibility = View.GONE
            })

            destinyCurrency.observe(this@MainActivity, Observer {
                destinyTv.text = it
                lastUpdateTv.visibility = View.GONE
                resultValueLabelTv.visibility = View.GONE
                resultValueCv.visibility = View.GONE
            })

            value.observe(this@MainActivity, Observer {
                lastUpdateTv.text = getString(R.string.last_update, it.first)
                lastUpdateTv.visibility = View.VISIBLE
                resultValueTv.text = it.second.toString()
                resultValueLabelTv.visibility = View.VISIBLE
                resultValueCv.visibility = View.VISIBLE
            })

            displayAmountField.observe(this@MainActivity, Observer {
                amountLabelTv.visibility = if (it) View.VISIBLE else View.GONE
                amountCv.visibility = if (it) View.VISIBLE else View.GONE
                convertBtn.visibility = if (it) View.VISIBLE else View.GONE
            })

            openCurrencyActivity.observe(this@MainActivity, Observer { requestCode ->
                startActivityForResult(
                    Intent(baseContext, CurrencyActivity::class.java),
                    requestCode
                )
            })

            loading.observe(this@MainActivity, Observer {
                mainSr.isEnabled = it
                mainSr.isRefreshing = it
            })

            error.observe(this@MainActivity, Observer { displayError(it) })
        }
    }

    private fun displayError(msgRes: Int) {
        snack(
            mainRoot,
            if (haveNetwork()) msgRes else R.string.no_connection_error,
            R.string.action_reload
        ) { convertBtn.performClick() }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK)
            viewModel.handleCurrencySelection(requestCode, data?.getStringExtra(EXTRA_CURRENCY))
    }
}