package com.apollo.exchange.config.database;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.io.IOException;

/**
 * @apiNote Database Connection Configuration
 * @author  ionio.dev
 */
@Slf4j
@Configuration
@EnableTransactionManagement
public class DatabaseConfig {

    @Value("${maria.driver.class.name}")
    private String driverClassName = null;

    @Value("${maria.connection.properties}")
    private String connectionProperties = null;

    @Value("${maria.initial.pool.size}")
    private Integer initialPoolSize = null;

    @Value("${maria.max.pool.size}")
    private Integer maxPoolSize = null;

    @Value("${maria.min.pool.size}")
    private Integer minPoolSize = null;

    @Value("${maria.jdbc.url.real}")
    private String jdbcUrlReal = null;

    @Value("${maria.user.name}")
    private String userName = null;

    @Value("${maria.user.password}")
    private String userPassword = null;

    @Bean
    public DataSource dataSource() throws Exception {

        BasicDataSource basicDataSource = new BasicDataSource();
        basicDataSource.setDriverClassName(driverClassName);
        basicDataSource.setConnectionProperties(connectionProperties);
        basicDataSource.setInitialSize (initialPoolSize);
        basicDataSource.setMaxTotal(maxPoolSize);
        basicDataSource.setMinIdle(minPoolSize);
        basicDataSource.setUrl(jdbcUrlReal);
        basicDataSource.setUsername(userName);
        basicDataSource.setPassword(userPassword);
        return basicDataSource;
    }

    @Bean
    public SqlSessionFactoryBean sqlSessionFactory(DataSource dataSource, ApplicationContext applicationContext)
            throws IOException {

        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
        sqlSessionFactory.setDataSource(dataSource);
        sqlSessionFactory.setConfigLocation(applicationContext.getResource("classpath:mybatis-config.xml"));
        sqlSessionFactory.setMapperLocations(applicationContext.getResources("classpath*:/**/**/maps/*.xml"));
        return sqlSessionFactory;
    }

    @Bean
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
        return new SqlSessionTemplate(sqlSessionFactory);
    }

    @Bean
    public PlatformTransactionManager transactionManager(DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }
}
