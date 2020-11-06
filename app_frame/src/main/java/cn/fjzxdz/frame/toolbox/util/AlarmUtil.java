package cn.fjzxdz.frame.toolbox.util;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;

public class AlarmUtil {
	public static String startAlarm(String ip,Integer port,Integer lazy) throws Exception {
		Socket s = new Socket(); 
        s.connect(new InetSocketAddress(InetAddress.getByName(ip), port)); //连接服务器
        InputStream in = s.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(in));
        OutputStream os=s.getOutputStream();
        String atCommand = "";
        if (null!=lazy) {
        	atCommand = String.format("AT+STACH0=1,%d",lazy);//打开声光报警60秒
		} else {
			atCommand = String.format("AT+STACH0=1");//打开声光报警60秒
		}
        atCommand = String.format("%s\r\n", atCommand);
        BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os));
        writer.write(atCommand);
        writer.flush();
        String result = reader.readLine();
        os.close();
        s.close();
		return result;
	}
	
	public static String stopAlarm(String ip,Integer port,Integer lazy) throws Exception {
		Socket s = new Socket(); 
        s.connect(new InetSocketAddress(InetAddress.getByName(ip), port)); //连接服务器
        InputStream in = s.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(in));
        OutputStream os=s.getOutputStream();
        String atCommand = "";
        if (null!=lazy) {
        	atCommand = String.format("AT+STACH0=0,%d",lazy);//打开声光报警60秒
		} else {
			atCommand = String.format("AT+STACH0=0");//打开声光报警60秒
		}
        atCommand = String.format("%s\r\n", atCommand);
        BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os));
        writer.write(atCommand);
        writer.flush();
        String result = reader.readLine();
        os.close();
        s.close();
		return result;
	}

    public static void main(String[] args) throws Exception {
    	String str1=AlarmUtil.startAlarm("192.169.8.249", 12345, 60);
    	System.out.println("========"+str1);
        Thread.sleep(5000);
        String str2=AlarmUtil.stopAlarm("192.169.8.249", 12345, null);
    	System.out.println("========"+str2);
    }

}