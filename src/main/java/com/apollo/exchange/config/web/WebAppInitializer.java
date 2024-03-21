package com.apollo.exchange.config.web;

import com.apollo.exchange.config.filter.AuthenticationFilter;
import com.navercorp.lucy.security.xss.servletfilter.XssEscapeServletFilter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.*;
import java.util.EnumSet;
import java.util.Locale;

/**
 * @author ionio.dev
 * @apiNote Application Initializer
 */
public class WebAppInitializer implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

        AnnotationConfigWebApplicationContext applicationContext = new AnnotationConfigWebApplicationContext();
        applicationContext.setServletContext(servletContext);
        applicationContext.register(WebMvcConfig.class);
        applicationContext.refresh();

        servletContext.addListener(new RequestContextListener());
        servletContext.addListener(new ContextLoaderListener(applicationContext));

        // default Language Setup
        Locale.setDefault(new Locale("en", "US"));

        DispatcherServlet dispatcherServlet = new DispatcherServlet(applicationContext);
        dispatcherServlet.setThrowExceptionIfNoHandlerFound(true);

        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", dispatcherServlet);
        dispatcher.addMapping("/");

        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);
        FilterRegistration.Dynamic characterEncoding =
                servletContext.addFilter("characterEncodingFilter", characterEncodingFilter);
        characterEncoding.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");

        FilterRegistration.Dynamic xssFilter = servletContext.addFilter("xssFilter", new XssEscapeServletFilter());
        xssFilter.addMappingForUrlPatterns(EnumSet.allOf(DispatcherType.class), true, "/*");

        FilterRegistration.Dynamic AuthenticationFilter = servletContext.addFilter("AuthenticationFilter", new AuthenticationFilter());
        AuthenticationFilter.addMappingForUrlPatterns(null, true, "/*");
        AuthenticationFilter.setAsyncSupported(true);
    }

}
