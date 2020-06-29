package br.com.daccandido.currencyconverterapp.ui.listcurrency

import android.os.Bundle
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.model.Currency
import br.com.daccandido.currencyconverterapp.ui.base.BaseActivity
import kotlinx.android.synthetic.main.activyity_list_currencies.*

class ListCurrencyActivity: BaseActivity(), ClickItemList {

    private lateinit var  viewModel: ListCurrentViewModel


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activyity_list_currencies)


    }

    override fun onClick(currency: Currency) {
        TODO("Not yet implemented")
    }

    private fun setUpRecyclerView () {
        rvList.adapter = ListCurrencyAdapter()
    }
}