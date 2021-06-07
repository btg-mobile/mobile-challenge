package br.com.vicentec12.mobilechallengebtg.ui.currencies

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SearchView
import androidx.core.os.bundleOf
import androidx.recyclerview.widget.DividerItemDecoration
import br.com.vicentec12.mobilechallengebtg.CurrencyApp
import br.com.vicentec12.mobilechallengebtg.R
import br.com.vicentec12.mobilechallengebtg.databinding.ActivityCurrenciesBinding
import br.com.vicentec12.mobilechallengebtg.di.ViewModelProviderFactory
import br.com.vicentec12.mobilechallengebtg.ui.home.HomeActivity.Companion.EXTRA_CURRENCY_SELECTED
import br.com.vicentec12.mobilechallengebtg.ui.home.HomeActivity.Companion.EXTRA_IS_FROM
import javax.inject.Inject

class CurrenciesActivity : AppCompatActivity() {

    private lateinit var mBinding: ActivityCurrenciesBinding

    @Inject
    lateinit var mFactory: ViewModelProviderFactory

    private val mViewModel: CurrenciesViewModel by viewModels { mFactory }

    private val mIsFrom: Boolean by lazy {
        intent.getBooleanExtra(EXTRA_IS_FROM, false)
    }

    private val mAdapter: CurrenciesAdapter by lazy {
        CurrenciesAdapter { _, mCurrency, _ ->
            val intent = Intent().apply {
                putExtras(bundleOf(EXTRA_CURRENCY_SELECTED to mCurrency, EXTRA_IS_FROM to mIsFrom))
            }
            setResult(RESULT_OK, intent)
            finish()
        }
    }

    private var mMenuSearch: MenuItem? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        (applicationContext as CurrencyApp).mAppComponent.currenciesComponent().create()
            .inject(this)
        super.onCreate(savedInstanceState)
        mBinding = ActivityCurrenciesBinding.inflate(layoutInflater).apply {
            setContentView(root)
            viewModel = mViewModel
            lifecycleOwner = this@CurrenciesActivity
            supportActionBar?.title =
                if (mIsFrom) getString(R.string.convert_from) else getString(R.string.convert_to)
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
        }
        init()
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_currencies, menu)
        setupSearchView(menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            android.R.id.home -> {
                onBackPressed()
                true
            }
            R.id.action_menu_sort_by -> {
                mMenuSearch?.collapseActionView()
                mViewModel.currencies.value?.let {
                    val mItems = arrayOf<CharSequence>(
                        getString(R.string.by_code),
                        getString(R.string.by_name)
                    )
                    AlertDialog.Builder(this).setTitle(R.string.sort_by)
                        .setSingleChoiceItems(mItems, (mViewModel.sortBy.value ?: 0)) { _, mItem ->
                            mViewModel.sortBy.value = mItem
                        }.setPositiveButton(R.string.sort) { _, _ ->
                            mViewModel.sortBy()
                        }.setNegativeButton(R.string.cancel, null).show()
                }
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        mBinding.rvwCurrencies.adapter = null
        mMenuSearch?.collapseActionView()
    }

    private fun init() {
        setupRecyclerView()
        setupListeners()
        mViewModel.listCurrencies()
    }

    private fun setupRecyclerView() {
        with(mBinding.rvwCurrencies) {
            setHasFixedSize(true)
            mAdapter.setHasStableIds(true)
            adapter = mAdapter
            if (itemDecorationCount == 0)
                addItemDecoration(
                    DividerItemDecoration(
                        this@CurrenciesActivity,
                        DividerItemDecoration.VERTICAL
                    )
                )
        }
    }

    private fun setupListeners() {
        with(mBinding) {
            lytErrorMessage.btnTryAgain.setOnClickListener {
                mViewModel.listCurrencies()
            }
        }
    }

    private fun setupSearchView(mMenu: Menu?) {
        mMenuSearch = mMenu?.findItem(R.id.action_menu_search)
        mMenuSearch?.apply {
            val mSearchView = this.actionView as SearchView
            mSearchView.queryHint = getString(R.string.search_dots)
            mSearchView.setOnQueryTextListener(mOnQueryTextListener)
        }
    }

    private val mOnQueryTextListener = object : SearchView.OnQueryTextListener {
        override fun onQueryTextSubmit(query: String?) = false

        override fun onQueryTextChange(newText: String?): Boolean {
            mViewModel.search(newText ?: "")
            return true
        }
    }

    companion object {


        fun newIntentInstance(mContext: Context, mIsFrom: Boolean) =
            Intent(mContext, CurrenciesActivity::class.java).apply {
                putExtra(EXTRA_IS_FROM, mIsFrom)
            }

    }
}