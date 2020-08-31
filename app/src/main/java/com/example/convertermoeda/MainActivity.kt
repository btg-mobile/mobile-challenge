package com.example.convertermoeda

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.lifecycle.Observer
import com.example.convertermoeda.provider.providerMainViewModel
import com.example.convertermoeda.viewmodel.state.MainState

class MainActivity : AppCompatActivity() {
    private val viewModel by lazy {
        providerMainViewModel(this)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        criarObserver()
    }

    private fun criarObserver() {
        viewModel.viewState.observe(this, Observer { viewState ->
            viewState?.let {
                when (it) {
                    is MainState.IsErro -> {
                        Log.e("error","erro ${it.error}")
                    }
                }
            }
        })

        viewModel.buscarLive()
    }
}