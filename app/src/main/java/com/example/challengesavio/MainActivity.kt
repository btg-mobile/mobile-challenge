package com.example.challengesavio

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View.*
import android.widget.ProgressBar
import android.widget.Spinner
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import com.example.challengesavio.adapters.CurrenciesAdapter
import com.example.challengesavio.api.repositories.MainRepository
import com.example.challengesavio.api.services.RetrofitService
import com.example.challengesavio.data.entity.Currency
import com.example.challengesavio.databinding.ActivityMainBinding
import com.example.challengesavio.utilities.CurrenciesListener
import com.example.challengesavio.viewmodels.CurrenciesViewModel
import com.example.challengesavio.viewmodels.MyViewModelFactory

class MainActivity : AppCompatActivity(), CurrenciesListener{

    private var currenciesList : ArrayList<String>? = null
    private var quotesList : HashMap<String,Double>? = null
    private lateinit var binding: ActivityMainBinding
    private var adapter: CurrenciesAdapter? = null
    private lateinit var spinnerOrigin : Spinner
    private lateinit var spinnerDestiny : Spinner
    private lateinit var progress : ProgressBar

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = DataBindingUtil.setContentView(this, R.layout.activity_main)
        binding.lifecycleOwner = this
        binding.executePendingBindings()

        spinnerOrigin= binding.selectOrigin
        spinnerDestiny= binding.selectDestiny
        progress= binding.progressCircular

        val viewModel = ViewModelProvider(this, MyViewModelFactory(MainRepository(RetrofitService.getInstance()))).
        get(CurrenciesViewModel::class.java)

        viewModel.currenciesListener=this
        viewModel.getAllCurrencies()
        viewModel.getAllQuotes()

        binding.convertButton.setOnClickListener {
            val origin = spinnerOrigin.selectedItem.toString()
            val destiny = spinnerDestiny.selectedItem.toString()

            if (origin != getString(R.string.select) && destiny != getString(R.string.select)){
                convertCurrency(origin, destiny)
            }else{
                binding.errorMessage.text= getString(R.string.error_no_input)
            }
        }

        binding.listCurrencies.setOnClickListener {

            val intent = Intent(this, ListCurrenciesActivity::class.java)
            startActivity(intent)
        }






    }

    override fun onCurrenciesResult(currencies: Map<String, String>) {
        progress.visibility= INVISIBLE
        currenciesList= ArrayList()
        currenciesList!!.add(getString(R.string.select))
        for (item in currencies) {
            currenciesList!!.add(item.key)
            val currency = Currency(null,item.key, item.value)
            MyApplication.database?.currencyDao()?.insertCurrencies(currency)
        }
        adapter = CurrenciesAdapter(this, currenciesList!!)
        spinnerOrigin.adapter = adapter;
        spinnerDestiny.adapter = adapter;

    }


    override fun onQuotesResult(quotes: HashMap<String, Double>) {
        quotesList= quotes
    }

    fun convertCurrency (origin : String, destiny: String){

        val junction = getString(R.string.usd)+destiny
        var userValue = ""

        if (origin==getString(R.string.usd)){
            userValue = binding.inputValue.text.toString()
            binding.displayOriginValue.text= """$userValue $origin"""
        }else{
            binding.displayOriginValue.text= """${binding.inputValue.text} $origin"""
            userValue= getValueInUSD(origin).toString()
        }

        val quote :Double = quotesList?.getValue(junction)!!

        val result: String

        if(userValue != "" && userValue != "0.0" ){
            binding.containerResult.visibility= VISIBLE
            binding.errorMessage.text=""
            result = (userValue.toDouble()*quote).toString()

            binding.displayComplement.visibility= VISIBLE
            binding.displayResultValue.text= "$result $destiny"

        }else{
            binding.containerResult.visibility= GONE
            binding.errorMessage.text= getString(R.string.error_no_input)
        }

    }

    private fun getValueInUSD(origin: String) : Double{

        var result =0.0
        val quote = quotesList?.getValue(getString(R.string.usd)+origin)
        val userValue = binding.inputValue.text.toString()

        if(userValue != ""){
            result = userValue.toDouble()/quote!!
        }
        return result
    }

}