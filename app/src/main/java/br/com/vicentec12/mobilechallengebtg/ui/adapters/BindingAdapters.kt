package br.com.vicentec12.mobilechallengebtg.ui.adapters

import android.widget.ViewFlipper
import androidx.appcompat.widget.AppCompatTextView
import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.RecyclerView
import br.com.vicentec12.mobilechallengebtg.R
import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.ui.currencies.CurrenciesAdapter

object BindingAdapters {

    @BindingAdapter("items")
    @JvmStatic
    fun setItems(mView: RecyclerView, mItems: List<Currency>?) {
        mView.adapter?.apply {
            (this as CurrenciesAdapter).submitList(mItems) {
                mView.scrollToPosition(0)
            }
        }
    }

    @BindingAdapter("displayedChild")
    @JvmStatic
    fun setDisplayedChild(mView: ViewFlipper, mChild: Int) {
        if (mView.displayedChild != mChild)
            mView.displayedChild = mChild
    }

    @BindingAdapter("textId")
    @JvmStatic
    fun setTextById(mView: AppCompatTextView, mTextId: Int) {
        if (mTextId != 0)
            mView.text = mView.context.getString(mTextId)
        else
            mView.text = mView.context.getString(R.string.message_error_default)
    }

}