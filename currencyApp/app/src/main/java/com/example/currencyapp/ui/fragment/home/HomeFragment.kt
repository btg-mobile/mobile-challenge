package com.example.currencyapp.ui.fragment.home

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.currencyapp.R
import com.example.currencyapp.network.service.CurrencyList
import com.example.currencyapp.repository.ListRepository
import org.koin.android.ext.android.inject

class HomeFragment : Fragment() {
    private val remoteCurrencyList : CurrencyList by inject()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        println("Acho que to aqui 1")
        return inflater.inflate(R.layout.fragment_home, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        println("Acho que to aqui")
        ListRepository(remoteCurrencyList).getCurrencyListFromApi()
    }
}