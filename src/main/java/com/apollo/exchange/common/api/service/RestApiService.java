package com.apollo.exchange.common.api.service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.lang.reflect.Type;
import java.util.*;

/**
 * @author tuyen.dev
 */
@Slf4j
@Service
public class RestApiService {

    @Autowired
    private RestTemplate restTemplate;

    /**
     * function: get
     * method: GET
     *
     * @param url    : rest api
     * @param mParam : data res in form data
     * @return
     */
    public <T> T get(String url, Map<String, Object> mParam, Class<T> className) {

        HttpHeaders headers = new HttpHeaders();
        headers.setCacheControl(CacheControl.noCache().getHeaderValue());
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Authorization", "Basic 04ed810d-c571-4052-92e2-a9a3a0dc1efb");
        HttpEntity<String> entity = new HttpEntity<>("", headers);
        ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.GET, entity, String.class, mParam);
        return new Gson().fromJson(responseEntity.getBody(), className);
    }

    public <T> T get(String authorization, String url, Map<String, Object> mParam, Class<T> className) {

        HttpHeaders headers = new HttpHeaders();
        headers.setCacheControl(CacheControl.noCache().getHeaderValue());
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Authorization", "Basic " + authorization);
        HttpEntity<String> entity = new HttpEntity<>("", headers);
        ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.GET, entity, String.class, mParam);
        return new Gson().fromJson(responseEntity.getBody(), className);
    }

    /**
     * function: post
     * method: POST
     * content-type: form-data
     *
     * @param url:    rest api
     * @param mParam: data res in form data
     */
    public <T> T post(String url, Map<String, Object> mParam, Class<T> className) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
        if (mParam != null) {
            for (String key : mParam.keySet()) {
                map.add(key, mParam.get(key));
            }
        }
        HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
        String responseEntity = restTemplate.postForObject(url, requestEntity, String.class);
        return new Gson().fromJson(responseEntity, className);
    }

    public <T> T post(String url, Map<String, Object> mParam) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);
            LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
            if (mParam != null) {
                for (String key : mParam.keySet()) {
                    map.add(key, mParam.get(key));
                }
            }
            HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
            String responseEntity = restTemplate.postForObject(url, requestEntity, String.class);

            return (T) requestEntity;
        } catch (Exception ex) {

        }
        return null;
    }

    /**
     * function: post
     * method: POST/PUT/DELETE
     * content-type: raw/json
     *
     * @param url:   rest api
     * @param mData: data res in body
     */
    public <T> T post(String url, Object mData, HttpMethod method, Class<T> className) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Authorization", "Basic 04ed810d-c571-4052-92e2-a9a3a0dc1efb");

        String body = "";
        if (mData != null) {
            body = new Gson().toJson(mData);
        }
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        ResponseEntity<String> responseEntity = restTemplate.exchange(url, method, entity, String.class);
        return new Gson().fromJson(responseEntity.getBody(), className);
    }

    /**
     * function: post
     * method: POST/PUT/DELETE
     * content-type: raw/json
     *
     * @param url:   rest api
     * @param mData: data res in body
     */
    public <T> T post(String authorization, String url, Object mData, HttpMethod method, Class<T> className) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Authorization", "Basic " + authorization);

        String body = "";
        if (mData != null) {
            body = new Gson().toJson(mData);
        }
        HttpEntity<String> entity = new HttpEntity<>(body, headers);
        ResponseEntity<String> responseEntity = restTemplate.exchange(url, method, entity, String.class);
        return new Gson().fromJson(responseEntity.getBody(), className);
    }
}
