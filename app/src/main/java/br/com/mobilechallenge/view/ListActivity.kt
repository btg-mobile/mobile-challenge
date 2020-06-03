package br.com.mobilechallenge.view

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

import br.com.mobilechallenge.R
import br.com.mobilechallenge.model.bean.ListBean
import br.com.mobilechallenge.presenter.list.MVP
import br.com.mobilechallenge.presenter.list.Presenter
import br.com.mobilechallenge.view.adapter.ItemAdapter
import br.com.mobilechallenge.view.components.Progress

class ListActivity : DefaultActivity(), MVP.View {
    private lateinit var progress: Progress
    private lateinit var presenter: MVP.Presenter
    private lateinit var rv: RecyclerView
    private lateinit var adapter: ItemAdapter
    private var item: ListBean? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list)

        setupToolBar(R.id.toolbar)
        setActionBarTitle("")
        setActionBarSubTitle("")
        setActionBarHomeButton()

        progress = findViewById(R.id.progressList)
        progress.hide()

        presenter = Presenter()
        presenter.setView(this)
        presenter.retriveData()

        onLoad()
    }

    private fun onLoad() {
        adapter = ItemAdapter(this, presenter.items)

        val layoutManager = LinearLayoutManager(this)
            layoutManager.orientation = LinearLayoutManager.VERTICAL

        rv = findViewById(R.id.rv)
        rv.setHasFixedSize(true)
        rv.layoutManager = layoutManager
        rv.adapter = adapter
    }

    fun result(item: ListBean) {
        this.item = item
        back(Activity.RESULT_OK)
    }

    override fun onSupportNavigateUp(): Boolean {
        back(Activity.RESULT_CANCELED)
        return true
    }

    override fun showProgressBar(visible: Int) {
        when(visible) {
            View.VISIBLE -> progress.show()
            View.GONE    -> progress.hide()
        }
    }

    override fun updateListRecycler() {
        adapter.notifyDataSetChanged()
    }

    override fun back(resultCode: Int) {
        var bundle = Bundle()
            bundle.putParcelable("ITEM_RESULT", this.item)

        val intent = Intent(this, MainActivity::class.java)
            intent.putExtras(bundle)

        setResult(resultCode, intent)
        finish()
        animLeftToRight()
    }
}