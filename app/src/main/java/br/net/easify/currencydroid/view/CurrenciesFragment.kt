package br.net.easify.currencydroid.view

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.ViewModelProviders
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.viewmodel.CurrenciesViewModel

class CurrenciesFragment : Fragment() {
    private lateinit var viewModel: CurrenciesViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        viewModel = ViewModelProviders.of(this).get(CurrenciesViewModel::class.java)

        return inflater.inflate(R.layout.fragment_currencies, container, false)
    }

}