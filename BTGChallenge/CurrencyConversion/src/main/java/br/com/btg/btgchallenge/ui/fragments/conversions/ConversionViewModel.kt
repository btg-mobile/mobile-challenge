package br.com.btg.btgchallenge.ui.fragments.conversions

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.btg.btgchallenge.network.api.config.Resource
import br.com.btg.btgchallenge.network.api.config.Status
import br.com.btg.btgchallenge.network.api.currencylayer.CurrencyLayerRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class ConversionViewModel(val currencyLayerRepository: CurrencyLayerRepository) : ViewModel(){

    val getRealtimeRates = MutableLiveData<Resource<Any>>()
    fun getRealtimeRates() {
        viewModelScope.launch(context = Dispatchers.IO)
        {
            getRealtimeRates.postValue(Resource.loading())
            val rates = currencyLayerRepository.getRealTimeRates()
            when (rates.status) {
                Status.SUCCESS -> {
                }
            }
            getRealtimeRates.postValue(rates)
        }
    }

    val convertedValue = MutableLiveData<String>()
    fun getConversionFromTo(currencyFrom: Pair<String, String>, currencyTo: Pair<String, String>, valueToConvert: Double)
    {
        val quoteFrom = getRealtimeRates.value?.data?.quotes?.filterKeys { it.toUpperCase() == "USD" + currencyFrom.first.toUpperCase() }?.entries?.firstOrNull()
        val quoteTo = getRealtimeRates.value?.data?.quotes?.filterKeys { it.toUpperCase() == "USD" + currencyTo.first.toUpperCase() }?.entries?.firstOrNull()
        if(quoteFrom != null && quoteTo != null)
        {
            val valueOrigin = quoteFrom.value
            val valueDestiny = quoteTo.value
            var valueInDolar = valueToConvert/valueOrigin

            var conversion = valueInDolar*valueDestiny
            var valueFormatted = "$"+String.format("%.4f", conversion)
            convertedValue.postValue(valueFormatted)
        }else{
            convertedValue.postValue("$0.0000")
        }
    }


}