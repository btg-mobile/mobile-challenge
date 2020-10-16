package br.net.easify.currencydroid.view

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.appcompat.app.AppCompatDelegate
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.navigation.ui.NavigationUI
import br.net.easify.currencydroid.MainApplication
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.services.RateService
import br.net.easify.currencydroid.util.ServiceUtil
import javax.inject.Inject

class MainActivity : AppCompatActivity() {

    private lateinit var navController: NavController

    @Inject
    lateinit var serviceUtil: ServiceUtil

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        (application as MainApplication).getAppComponent()?.inject(this)

        navController = Navigation.findNavController(this, R.id.mainFragment)
        NavigationUI.setupActionBarWithNavController(this, navController)

        startRateService()

        //delegate.localNightMode = AppCompatDelegate.MODE_NIGHT_YES;
    }

    override fun onSupportNavigateUp(): Boolean {
        return NavigationUI.navigateUp(navController, null)
    }

    private fun startRateService() {
        val intent = Intent(application, RateService::class.java)
        if (!serviceUtil.isMyServiceRunning(RateService::class.java)) {
            startService(intent)
        }
    }
}