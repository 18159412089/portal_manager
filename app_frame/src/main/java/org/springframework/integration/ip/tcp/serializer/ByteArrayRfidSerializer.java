/*
 * Copyright 2002-2016 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.springframework.integration.ip.tcp.serializer;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.springframework.integration.mapping.MessageMappingException;

/**
 * Reads data in an InputStream to a byte[]; data must be terminated by \r\n
 * (not included in resulting byte[]).
 * Writes a byte[] to an OutputStream and adds \r\n.
 *
 * @author Gary Russell
 * @since 2.0
 */
public class ByteArrayRfidSerializer extends AbstractPooledBufferByteArraySerializer {

	/**
	 * A single reusable instance.
	 */
	public static final ByteArrayRfidSerializer INSTANCE = new ByteArrayRfidSerializer();

	public static final int STX = 0xA0;

	/**
	 * Reads the data in the inputStream to a byte[]. Data must be prefixed
	 * with an ASCII STX character, and terminated with an ASCII ETX character.
	 * Throws a {@link SoftEndOfStreamException} if the stream
	 * is closed immediately before the STX (i.e. no data is in the process of
	 * being read).
	 *
	 */
	@Override
	public byte[] doDeserialize(InputStream inputStream, byte[] buffer) throws IOException {
		DataInputStream dataInputStream = new DataInputStream(inputStream);
		int bite = dataInputStream.read();
		if (bite < 0) {
			throw new SoftEndOfStreamException("Stream closed between payloads");
		}
		int n = 0;
		try {
			if (bite != STX) {
				throw new MessageMappingException("Expected STX to begin message");
			}
			int len = dataInputStream.read();
			if (len != 0x05) {
				int address = dataInputStream.read();
				int command = dataInputStream.read();
				byte[] ant = new byte[1];
				dataInputStream.readFully(ant);//该字节高六位代表频点参数，低两位是天线号
				System.out.println("======"+getLow2(ant[0]));
//				byte ant = dataInputStream.read();//该字节高六位代表频点参数，低两位是天线号
				byte[] pc = new byte[2];
				dataInputStream.readFully(pc);
				byte[] epc = new byte[len - 7];
				dataInputStream.readFully(epc);
				int rssi = dataInputStream.read();
				int check = dataInputStream.read();
				return epc;
			}else {
				throw new IOException("EPC not found before max message length: "
						+ this.maxMessageSize);
			}
		}
		catch (IOException e) {
			publishEvent(e, buffer, n);
			throw e;
		}
		catch (RuntimeException e) {
			publishEvent(e, buffer, n);
			throw e;
		}
	}
	
	public static int getLow2(byte data){//获取低四位
	    int low;
	    low = (data & 0x03);
	    return low;
	}

	/**
	 * Writes the byte[] to the stream, prefixed by an ASCII STX character and
	 * terminated with an ASCII ETX character.
	 */
	@Override
	public void serialize(byte[] bytes, OutputStream outputStream) throws IOException {
		outputStream.write(STX);
		outputStream.write(bytes);
	}

}
