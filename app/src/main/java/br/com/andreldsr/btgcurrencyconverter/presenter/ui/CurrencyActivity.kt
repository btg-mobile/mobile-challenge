package br.com.andreldsr.btgcurrencyconverter.presenter.ui

import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupWithNavController
import br.com.andreldsr.btgcurrencyconverter.R
import br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel.CurrencyConversionViewModel
import kotlinx.android.synthetic.main.include_toolbar.*

class CurrencyActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_currency)
        setSupportActionBar(findViewById(R.id.toolbarMain))

        val navHostFragment = supportFragmentManager.findFragmentById(R.id.nav_host_fragment) as NavHostFragment
        val navController = navHostFragment.navController
        val appBarConfiguration = AppBarConfiguration(navController.graph)
        toolbarMain.setupWithNavController(navController, appBarConfiguration)
    }
}