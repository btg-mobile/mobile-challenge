package com.example.myapplication.core.plataform

import android.content.Intent
import android.os.Bundle
import android.view.MenuItem
import android.view.Window
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentTransaction

abstract class BaseActivity : AppCompatActivity(){

    private var fm: FragmentManager? = null
    private var ft: FragmentTransaction? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        startMethods()
    }

    private fun startMethods() {
        fm = supportFragmentManager
        setLayout()
        configActionBar()
        setObjects()
    }

    private fun configActionBar() {
        val actionBar = supportActionBar

        if (actionBar != null) {
            actionBar.elevation = 0f
        }
    }

    fun startActivity(activityType: Class<*>, bundle: Bundle?) {
        val intent = Intent(applicationContext, activityType)
        intent.flags = Intent.FLAG_ACTIVITY_SINGLE_TOP

        if (bundle != null) {
            intent.putExtras(bundle)
        }

        startActivity(intent)
    }

    fun hideTop(fullScreen: Boolean) {
        requestWindowFeature(Window.FEATURE_NO_TITLE)

        if (fullScreen) {
            window.setFlags(
                WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN
            )
        }

       supportActionBar?.hide()
    }

    fun setHomeAsUp() {
        if (actionBar != null) {
            actionBar!!.hide()
        }

        if (supportActionBar != null) {
            supportActionBar!!.setDisplayHomeAsUpEnabled(true)
        }
    }

    public override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            android.R.id.home -> finish()
        }

        return super.onOptionsItemSelected(item)
    }

    abstract fun setLayout()
    abstract fun setObjects()
}