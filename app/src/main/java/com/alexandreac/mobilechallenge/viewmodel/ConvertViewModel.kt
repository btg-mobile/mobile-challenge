package com.alexandreac.mobilechallenge.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.MutableLiveData
import com.alexandreac.mobilechallenge.model.datasource.ICurrencyDataSource

class ConvertViewModel(val repository: ICurrencyDataSource, application: Application):
                        AndroidViewModel(application), LifecycleObserver {
    val fromInitials = MutableLiveData<String>().apply { value = "USD" }
    val fromName = MutableLiveData<String>().apply { value = "United States Dollar" }
    val fromValue = MutableLiveData<String>().apply { value = "10.00" }
    val toInitials = MutableLiveData<String>().apply { value = "BRL" }
    val toName = MutableLiveData<String>().apply { value = "Brazilian Real" }
    val toValue = MutableLiveData<String>().apply { value = "10.00" }
    val loadingVisibility = MutableLiveData<Boolean>().apply { value = false }
    val message = MutableLiveData<String>().apply { value = "" }

    fun setFromInfo(initials:String, name:String){
        fromInitials.postValue(initials)
        fromName.postValue(name)
    }

    fun setToInfo(initials:String, name:String){
        toInitials.postValue(initials)
        toName.postValue(name)
    }

    fun convertMoney(){
        loadingVisibility.postValue(true)
        message.postValue("")
        repository.convert("${fromInitials.value},${toInitials.value}",
            fromValue.value!!.toDouble(),{value ->
            toValue.postValue(value)
            message.postValue("")
            loadingVisibility.postValue(false)
        },{
            message.postValue(it)
            loadingVisibility.postValue(false)
        })
    }
}