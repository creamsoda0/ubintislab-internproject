package com.ubintis.board.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class ScurityFilterChain {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable() // 개발 단계에서는 꺼두는 것이 편합니다.
            .authorizeRequests()
                .antMatchers("/member/login", "/member/join", "/resources/**").permitAll() // 누구나 접근 가능
                .anyRequest().authenticated() // 그 외 모든 요청은 로그인 필요
            .and()
            .formLogin()
                .loginPage("/member/login")           // 로그인 페이지 URL
                .loginProcessingUrl("/member/loginProc") // <form action="...">에 쓸 URL
                .defaultSuccessUrl("/", true)          // 로그인 성공 시 이동할 페이지
                .usernameParameter("user_id")          // 아이디 input name
                .passwordParameter("user_pw")          // 비밀번호 input name
                .permitAll()
            .and()
            .logout()
                .logoutUrl("/member/logout")
                .logoutSuccessUrl("/")
                .invalidateHttpSession(true)           // 세션 무효화
                .deleteCookies("JSESSIONID");          // 쿠키 삭제

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        // 비밀번호를 암호화해서 저장/비교하기 위한 빈
        return new BCryptPasswordEncoder();
    }
}
