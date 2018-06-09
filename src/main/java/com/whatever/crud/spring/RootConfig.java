package com.whatever.crud.spring;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.apache.ibatis.session.ExecutorType;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.*;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.beans.PropertyVetoException;
import java.io.IOException;

@Configuration
@PropertySource("classpath:dbconfig.properties")
@ComponentScan(basePackages = {"com.whatever.crud"},
    excludeFilters = {
        @ComponentScan.Filter (type = FilterType.ANNOTATION, value = Controller.class)
    })
@EnableTransactionManagement
public class RootConfig implements EnvironmentAware, ApplicationContextAware {

    // https://stackoverflow.com/questions/19421092/autowired-environment-is-null
    // Autowire 在显式的bean之后才初始化，所以没法用
    //@Autowired()
    private Environment env;

    // I need the applicationContext to get resources
    private ApplicationContext applicationContext;

    @Override
    public void setEnvironment(final Environment environment) {
        this.env = environment;
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    @Bean()
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

    @Bean("transactionManager")
    public DataSourceTransactionManager transactionManager() throws PropertyVetoException {
        DataSourceTransactionManager tm = new DataSourceTransactionManager();
        tm.setDataSource(dataSource());
        return tm;
    }

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

//    <!-- transaction config -->
//    <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager" >
//        <property name="dataSource" ref="pooledDataSource"/>
//    </bean>
//
//    <aop:config>
//        <aop:pointcut id="txPointcut" expression="execution(* com.whatever.crud.service..*(..))"/>
//        <aop:advisor advice-ref="txAdvice" pointcut-ref="txPointcut"/>
//    </aop:config>
//
//    <!-- tx:advice 还需要指定 transaction-manager, 只是默认就叫transactionManager -->
//    <tx:advice id="txAdvice">
//        <tx:attributes>
//            <tx:method name="*"/>
//            <tx:method name="get*" read-only="true"/>
//        </tx:attributes>
//    </tx:advice>
}
