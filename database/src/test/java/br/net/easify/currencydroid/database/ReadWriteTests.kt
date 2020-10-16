package br.net.easify.currencydroid.database

import android.content.Context
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import br.net.easify.currencydroid.database.dao.CurrencyDao
import br.net.easify.currencydroid.database.model.Currency
import org.junit.*
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
class ReadWriteTests {

    @get:Rule
    var instantTask = InstantTaskExecutorRule()

    private lateinit var database: AppDatabase
    private lateinit var currencyDao: CurrencyDao

    @Before
    fun createDb() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        database = Room
            .inMemoryDatabaseBuilder(context, AppDatabase::class.java)
            .allowMainThreadQueries()
            .build()

        currencyDao = database.currencyDao()
    }

    @After
    fun closeDb() {
        database.close()
    }

    private fun insertCurrency() {
        val currencyList: ArrayList<Currency> = arrayListOf()
        currencyList.add(Currency(0, "BRL", "Brazilian Real"))
        currencyDao.insert(currencyList)
    }

    @Test
    fun `CURRENCY - test Currency Insert`() {
        currencyDao.deleteAll()
        var currencyList = currencyDao.getAll()
        var size = currencyList.size
        Assert.assertTrue(size == 0)
        insertCurrency()
        currencyList = currencyDao.getAll()
        size = currencyList.size
        Assert.assertTrue(size == 1)
    }
}