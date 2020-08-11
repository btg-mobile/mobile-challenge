package com.gft.domain.common

import io.reactivex.FlowableTransformer

abstract class FlowableRxTransformer<T>: FlowableTransformer<T,T>