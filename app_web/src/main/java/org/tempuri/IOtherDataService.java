/**
 * IOtherDataService.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.tempuri;

public interface IOtherDataService extends java.rmi.Remote {
    public java.lang.String getMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException;
    public java.lang.String getStationDayData(java.lang.String key, java.util.Calendar dataTime) throws java.rmi.RemoteException;
    public java.lang.String getHourData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException;
    public java.lang.String getBetaMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException;
    public java.lang.String getStationDataInfo(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException;
    public java.lang.String getBetaHourData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException;
    public java.lang.String getCarMonitorData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException;
    public java.lang.String getRealtimeAlarm(java.lang.String key) throws java.rmi.RemoteException;
    public java.lang.String getMinMinuteData(java.lang.String key, java.util.Calendar dtime) throws java.rmi.RemoteException;
    public java.lang.String getMinMinuteStateData(java.lang.String key, java.util.Calendar dtime, java.lang.String stype) throws java.rmi.RemoteException;
    public java.lang.String getRechargeHourData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException;
    public java.lang.Boolean setUserPassword(java.lang.String key, java.lang.String account, java.lang.String old, java.lang.String newstr) throws java.rmi.RemoteException;
    public java.lang.String getBetaVOCMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException;
    public java.lang.String getBetaVOCHourData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException;
    public java.lang.String getPoisonMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException;
    public java.lang.String getPoisonHourData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException;
    public java.lang.String getDZBMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException;
    public java.lang.String getDZBHourData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException;
}
