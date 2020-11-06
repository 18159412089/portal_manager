package cn.fjzxdz.frame.toolbox.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import cn.fjzxdz.frame.security.CustomerUserDetail;

import java.util.ArrayList;
import java.util.Collection;


public class SpringSecurityUtils {

    @SuppressWarnings("unchecked")
	public static <T extends User> T getCurrentUser() {
        Authentication authentication = getAuthentication();

        if (authentication == null) {
            return null;
        }

        Object principal = authentication.getPrincipal();
        if (!(principal instanceof User)) {
            return null;
        }

        return (T) principal;
    }

    /**
     * 取得当前用户的用户名, 如果当前用户未登录则返回空字符串.
     */
    public static String getCurrentUserUuid() {
        Authentication authentication = getAuthentication();

        if (authentication == null || authentication.getPrincipal() == null) {
            return "";
        }
        if ("anonymousUser".equals(authentication.getName())) {
            return authentication.getName();
        }

        return ((CustomerUserDetail) authentication.getPrincipal()).getUuid();
    }

    /**
     * 取得当前用户的用户名, 如果当前用户未登录则返回空字符串.
     */
    public static String getCurrentUserName() {
        Authentication authentication = getAuthentication();

        if (authentication == null || authentication.getPrincipal() == null) {
            return "";
        }
        if ("anonymousUser".equals(authentication.getName())) {
            return authentication.getName();
        }

        return ((CustomerUserDetail) authentication.getPrincipal()).getName();
    }

    /**
     * 取得当前用户的登录名, 如果当前用户未登录则返回空字符串.
     */
    public static String getCurrentLoginName() {
        Authentication authentication = getAuthentication();

        if (authentication == null || authentication.getPrincipal() == null) {
            return "";
        }
        if ("anonymousUser".equals(authentication.getName())) {
            return authentication.getName();
        }

        return ((CustomerUserDetail) authentication.getPrincipal()).getUsername();
    }


    /**
     * 取得当前用户登录IP, 如果当前用户未登录则返回空字符串.
     */
    public static String getCurrentUserIp() {
        Authentication authentication = getAuthentication();

        if (authentication == null) {
            return "";
        }

        Object details = authentication.getDetails();
        if (!(details instanceof WebAuthenticationDetails)) {
            return "";
        }

        WebAuthenticationDetails webDetails = (WebAuthenticationDetails) details;
        return webDetails.getRemoteAddress();
    }

    /**
     * 判断用户是否拥有角色, 如果用户拥有参数中的任意一个角色则返回true.
     */
    public static boolean hasAnyRole(String... roles) {
        Authentication authentication = getAuthentication();

        if (authentication == null) {
            return false;
        }

        Collection<? extends GrantedAuthority> grantedAuthorityList = authentication.getAuthorities();
        for (String role : roles) {
            for (GrantedAuthority authority : grantedAuthorityList) {
                if (role.equals(authority.getAuthority())) {
                    return true;
                }
            }
        }

        return false;
    }


    /**
     * 取得Authentication, 如当前SecurityContext为空时返回null.
     */
    public static Authentication getAuthentication() {
        SecurityContext context = SecurityContextHolder.getContext();

        if (context == null) {
            return null;
        }

        return context.getAuthentication();
    }

    /**
     * 如何描述该方法
     *
     * @return
     */
    public static Collection<SimpleGrantedAuthority> getCurrentUserAuthorities() {
        Collection<SimpleGrantedAuthority> grantedAuthorities = new ArrayList<SimpleGrantedAuthority>(0);
        UserDetails user = SpringSecurityUtils.getCurrentUser();
        if (user != null) {
            for (GrantedAuthority authority : user.getAuthorities()) {
                grantedAuthorities.add(new SimpleGrantedAuthority(authority.getAuthority()));
            }
        }
        return grantedAuthorities;
    }
}
