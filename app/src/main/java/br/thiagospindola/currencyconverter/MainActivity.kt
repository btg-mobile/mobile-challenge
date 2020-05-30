package br.thiagospindola.currencyconverter

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.fragment.app.FragmentManager
import br.thiagospindola.currencyconverter.database.getDatabase
import br.thiagospindola.currencyconverter.repository.CurrencyRepository
import br.thiagospindola.currencyconverter.util.hasNetwork
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlin.properties.Delegates

class MainActivity : AppCompatActivity() {
    private val viewModelJob = Job()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val coroutineScope = CoroutineScope(viewModelJob + Dispatchers.Main)
        val database = getDatabase(application)
        val currenciesRepository = CurrencyRepository(database)

        coroutineScope.launch {
            if(hasNetwork(applicationContext))
                currenciesRepository.refreshCurrencies()
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        viewModelJob.cancel()
    }
}
