package com.example.exchange.fragment

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.ViewModelProviders
import com.example.exchange.R
import com.example.exchange.viewmodel.OptionViewModel
import kotlinx.android.synthetic.main.fragment_option.*

class OptionFragment : Fragment() {

    private lateinit var viewModel: OptionViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_option, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel = ViewModelProviders.of(this).get(OptionViewModel::class.java)
        initListeners()
        initObservers()
    }

    private fun initListeners() {
        button_converter.setOnClickListener {
            viewModel.defineScreen(ConverterFragment())
        }

        button_list.setOnClickListener {
            viewModel.defineScreen(CoinFragment())
        }
    }

    private fun initObservers() {
        viewModel.getScreenSelected().observe(this, {
            showFragment(it)
        })
    }

    private fun showFragment(fragment: Fragment) {
        fragmentManager
            ?.beginTransaction()
            ?.replace(R.id.frame_layout_fragment, fragment)
            ?.addToBackStack("AnywayScreen")
            ?.commit()
    }
}