package com.natanbf.currencyconversion.domain.usecase

import com.natanbf.currencyconversion.domain.repository.CurrencyConverterRepository
import com.natanbf.currencyconversion.util.Constant
import com.natanbf.currencyconversion.util.isNumeric
import com.natanbf.currencyconversion.util.validationIfIsLessOrEqualZero
import com.natanbf.currencyconversion.util.Result
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import kotlinx.coroutines.flow.map
import java.math.BigDecimal
import java.math.RoundingMode
import javax.inject.Inject

fun interface ConvertedCurrencyUseCase : (String, String, String) -> Flow<Result<String>>

class ConvertedCurrencyUseCaseImpl @Inject constructor(
    private val repository: CurrencyConverterRepository,
    private val coroutineDispatcher: CoroutineDispatcher
) : ConvertedCurrencyUseCase {
    override fun invoke(amount: String, from: String, to: String): Flow<Result<String>> = flow {
        repository.getCurrentQuote
            .map { model -> convertedCurrency(
                    amount = amount,
                    from = from,
                    to = to,
                    model.currentQuote.mapValues { BigDecimal(it.value) })
            }
            .catch { throwable ->
                emit(Result.Error(message = throwable.message, throwable = throwable))
            }
            .flowOn(coroutineDispatcher)
            .collect { result ->
                emit(Result.Success(data = result))
            }
    }

    private fun convertedCurrency(
        amount: String,
        from: String,
        to: String,
        currentQuote: Map<String, BigDecimal>
    ): String {
        return if (amount.isNumeric()) {
            val amountBigDecimal = validationBigDecimal(amount)
            if (from == Constant.USD || to == Constant.USD) {
                if (from == Constant.USD)
                    amountBigDecimal
                        .multiply(currentQuote.getValue(Constant.USD.plus(to)))
                        .setScale(SCALE, RoundingMode.HALF_UP)
                        .toPlainString()
                else amountBigDecimal
                    .divide(
                        currentQuote.getValue(Constant.USD.plus(from)),
                        SCALE,
                        RoundingMode.HALF_UP
                    ).toPlainString()
            }
            else {
                val conversionFrom =
                    currentQuote.getValue(Constant.USD.plus(from))
                val conversionTo =
                    currentQuote.getValue(Constant.USD.plus(to))

                amountBigDecimal.multiply(conversionTo).divide(
                    conversionFrom,
                    SCALE,
                    RoundingMode.HALF_UP
                ).toPlainString()
            }
        } else String()
    }

    private fun validationBigDecimal(amount: String) =
        BigDecimal(amount).validationIfIsLessOrEqualZero()


    private companion object {
        const val SCALE = 2
    }
}