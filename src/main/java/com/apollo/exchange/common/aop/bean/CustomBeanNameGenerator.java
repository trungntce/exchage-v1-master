package com.apollo.exchange.common.aop.bean;

import org.springframework.beans.factory.annotation.AnnotatedBeanDefinition;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.beans.factory.support.BeanNameGenerator;
import org.springframework.context.annotation.AnnotationBeanNameGenerator;
import org.springframework.core.type.AnnotationMetadata;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;

import java.util.Set;

/**
 * @author ionio.dev
 * @apiNote Custom BeanNameGenerator
 */
public class CustomBeanNameGenerator implements BeanNameGenerator {

    private final AnnotationBeanNameGenerator DEFAULT_GENERATOR = new AnnotationBeanNameGenerator();

    @Override
    public String generateBeanName(final BeanDefinition definition, final BeanDefinitionRegistry registry) {

        final String result;

        if (isController(definition) || isService(definition)) {
            result = generateFullBeanName((AnnotatedBeanDefinition) definition);
        } else {
            result = this.DEFAULT_GENERATOR.generateBeanName(definition, registry);
        }
        return result;
    }

    private String generateFullBeanName(final AnnotatedBeanDefinition definition) {
        return definition.getMetadata().getClassName();
    }

    private Set<String> getAnnotationTypes(final BeanDefinition definition) {

        final AnnotatedBeanDefinition annotatedDef = (AnnotatedBeanDefinition) definition;
        final AnnotationMetadata metadata = annotatedDef.getMetadata();
        return metadata.getAnnotationTypes();
    }

    private boolean isController(final BeanDefinition definition) {

        if (definition instanceof AnnotatedBeanDefinition) {
            final Set<String> annotationTypes = getAnnotationTypes(definition);

            for (final String annotationType : annotationTypes) {
                if (annotationType.equals(Controller.class.getName())) {
                    return true;
                }
                if (annotationType.equals(RestController.class.getName())) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean isService(final BeanDefinition definition) {

        if (definition instanceof AnnotatedBeanDefinition) {
            final Set<String> annotationTypes = getAnnotationTypes(definition);

            for (final String annotationType : annotationTypes) {
                if (annotationType.equals(Service.class.getName())) {
                    return true;
                }
            }
        }
        return false;
    }

}
