package com.example.conversordemoeda.view

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.lifecycle.LifecycleObserver
import com.example.conversordemoeda.R
import com.example.conversordemoeda.view.ListaDeMoedasActivity.Companion.CODIGO_MOEDA_SELECIONADA
import com.example.conversordemoeda.viewmodel.MainViewModel
import kotlinx.android.synthetic.main.activity_main.*
import org.koin.androidx.viewmodel.ext.android.viewModel

class MainActivity : AppCompatActivity(), LifecycleObserver {
    val viewmodel: MainViewModel by viewModel()
    private val CAMBIO_DE_ORIGEM = 321
    private val CAMBIO_DE_DESTINO = 654

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btCambioOrigem.setOnClickListener {
            irParaTelaDeCambio(CAMBIO_DE_ORIGEM)
        }

        btCambioDestino.setOnClickListener {
            irParaTelaDeCambio(CAMBIO_DE_DESTINO)
        }

        lifecycle.addObserver(this)
    }

    private fun irParaTelaDeCambio(tipodeCambio: Int) {
        startActivityForResult(Intent(this, ListaDeMoedasActivity::class.java), tipodeCambio)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        when (resultCode) {
            Activity.RESULT_OK -> {
                when (requestCode) {
                    CAMBIO_DE_ORIGEM -> {
                        data?.let {
                            Toast.makeText(this@MainActivity, it.getStringExtra(CODIGO_MOEDA_SELECIONADA), Toast.LENGTH_SHORT)
                                .show()
                            btCambioOrigem.text = it.getStringExtra(CODIGO_MOEDA_SELECIONADA)
                        }
                    }
                    CAMBIO_DE_DESTINO -> {
                        data?.let {
                            Toast.makeText(this@MainActivity, it.getStringExtra(CODIGO_MOEDA_SELECIONADA), Toast.LENGTH_SHORT)
                                .show()
                                btCambioDestino.text = it.getStringExtra(CODIGO_MOEDA_SELECIONADA)
                        }
                    }
                }
            }
        }
    }
}