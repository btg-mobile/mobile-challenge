package com.example.myapplication.features.main

import android.content.Intent
import android.view.View
import com.example.myapplication.R
import com.example.myapplication.core.extension.*
import com.example.myapplication.core.plataform.BaseActivity
import com.example.myapplication.core.plataform.Constants
import com.example.myapplication.core.plataform.Internet
import com.example.myapplication.core.repository.CoinsPriceRepository
import com.example.myapplication.features.coinsconverterlist.CoinsConverterListActivity
import kotlinx.android.synthetic.main.activity_main.*
import java.math.BigDecimal
import java.math.RoundingMode

class MainActivity : BaseActivity(), CoinsPriceInterface {

    private var rootView: View?=null
    private var keyOrigin: String?=null
    private var keyDestiny: String?=null

    override fun setLayout() {
        setContentView(R.layout.activity_main)
    }

    override fun setObjects() {
        init()
    }

    private fun init(){
        rootView = window.decorView.rootView
        btn_origin.setOnClickListener {
            openCoinsConverterList(1)
        }

        btn_destiny.setOnClickListener {
            openCoinsConverterList(2)
        }

        btn_convert.setOnClickListener {
            validateFields()
        }
    }

    private fun validateFields(){
        if(edt_profile_email.text.toString().isEmpty()){
            showAlertDialog(this, getString(R.string.title_fill_coins_value))
            return
        }

        if(keyOrigin.isNullOrEmpty()){
            showAlertDialog(this, getString(R.string.title_choose_origin_coin))
            return
        }

        if(keyDestiny.isNullOrEmpty()){
            showAlertDialog(this, getString(R.string.title_choose_destiny_coin))
            return
        }

        if(edt_profile_email.text.toString().contains(",")){
            showAlertDialog(this, getString(R.string.title_validate_dot))
            return
        }

        if(edt_profile_email.text.toString().isNotEmpty() && keyOrigin!!.isNotEmpty() && keyDestiny!!.isNotEmpty()){
            if(value_converted.isVisible()){
                value_converted.invisible()
            }

            coinsPrice()
        }
    }

    private fun openCoinsConverterList(requestCode: Int){
        val intent = Intent(this, CoinsConverterListActivity::class.java)
        startActivityForResult(intent, requestCode)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 1 && resultCode == 2) {
            keyOrigin = data!!.getStringExtra("key")
            tv_origin_selected.text = "Moeda de origem: $keyOrigin"

        }else if (requestCode == 2 && resultCode == 2){
            keyDestiny = data!!.getStringExtra("key")
            tv_destiny_selected.text = "Moeda de destino: $keyDestiny"
        }
    }

    private fun coinsPrice(){
        if(Internet().isInternetAvailable(this)) {
            showProgressBar(rootView!!)
            val url = Constants.urlCoinsPrice
            val coinsPriceRepository = CoinsPriceRepository(context = this, url = url)
            coinsPriceRepository.startRequest(this)
        }else{
            rootView?.let { hidePogressBar(it) }
            showAlertDialog(this, getString(R.string.title_failed_to_show_data))
        }
    }

    override fun onValidateRequestSuccess(result: CoinsPriceResult) {
        val mapSorted = result.quotes.toSortedMap()
        var valueOrigin: BigDecimal?= null
        var valueDestiny: BigDecimal?= null
        for (quotes in mapSorted){
            if (quotes.key.contains(keyOrigin.toString())){
                valueOrigin = quotes.value
            }

            if (quotes.key.contains(keyDestiny.toString())){
                valueDestiny = quotes.value
            }
        }

        convertingValues(valueOrigin!!, valueDestiny!!)

    }

    private fun convertingValues(valueOrigin: BigDecimal, valueDestiny: BigDecimal){
        val valueToConvert:BigDecimal = edt_profile_email.text.toString().toBigDecimal()
        val from :BigDecimal =  valueToConvert

        val fromToDestiny = from.divide(valueOrigin, 6, RoundingMode.HALF_EVEN)
        val source = fromToDestiny.multiply(valueDestiny)

        hidePogressBar(rootView!!)
        value_converted.visible()
        value_converted.text = "Conversão de: ${source.setScale(2, BigDecimal.ROUND_HALF_EVEN)}"
    }

    override fun onValidateRequestFail(message: String?, error: Boolean) {
        hidePogressBar(rootView!!)
        if(error){
            showAlertDialog(this, message.toString())
        }
    }
}