package org.sang.common;

import org.sang.bean.Hr;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * Created by sang on 2017/12/20.
 */
public class Util {
    public static Hr getCurrentUser() {
        Hr user = (Hr) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return user;
    }
}
