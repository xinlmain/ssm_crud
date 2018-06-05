package com.whatever.crud.spring;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.apache.ibatis.session.ExecutorType;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.*;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;

import java.beans.PropertyVetoException;
import java.io.IOException;

@Configuration
@PropertySource("classpath:dbconfig.properties")
@ComponentScan(basePackages = {"com.whatever.crud"},
    excludeFilters = {
        @ComponentScan.Filter (type = FilterType.ANNOTATION, value = Controller.class)
    })
public class RootConfig implements EnvironmentAware, ApplicationContextAware {

    //@Autowired()
    private Environment env;

    @Override
    public void setEnvironment(final Environment environment) {
        this.env = environment;
    }

    @Bean
    public ComboPooledDataSource dataSource() throws PropertyVetoException {
        ComboPooledDataSource dataSource = new ComboPooledDataSource();
        dataSource.setJdbcUrl(env.getProperty("jdbc.jdbcUrl"));
        dataSource.setDriverClass(env.getProperty("jdbc.driverClass"));
        dataSource.setUser(env.getProperty("jdbc.user"));
        dataSource.setPassword(env.getProperty("jdbc.password"));
        return dataSource;
    }

    @Bean
    public SqlSessionFactoryBean sessionFactory() throws PropertyVetoException, IOException {
        SqlSessionFactoryBean sf = new SqlSessionFactoryBean();
        sf.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
        sf.setDataSource(dataSource());
        sf.setMapperLocations(applicationContext.getResources("classpath:mapper/*.xml"));
        return sf;
    }

    @Bean
    public MapperScannerConfigurer mapperScannerConfigurer() {
        MapperScannerConfigurer msc = new MapperScannerConfigurer();
        msc.setBasePackage("com.whatever.crud.dao");
        return msc;
    }

    @Bean
    public SqlSessionTemplate sqlSessionTemplate() throws Exception {
        return new SqlSessionTemplate(sessionFactory().getObject(), ExecutorType.BATCH);
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    private ApplicationContext applicationContext;

//    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
//        <property name="configLocation" value="classpath:mybatis-config.xml"/>
//        <property name="dataSource" ref="pooledDataSource"/>
//        <property name="mapperLocations" value="classpath:mapper/*.xml"/>
//    </bean>
//
//    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
//        <property name="basePackage" value="com.whatever.crud.dao"/>
//    </bean>
//
//    <bean id="sessionTemplate" class="org.mybatis.spring.SqlSessionTemplate">
//        <constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory"/>
//        <constructor-arg name="executorType" value="BATCH"/>
//    </bean>
}
