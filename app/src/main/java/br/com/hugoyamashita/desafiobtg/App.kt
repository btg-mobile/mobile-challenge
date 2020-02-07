package br.com.hugoyamashita.desafiobtg

import android.app.Application
import br.com.hugoyamashita.desafiobtg.di.currencyLayerApiModule
import br.com.hugoyamashita.desafiobtg.di.presentersModule
import org.kodein.di.KodeinAware
import org.kodein.di.android.x.androidXModule
import org.kodein.di.conf.ConfigurableKodein

class App : Application(), KodeinAware {

    override val kodein = ConfigurableKodein(mutable = true)

    init {
        kodein.addConfig {
            import(androidXModule(this@App))
            import(currencyLayerApiModule)
            import(presentersModule)
        }
    }

}