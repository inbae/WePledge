package com.hubba.wepledge.view;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class ViewUtils {
	public static boolean hasError (String errorObject, Enum<?> toCheck) {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		EnumSet<?> errors = (EnumSet<?>)req.getAttribute(errorObject);
		return errors.contains(toCheck);
	}
}