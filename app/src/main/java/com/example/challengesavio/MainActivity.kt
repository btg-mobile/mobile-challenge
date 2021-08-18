package com.example.challengesavio

import android.opengl.Visibility
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.View.*
import android.widget.ProgressBar
import android.widget.Spinner
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import com.example.challengesavio.adapters.CurrenciesAdapter
import com.example.challengesavio.api.repositories.MainRepository
import com.example.challengesavio.api.services.RetrofitService
import com.example.challengesavio.databinding.ActivityMainBinding
import com.example.challengesavio.utilities.CurrenciesListener
import com.example.challengesavio.viewmodels.CurrenciesViewModel
import com.example.challengesavio.viewmodels.MyViewModelFactory
import android.widget.AdapterView




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

    }

    override fun onCurrenciesResult(currencies: Map<String, String>) {
        progress.visibility= INVISIBLE
        currenciesList= ArrayList()
        currenciesList!!.add(getString(R.string.select))
        for (item in currencies) {
            currenciesList!!.add(item.key)
        }
        adapter = CurrenciesAdapter(this, currenciesList!!)
        spinnerOrigin.adapter = adapter;
        spinnerDestiny.adapter = adapter;

        spinnerDestiny.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>, view: View?, position: Int, id: Long) {
                val selectedItem = parent.getItemAtPosition(position).toString()

                if(selectedItem != getString(R.string.select)){
                    convertCurrency(spinnerOrigin.selectedItem.toString(), selectedItem)
                }
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {}
        }
    }

    override fun onQuotesResult(quotes: HashMap<String, Double>) {
        quotesList= quotes
        quotesList!!.forEach { (key, value) -> Log.d("Quotes", "$key = $value") }
    }

    fun convertCurrency (origin : String, destiny: String){

        var junction = origin+destiny

        if (origin=="USD"){
            junction = origin+destiny

        }else{


        }

        val quote = quotesList?.getValue(junction)
        val userValue = binding.inputValue.text.toString()
        var result: String

        if(userValue != ""){
            result = (userValue.toDouble()*quote!!).toString()
            binding.displayOriginValue.text= "$userValue $origin"
            binding.displayComplement.visibility= VISIBLE
            binding.displayResultValue.text= "$result $destiny"
        }else{
            binding.errorMessage.text= getString(R.string.error_no_input)
        }

    }

}