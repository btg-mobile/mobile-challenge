package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.arch.lifecycle.Observer
import android.arch.lifecycle.ViewModelProviders
import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.presentation.base.BaseActivity
import com.example.alesefsapps.conversordemoedas.presentation.conversorScreen.ConversorActivity
import kotlinx.android.synthetic.main.activity_selector.*
import kotlinx.android.synthetic.main.include_toolbar.*

class SelectorActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_selector)

        setupToolbar(toolbarMain, R.string.selector_title, true)

        val stateCurrency = intent.getStringExtra("STATE_CURRENCY")
        val viewModel: SelectorViewModel = ViewModelProviders.of(this).get(SelectorViewModel::class.java)

        viewModel.selectorLiveData.observe(this, Observer {
            it?.let {
                currency -> with(recycle_currency) {
                    layoutManager = LinearLayoutManager(this@SelectorActivity, RecyclerView.VERTICAL, false)
                    setHasFixedSize(true)
                    adapter = SelectorAdapter(currency) {
                        currency -> val intent = ConversorActivity.getStartIntent(this@SelectorActivity, currency.code, currency.name, currency.value, stateCurrency)
                        this@SelectorActivity.startActivity(intent)
                    }
                }
            }
        })

        viewModel.viewFlipperLiveData.observe(this, Observer {
            it?.let { viewFlipper ->
                currency_view_flipper.displayedChild = viewFlipper.first

                viewFlipper.second?.let { errorId ->
                    text_currency_error.text = getString(errorId)
                }
            }
        })

        viewModel.getValueLive()
    }
}
