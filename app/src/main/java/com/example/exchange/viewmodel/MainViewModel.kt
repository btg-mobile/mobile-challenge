package com.example.exchange.viewmodel

import androidx.fragment.app.Fragment
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class MainViewModel : ViewModel() {

    private val screen: MutableLiveData<Fragment> = MutableLiveData()

    fun setScreen(screen: Fragment) {
        this.screen.value = screen
    }

    fun getScreen(): LiveData<Fragment> {
        return screen
    }
}