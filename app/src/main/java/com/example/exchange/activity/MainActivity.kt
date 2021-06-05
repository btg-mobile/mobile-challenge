package com.example.exchange.activity

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import com.example.exchange.R
import com.example.exchange.databinding.ActivityMainBinding
import com.example.exchange.fragment.CoinFragment
import com.example.exchange.fragment.ConverterFragment
import com.example.exchange.fragment.StartFragment
import com.example.exchange.viewmodel.MainViewModel

class MainActivity : AppCompatActivity() {

    private lateinit var viewModel: MainViewModel
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        viewModel = ViewModelProviders.of(this).get(MainViewModel::class.java)

        initObservers()
        initListeners()

        viewModel.defineScreen(StartFragment())
    }

    private fun initObservers() {
        viewModel.getScreenSelected().observe(this, {
            showFragment(it)
        })
    }

    private fun initListeners() {
        binding.buttonConverter.setOnClickListener {
            viewModel.defineScreen(ConverterFragment())
        }

        binding.buttonList.setOnClickListener {
            viewModel.defineScreen(CoinFragment())
        }
    }

    private fun showFragment(fragment: Fragment) {
        supportFragmentManager
            .beginTransaction()
            .replace(R.id.frame_layout_fragment, fragment)
            .commit()
    }
}