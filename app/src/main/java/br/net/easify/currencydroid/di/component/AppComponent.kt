package br.net.easify.currencydroid.di.component

import br.net.easify.currencydroid.MainApplication
import br.net.easify.currencydroid.di.module.AppModule
import dagger.Component
import javax.inject.Singleton

@Singleton
@Component(modules = [AppModule::class])
interface AppComponent {
    @Component.Builder
    interface Builder {
        fun application(app: AppModule): Builder
        fun build(): AppComponent
    }

    fun inject(app: MainApplication)

}