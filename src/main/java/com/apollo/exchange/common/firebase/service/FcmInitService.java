package com.apollo.exchange.common.firebase.service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.IOException;

@Slf4j
@Service
public class FcmInitService {
    private static final String FIREBASE_CONFIG_PATH = "testfcm-ca8d2-firebase-adminsdk-d8b33-8b04ece5e6.json";

    @PostConstruct
    public void initialize(){
        try {
            ClassPathResource resource = new ClassPathResource(FIREBASE_CONFIG_PATH);

            System.out.println("Test resource: "+resource.getPath());
            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(resource.getInputStream())).build();
//            FirebaseApp.initializeApp(options);
            log.debug("Firebase application has been initialized1");
            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
                log.debug("Firebase application has been initialized2");
            } else {
                log.debug("Firebase empty" + FirebaseApp.getApps().toString());
            }
        } catch (IOException e) {
            log.debug("Error : " + e.getMessage());
        }
    }
}
