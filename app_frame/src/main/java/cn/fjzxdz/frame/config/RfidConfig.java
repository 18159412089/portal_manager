package cn.fjzxdz.frame.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.serializer.DefaultSerializer;
import org.springframework.integration.annotation.ServiceActivator;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.integration.ip.tcp.TcpReceivingChannelAdapter;
import org.springframework.integration.ip.tcp.connection.TcpNetServerConnectionFactory;
import org.springframework.integration.ip.tcp.serializer.ByteArrayRfidSerializer;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageHandler;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.MessagingException;

@Configuration
public class RfidConfig{
	@Value("${rfid.port}")
    private int port;

	@Bean
	public TcpNetServerConnectionFactory cf() {
		TcpNetServerConnectionFactory cf = new TcpNetServerConnectionFactory(port);
		cf.setDeserializer(new ByteArrayRfidSerializer());
		cf.setSerializer(new DefaultSerializer());
		return cf;
	}

	@Bean
	public TcpReceivingChannelAdapter inOne(TcpNetServerConnectionFactory cf) {
		TcpReceivingChannelAdapter adapter = new TcpReceivingChannelAdapter();
		adapter.setConnectionFactory(cf);
		adapter.setOutputChannel(outputChannel());
		return adapter;
	}
	
	@Bean
	public DirectChannel outputChannel() {
		return new DirectChannel();
	}
	
	@Bean
    @ServiceActivator(inputChannel = "outputChannel")
    public MessageHandler handler() {
        return new MessageHandler() {
			@SuppressWarnings("unused")
			@Override
			public void handleMessage(Message<?> message) throws MessagingException {
				MessageHeaders messageh = message.getHeaders();
				Object messageb = message.getPayload();
//				String str= new String ((byte[])messageb);
//				System.out.println("======="+str);
				System.out.println("======"+bytesToHexString((byte[])messageb));
			}
        };
    }
	
	public String bytesToHexString(byte[] bArray) {
        StringBuffer sb = new StringBuffer(bArray.length);
        String sTemp;
        for (int i = 0; i < bArray.length; i++) {
            sTemp = Integer.toHexString(0xFF & bArray[i]);
            if (sTemp.length() < 2)
                sb.append(0);
            sb.append(sTemp.toUpperCase());
        }
        return sb.toString();
    }
}
