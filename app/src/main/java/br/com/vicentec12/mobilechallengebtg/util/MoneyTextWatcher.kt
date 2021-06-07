package br.com.vicentec12.mobilechallengebtg.util

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import java.lang.ref.WeakReference
import java.text.DecimalFormat
import java.text.NumberFormat

class MoneyTextWatcher(mEditText: EditText?) : TextWatcher {

    private var mCurrent: String = ""
    private var mEditTextWeak: WeakReference<EditText> = WeakReference<EditText>(mEditText)

    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

    override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
        val mEditText = mEditTextWeak.get()
        if (mEditText != null && s != null && s.toString() != mCurrent) {
            mEditText.removeTextChangedListener(this)
            val mCleanString: String = s.replace("""[,.]""".toRegex(), "").trim()
            val mParsed = mCleanString.toDouble()
            NumberFormat.getCurrencyInstance().apply {
                val mSymbol = (this as DecimalFormat).decimalFormatSymbols
                mSymbol.currencySymbol = ""
                this.decimalFormatSymbols = mSymbol
                val formatted = format((mParsed / 100))
                mCurrent = formatted
                mEditText.setText(formatted)
                mEditText.setSelection(formatted.length)
            }
            mEditText.addTextChangedListener(this)
        }
    }

    override fun afterTextChanged(s: Editable?) {}
}