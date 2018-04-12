package project01.project01;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import project01.project01.db_services.CustomUserDetailService;




@Configuration
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
    @Autowired
    private CustomUserDetailService userDetailService;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailService).passwordEncoder(new BCryptPasswordEncoder());
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().ignoringAntMatchers("/mybot");
        http.authorizeRequests()
                    .antMatchers("/","/mybot","/login","/oauth_login","/css/*","/js/*","/scss/*","/font/roboto/*","login/oauth2/code/google","/logout").permitAll()
                   // .anyRequest().permitAll()
                    .anyRequest().authenticated()
                   // .antMatchers("/lk").authenticated()
                .and()
                    .oauth2Login().loginPage("/login")
                    .failureUrl("/login?error")
                    .defaultSuccessUrl("/lk")
                .and()
                    .formLogin()
                    .loginPage("/login").permitAll()
                    .defaultSuccessUrl("/lk")
                .and()
                .logout().logoutRequestMatcher(new AntPathRequestMatcher("/logout")).logoutSuccessUrl("/login");
    }
}
