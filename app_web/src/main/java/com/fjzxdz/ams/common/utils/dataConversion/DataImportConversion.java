package com.fjzxdz.ams.common.utils.dataConversion;

public interface DataImportConversion<T> {
    T transferData(Object data);
}