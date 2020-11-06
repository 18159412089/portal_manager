package cn.fjzxdz.frame.config;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Properties;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.Database;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import com.atomikos.jdbc.AtomikosDataSourceBean;

@Configuration
@DependsOn("transactionManager")
@EnableJpaRepositories(basePackages = "cn.fjzxdz.frame.repository", entityManagerFactoryRef = "mainEntityManager", transactionManagerRef = "transactionManager")
@EnableConfigurationProperties(MainDatasourceProperties.class)
public class MainDbConfig {

	@Autowired
	private MainDatasourceProperties datasourceProperties;

	@Primary
	@Bean(name = "mainDataSource", initMethod = "init", destroyMethod = "close")
	public DataSource dataSource() throws SQLException {
		AtomikosDataSourceBean xaDataSource = new AtomikosDataSourceBean();
		xaDataSource.setUniqueResourceName("datasource1");
		xaDataSource.setXaDataSourceClassName("oracle.jdbc.xa.client.OracleXADataSource");
		Properties p = new Properties();
		p.setProperty ( "user" , datasourceProperties.getUser() );
		p.setProperty ( "password" , datasourceProperties.getPassword() );
		p.setProperty ( "URL" , datasourceProperties.getUrl() );
		xaDataSource.setPoolSize(10);
		xaDataSource.setXaProperties(p);
		return xaDataSource;
	}
	
	@Primary
	@Bean(name = "mainJpaVendorAdapter")
	public JpaVendorAdapter jpaVendorAdapter() {
		HibernateJpaVendorAdapter hibernateJpaVendorAdapter = new HibernateJpaVendorAdapter();
		hibernateJpaVendorAdapter.setShowSql(true);
		hibernateJpaVendorAdapter.setGenerateDdl(true);
		hibernateJpaVendorAdapter.setDatabase(Database.ORACLE);
		hibernateJpaVendorAdapter.setDatabasePlatform("org.hibernate.dialect.Oracle10gDialect");
		return hibernateJpaVendorAdapter;
	}

	@Primary
	@Bean(name = "mainEntityManager")
	@DependsOn("transactionManager")
	public LocalContainerEntityManagerFactoryBean entityManager() throws Throwable {
		HashMap<String, Object> properties = new HashMap<String, Object>();
		properties.put("hibernate.transaction.jta.platform", AtomikosJtaPlatform.class.getName());
		properties.put("javax.persistence.transactionType", "JTA");
		properties.put("hibernate.hbm2ddl.auto", "none");
		properties.put("hibernate.physical_naming_strategy", "org.springframework.boot.orm.jpa.hibernate.SpringPhysicalNamingStrategy");
		LocalContainerEntityManagerFactoryBean entityManager = new LocalContainerEntityManagerFactoryBean();
		entityManager.setJtaDataSource(dataSource());
		entityManager.setJpaVendorAdapter(jpaVendorAdapter());
		entityManager.setPackagesToScan("cn.fjzxdz.frame","com.fjzxdz.ams");
		entityManager.setPersistenceUnitName("mainPersistenceUnit");
		entityManager.setJpaPropertyMap(properties);
		return entityManager;
	}

}
