package com.fjzxdz.ams;

import java.rmi.RemoteException;

import org.tempuri.IOtherDataService;
import org.tempuri.IOtherDataServiceProxy;

public class TestWebservice {

    public static void main(String[] args) {
        try {
            //换成对应的proxy类
            IOtherDataServiceProxy proxy = new IOtherDataServiceProxy();
            proxy.setEndpoint("http://117.78.41.224:8017/webapi/OtherDataService.svc");
            //换成获取对应的serice
            IOtherDataService service =  proxy.getIOtherDataService();
            //调用web service提供的方法
            String result = service.getStationDataInfo("ZZWXZ886043564393", 79805080l);

            System.out.println(result);

        } catch (RemoteException e) {
            e.printStackTrace();
        }

    }

}
