package br.com.alanminusculi.btgchallenge.ui

import android.app.ProgressDialog
import android.content.DialogInterface
import android.net.ConnectivityManager
import android.view.WindowManager
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import br.com.alanminusculi.btgchallenge.R

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

open class ActivityBase : AppCompatActivity() {

    private var progressDialog: ProgressDialog? = null

    protected fun addFlagKeepScreenOn() {
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
    }

    protected fun isNetworkConnected(): Boolean {
        val systemService = getSystemService(CONNECTIVITY_SERVICE) as ConnectivityManager
        return systemService.activeNetworkInfo != null && systemService.activeNetworkInfo!!.isConnected
    }

    protected fun showAlertDialog(title: String?, message: String?, onClickListener: DialogInterface.OnClickListener?) {
        runOnUiThread {
            try {
                val builder = AlertDialog.Builder(this@ActivityBase)
                builder.setTitle(title)
                builder.setMessage(message)
                builder.setPositiveButton(R.string.dialog_ok, onClickListener)
                val alert = builder.create()
                alert.setCancelable(false)
                alert.setCanceledOnTouchOutside(false)
                alert.show()
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    fun showProgressDialog() {
        runOnUiThread {
            progressDialog = ProgressDialog(this@ActivityBase)
            progressDialog!!.setProgressStyle(ProgressDialog.STYLE_SPINNER)
            progressDialog!!.setTitle(getString(R.string.dialog_title_aguarde))
            progressDialog!!.setMessage(getString(R.string.carregando))
            progressDialog!!.setCancelable(true)
            progressDialog!!.setCanceledOnTouchOutside(true)
            progressDialog!!.show()
        }
    }

    fun dismissProgressDialog() {
        runOnUiThread {
            if (progressDialog != null && progressDialog!!.isShowing) {
                progressDialog!!.cancel()
                progressDialog!!.dismiss()
            }
        }
    }
}