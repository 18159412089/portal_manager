package cn.fjzxdz.frame.constant;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.ResourceUtils;

import java.io.File;
import java.io.IOException;

public class TestData {

	public static String waterData;

	public static String AQI;

	public static String HYD;

	public static String WTCD;

	public static String VI;

	public static String HAZ;

	public static String pollutantSource;

	public static String SEA;

	public static String BASE;

	public static String RAD;

	public static String AREA ;

	public static String RIVERS;

	public static String RISK;

	public static String ENTER;

	public static String ZPENTER;

	public static String ZPMANAGE;

	public static String envResource;

	public static String envDic;

	public static String envCommonCode;

	public static String dataMonitor;

	public static String  updateRiverData;

	public static String  townUser;

	public static String newDataServiceData;

	public static String newAirDataService;

	public static String newWaterDataService;

	static {
	    try {
            waterData = IOUtils.toString(new ClassPathResource("catalogJson/waterData.json").getInputStream(), "UTF-8");
            AQI = IOUtils.toString(new ClassPathResource("catalogJson/AQI.json").getInputStream(), "UTF-8");
            HYD = IOUtils.toString(new ClassPathResource("catalogJson/HYD.json").getInputStream(), "UTF-8");
            HAZ = IOUtils.toString(new ClassPathResource("catalogJson/HAZ.json").getInputStream(), "UTF-8");
            WTCD = IOUtils.toString(new ClassPathResource("catalogJson/WTCD.json").getInputStream(), "UTF-8");
            VI = IOUtils.toString(new ClassPathResource("catalogJson/VI.json").getInputStream(), "UTF-8");
            pollutantSource = IOUtils.toString(new ClassPathResource("catalogJson/pollutantSource.json").getInputStream(), "UTF-8");
            SEA = IOUtils.toString(new ClassPathResource("catalogJson/SEA.json").getInputStream(), "UTF-8");
            BASE = IOUtils.toString(new ClassPathResource("catalogJson/BASE.json").getInputStream(), "UTF-8");
            RAD = IOUtils.toString(new ClassPathResource("catalogJson/RAD.json").getInputStream(), "UTF-8");
            AREA = IOUtils.toString(new ClassPathResource("catalogJson/AREA.json").getInputStream(), "UTF-8");
            RIVERS = IOUtils.toString(new ClassPathResource("catalogJson/RIVERS.json").getInputStream(), "UTF-8");
            envCommonCode = IOUtils.toString(new ClassPathResource("catalogJson/envCommonCode.json").getInputStream(), "UTF-8");
            envDic = IOUtils.toString(new ClassPathResource("catalogJson/envDic.json").getInputStream(), "UTF-8");
            envResource = IOUtils.toString(new ClassPathResource("catalogJson/envResource.json").getInputStream(), "UTF-8");
            ENTER = IOUtils.toString(new ClassPathResource("catalogJson/ENTER.json").getInputStream(), "UTF-8");
			ZPENTER = IOUtils.toString(new ClassPathResource("catalogJson/ZPENTER.json").getInputStream(), "UTF-8");
			ZPMANAGE = IOUtils.toString(new ClassPathResource("catalogJson/ZPMANAGE.json").getInputStream(), "UTF-8");
            RISK = IOUtils.toString(new ClassPathResource("catalogJson/RISK.json").getInputStream(), "UTF-8");
            newAirDataService = IOUtils.toString(new ClassPathResource("catalogJson/newAirDataService.json").getInputStream(), "UTF-8");
            newWaterDataService = IOUtils.toString(new ClassPathResource("catalogJson/newWaterDataService.json").getInputStream(), "UTF-8");
            newDataServiceData = IOUtils.toString(new ClassPathResource("catalogJson/newDataServiceData.json").getInputStream(), "UTF-8");
            townUser = IOUtils.toString(new ClassPathResource("catalogJson/townUser.json").getInputStream(), "UTF-8");
            updateRiverData = IOUtils.toString(new ClassPathResource("catalogJson/updateRiverData.json").getInputStream(), "UTF-8");
            dataMonitor = IOUtils.toString(new ClassPathResource("catalogJson/dataMonitor.json").getInputStream(), "UTF-8");
        } catch (IOException e) {
            e.printStackTrace();
        }
	}

	public static void main(String[] args) {
		System.out.println(newWaterDataService);
	}

}
