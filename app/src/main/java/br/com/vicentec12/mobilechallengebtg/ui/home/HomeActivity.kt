package br.com.vicentec12.mobilechallengebtg.ui.home

import android.os.Bundle
import android.view.View.GONE
import android.view.View.VISIBLE
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import br.com.vicentec12.mobilechallengebtg.CurrencyApp
import br.com.vicentec12.mobilechallengebtg.databinding.ActivityHomeBinding
import br.com.vicentec12.mobilechallengebtg.di.ViewModelProviderFactory
import br.com.vicentec12.mobilechallengebtg.ui.currencies.CurrenciesActivity
import br.com.vicentec12.mobilechallengebtg.util.MoneyTextWatcher
import com.google.android.material.snackbar.Snackbar
import javax.inject.Inject

class HomeActivity : AppCompatActivity() {

    private lateinit var mBinding: ActivityHomeBinding

    @Inject
    lateinit var mFactory: ViewModelProviderFactory

    private val mViewModel: HomeViewModel by viewModels { mFactory }

    private val mActivityResult =
        registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
            if (result.resultCode == RESULT_OK)
                mViewModel.receiverValues(result.data)
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        (applicationContext as CurrencyApp).mAppComponent.homeComponent().create()
            .inject(this)
        super.onCreate(savedInstanceState)
        mBinding = ActivityHomeBinding.inflate(layoutInflater).apply {
            setContentView(root)
            viewModel = mViewModel
            lifecycleOwner = this@HomeActivity
        }
        init()
    }

    private fun init() {
        setupViews()
        setupListeners()
        setupViewModel()
    }

    private fun setupViews() {
        with(mBinding) {
            tilFromCurrency.editText?.addTextChangedListener(MoneyTextWatcher(tilFromCurrency.editText))
            tilToCurrency.editText?.addTextChangedListener(MoneyTextWatcher(tilToCurrency.editText))
        }
    }

    private fun setupListeners() {
        with(mBinding) {
            btnConvertFrom.setOnClickListener {
                mActivityResult.launch(
                    CurrenciesActivity.newIntentInstance(this@HomeActivity, true)
                )
            }
            btnConvertTo.setOnClickListener {
                mActivityResult.launch(
                    CurrenciesActivity.newIntentInstance(this@HomeActivity, false)
                )
            }
            btnConvert.setOnClickListener {
                mViewModel.convertCurrency()
            }
        }
    }

    private fun setupViewModel() {
        with(mViewModel) {
            message.observe(this@HomeActivity) { mEvent ->
                val mMessage = mEvent.contentIfNotHandled
                mMessage?.let {
                    Snackbar.make(mBinding.btnConvertTo, it, Snackbar.LENGTH_LONG)
                        .setAnimationMode(Snackbar.ANIMATION_MODE_SLIDE).show()
                }
            }
            loading.observe(this@HomeActivity) { mEvent ->
                val mLoading = mEvent.contentIfNotHandled
                mLoading?.let {
                    if (mLoading) {
                        mBinding.pgbLoading.visibility = VISIBLE
                        mBinding.btnConvert.visibility = GONE
                        mBinding.btnConvertTo.isEnabled = false
                        mBinding.btnConvertFrom.isEnabled = false
                    } else {
                        mBinding.pgbLoading.visibility = GONE
                        mBinding.btnConvert.visibility = VISIBLE
                        mBinding.btnConvertTo.isEnabled = true
                        mBinding.btnConvertFrom.isEnabled = true
                    }
                }
            }
        }
    }

    companion object {

        const val EXTRA_IS_FROM = "is_from"
        const val EXTRA_CURRENCY_SELECTED = "currency_selected"

    }

}