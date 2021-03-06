package project01.project01;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import project01.project01.db_services.CustomUserDetailService;
import project01.project01.db_services.UserRepository;

@EnableWebSecurity
@EnableJpaRepositories(basePackageClasses = UserRepository.class)
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
        http.csrf().ignoringAntMatchers("/mybot","/admin/**","/status_payment_p0tv");
        http.authorizeRequests()
                    .antMatchers("/",
                            "/faq",
                            "/about",
                            "/contacts",
                            "/mybot",
                            "/login",
                            "/oauth_login",
                            "/css/*",
                            "/img/**",
                            "/js/*",
                            "/scss/*",
                            "/font/roboto/*",
                            "login/oauth2/code/google",
                            "/logout",
                            "/status_payment_p0tv",
                            "/succes_payment",
                            "/fail_payment",
                            "/google96a0eb326ee3d377.html").permitAll()
                   // .anyRequest().permitAll()
                    .antMatchers("/admin/**","/homeworkfiles/**").hasRole("ADMIN")
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
