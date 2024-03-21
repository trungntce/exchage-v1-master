package com.apollo.exchange.common.utils;

import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.Optional;


public class UrlUtils {


	private UrlUtils() {}

	public static String build(String url, Map<String, Object> mParam){
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url);
		for(String key : mParam.keySet()){
			builder.queryParam(key, mParam.get(key));
		}
		return builder.build().toUriString();
	}

	public static String getReturnUrl(HttpServletRequest request, HttpServletResponse response) {
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		if (savedRequest == null) {
			return request.getSession().getServletContext().getContextPath();
		}
		return savedRequest.getRedirectUrl();
	}
	
	public static String getRefererUrl(HttpServletRequest request) {
		return (String)request.getHeader("Referer");
	}

	/**
	 * Returns the viewName to return for coming back to the sender url
	 *
	 * @param request Instance of {@link HttpServletRequest} or use an injected instance
	 * @return Optional with the view name. Recomended to use an alternativa url with
	 * {@link Optional#orElse(Object)}
	 */
	public static Optional<String> getPreviousPageByRequest(HttpServletRequest request)
	{
		return Optional.ofNullable(request.getHeader("Referer")).map(requestUrl -> "redirect:" + requestUrl);
	}
}
