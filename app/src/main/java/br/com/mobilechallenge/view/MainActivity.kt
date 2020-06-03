package br.com.mobilechallenge.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.view.inputmethod.EditorInfo
import android.widget.Button
import android.widget.EditText
import android.widget.ImageView

import kotlin.math.pow

import br.com.mobilechallenge.R
import br.com.mobilechallenge.model.bean.ListBean
import br.com.mobilechallenge.presenter.live.MVP
import br.com.mobilechallenge.presenter.live.Presenter
import br.com.mobilechallenge.utils.Constantes
import br.com.mobilechallenge.utils.MaskDecimal
import br.com.mobilechallenge.utils.Utils
import br.com.mobilechallenge.view.components.Progress

class MainActivity : DefaultActivity(), MVP.View {
    private lateinit var progress: Progress
    private lateinit var presenter: MVP.Presenter

    private lateinit var btnItemFrom: ImageView
    private lateinit var btnItemTo: ImageView
    private lateinit var editItemFrom: EditText
    private lateinit var editItemTo: EditText
    private lateinit var editValueFrom: EditText
    private lateinit var editValueTo: EditText
    private lateinit var btnConvert: Button

    private var itemFrom: ListBean? = null
    private var itemTo: ListBean? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setupToolBar(R.id.toolbar)
        setActionBarTitle("")
        setActionBarSubTitle("")

        editItemFrom = findViewById(R.id.editItemFrom)
        editItemTo   = findViewById(R.id.editItemTo)
        editValueTo  = findViewById(R.id.editValueTo)
        progress     = findViewById(R.id.progress)
        progress.hide()

        btnItemFrom = findViewById(R.id.btnItemFrom)
        btnItemFrom.setOnClickListener {
            openList(Constantes.CURRENCY_FROM)
        }

        btnItemTo = findViewById(R.id.btnItemTo)
        btnItemTo.setOnClickListener {
            openList(Constantes.CURRENCY_TO)
        }

        editValueFrom = findViewById(R.id.editValueFrom)
        editValueFrom.addTextChangedListener(MaskDecimal(editValueFrom))
        editValueFrom.setOnEditorActionListener{ textView, actionId, keyEvent ->
            when(actionId) {
                EditorInfo.IME_ACTION_DONE -> {
                    actionDone()
                    false
                }
                else -> false
            }
        }

        btnConvert = findViewById(R.id.btnConvert)
        btnConvert.setOnClickListener { actionDone() }

        presenter = Presenter()
        presenter.setView(this)
    }

    private fun actionDone() {
        var amount: Double = editValueFrom.editableText.toString().replace("$","").toDouble()
        var from: String = editItemFrom.editableText.toString()
        var to: String = editItemTo.editableText.toString()

        if (from.isBlank() || from.isEmpty()) {
            msgBox(getString(R.string.txt_error2))
            return
        }
        if (to.isBlank() || to.isEmpty()) {
            msgBox(getString(R.string.txt_error3))
            return
        }
        if (amount == 0.00) {
            msgBox(getString(R.string.txt_error1))
            return
        }

        presenter.retrieveData(itemFrom, itemTo, amount)
    }

    override fun back(resultCode: Int) { finish() }
    override fun showProgressBar(visible: Int) {
        when(visible) {
            View.VISIBLE -> progress.show()
            View.GONE    -> progress.hide()
        }
    }

    private fun openList(requestCode: Int) {
        val intent = Intent(this, ListActivity::class.java)
        startActivityForResult(intent, requestCode)
        animRightToLeft()
    }

    override fun resultData(requestCode: Int, item: ListBean?) {
        when(requestCode) {
            Constantes.CURRENCY_FROM -> {
                itemFrom = item
                editItemFrom.setText("${item?.code} - ${item?.description}")
            }
            Constantes.CURRENCY_TO -> {
                itemTo = item
                editItemTo.setText("${item?.code} - ${item?.description}")
            }
        }
    }

    override fun resultCalc(price: Double) {
        editValueTo.setText("$${Utils.roundOffDecimal(price)}")
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK) {
            presenter.resultData(requestCode, data)
        }
    }
}