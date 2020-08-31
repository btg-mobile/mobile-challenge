package com.example.convertermoeda.retrofit.webclient

class ResultApi<Sucesso> {

    private constructor(value: Sucesso) {
        this.value = value
    }

    private constructor(erro: String) {
        this.erro = erro
    }

    var value: Sucesso? = null
    var erro: String? = null

    fun isSucesso() = value != null
    fun isErro() = erro != null

    companion object {
        fun <Sucesso> createSucesso(value: Sucesso) =
            ResultApi(value)
        fun <Sucesso> createErro(erro: String) =
            ResultApi<Sucesso>(erro)
    }
}