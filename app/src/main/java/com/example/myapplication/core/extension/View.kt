package com.example.myapplication.core.extension

import android.app.AlertDialog
import android.content.Context
import android.view.View
import android.widget.ProgressBar
import com.example.myapplication.R

/**
 * Validate the visibility
 */
fun View.isVisible() = this.visibility == View.VISIBLE

/**
 * Set visibility
 */
fun View.visible() { this.visibility = View.VISIBLE }

/**
 * Set visiility
 */
fun View.invisible() { this.visibility = View.GONE }

/**
 * Shows the progress bar when is loading the items
 */
fun showProgressBar(view: View){
    var progressBarStatus = 0
    var dummy:Int = 0
    val progressBar = view.findViewById<ProgressBar>(R.id.progressBar)
    progressBar.visible()

    Thread(Runnable {
        while (progressBarStatus < 100) {
            try {
                dummy+=25
                Thread.sleep(1000)
            } catch (e: InterruptedException) {
                e.printStackTrace()
            }
            progressBarStatus = dummy
            progressBar.progress = progressBarStatus
        }

    }).start()
}

/**
 * Hide the progress bar after the loading finished
 */
fun hidePogressBar(view: View){
    val progressBar =view.findViewById<ProgressBar>(R.id.progressBar)
    progressBar?.invisible()
}

/**
 * Show an alert dialog with a custom message and ok button
 */
fun showAlertDialog(context: Context, message: String){
    val dialogBuilder = AlertDialog.Builder(context)
    dialogBuilder.setMessage(message)
        .setCancelable(false)
        .setPositiveButton("Ok") { dialog, _ -> dialog.dismiss() }
    val alert = dialogBuilder.create()
    alert.setTitle(context.getString(R.string.app_name))
    alert.show()
}
