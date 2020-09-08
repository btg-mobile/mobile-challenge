package com.example.conversordemoeda.model.repositorio.modelResponseCustom

import com.example.conversordemoeda.model.entidades.Cotacao
import com.example.conversordemoeda.model.repositorio.ResponseCustom
import com.example.conversordemoeda.model.repositorio.STATUS

class CotacaoResponseCustom(
    var cotacao: Cotacao,
    errorMessage: String = "",
    status: STATUS
) : ResponseCustom(errorMessage, status)