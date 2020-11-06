package org.tempuri;

public class IOtherDataServiceProxy implements org.tempuri.IOtherDataService {
  private String _endpoint = null;
  private org.tempuri.IOtherDataService iOtherDataService = null;
  
  public IOtherDataServiceProxy() {
    _initIOtherDataServiceProxy();
  }
  
  public IOtherDataServiceProxy(String endpoint) {
    _endpoint = endpoint;
    _initIOtherDataServiceProxy();
  }
  
  private void _initIOtherDataServiceProxy() {
    try {
      iOtherDataService = (new org.tempuri.OtherDataServiceLocator()).getBasicHttpBinding_IOtherDataService();
      if (iOtherDataService != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iOtherDataService)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iOtherDataService)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iOtherDataService != null)
      ((javax.xml.rpc.Stub)iOtherDataService)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public org.tempuri.IOtherDataService getIOtherDataService() {
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService;
  }
  
  public java.lang.String getMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getMinuteData(key, maxid);
  }
  
  public java.lang.String getStationDayData(java.lang.String key, java.util.Calendar dataTime) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getStationDayData(key, dataTime);
  }
  
  public java.lang.String getHourData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getHourData(key, maxid);
  }
  
  public java.lang.String getBetaMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getBetaMinuteData(key, maxid);
  }
  
  public java.lang.String getStationDataInfo(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getStationDataInfo(key, maxID);
  }
  
  public java.lang.String getBetaHourData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getBetaHourData(key, maxID);
  }
  
  public java.lang.String getCarMonitorData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getCarMonitorData(key, maxID);
  }
  
  public java.lang.String getRealtimeAlarm(java.lang.String key) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getRealtimeAlarm(key);
  }
  
  public java.lang.String getMinMinuteData(java.lang.String key, java.util.Calendar dtime) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getMinMinuteData(key, dtime);
  }
  
  public java.lang.String getMinMinuteStateData(java.lang.String key, java.util.Calendar dtime, java.lang.String stype) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getMinMinuteStateData(key, dtime, stype);
  }
  
  public java.lang.String getRechargeHourData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getRechargeHourData(key, maxid);
  }
  
  public java.lang.Boolean setUserPassword(java.lang.String key, java.lang.String account, java.lang.String old, java.lang.String newstr) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.setUserPassword(key, account, old, newstr);
  }
  
  public java.lang.String getBetaVOCMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getBetaVOCMinuteData(key, maxid);
  }
  
  public java.lang.String getBetaVOCHourData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getBetaVOCHourData(key, maxID);
  }
  
  public java.lang.String getPoisonMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getPoisonMinuteData(key, maxid);
  }
  
  public java.lang.String getPoisonHourData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getPoisonHourData(key, maxID);
  }
  
  public java.lang.String getDZBMinuteData(java.lang.String key, java.lang.Long maxid) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getDZBMinuteData(key, maxid);
  }
  
  public java.lang.String getDZBHourData(java.lang.String key, java.lang.Long maxID) throws java.rmi.RemoteException{
    if (iOtherDataService == null)
      _initIOtherDataServiceProxy();
    return iOtherDataService.getDZBHourData(key, maxID);
  }
  
  
}