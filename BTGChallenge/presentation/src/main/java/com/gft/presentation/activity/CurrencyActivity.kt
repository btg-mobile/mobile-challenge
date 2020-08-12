package com.gft.presentation.activity

import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.gft.presentation.R
import com.gft.presentation.databinding.ActivityCurrencyBinding
import com.gft.presentation.viewmodel.CurrencyViewModel
import org.koin.android.viewmodel.ext.android.viewModel

class CurrencyActivity : AppCompatActivity() {

    private val viewModel: CurrencyViewModel by viewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val binding: ActivityCurrencyBinding =
            DataBindingUtil.setContentView(this, R.layout.activity_currency)
        binding.lifecycleOwner = this

        binding.viewModel = viewModel
    }

    fun onClick(view: View) {
        val intent = Intent(this, ChooseCurrencyActivity::class.java)
        startActivity(intent)
    }
}
