function state_estimation 


% Arbitrarily assigned values for toy example
eta = 100;
phi = 10; 

% Values chosen for the coefficients of the dynamical system ( These can be
% time varying in the future)
A = 10;
B = 5;

d = 6; % number of days in the Horizon


% u = [ 0 0 1 0 0 1 ]; % Used for just state estimation
u=[]; % Empty array of actions to be determined 
y = [ 1 1 1 1 1 1 ];
delta_w_resolution = 10000;
gamma_crit = 0.9999; % Critical gamma value assigned at random 
alpha0_mu = 1.5;
beta = 0.1;
alpha0 = gaminv((1:delta_w_resolution)/(delta_w_resolution+1), alpha0_mu,1);
alpha_prev = alpha0;
w = [1:length(alpha0)]./ length(alpha0);


%%%% Particle Filter %%%%
for t = 1:d
    
    if t==1 
        gamma0_mu = alpha0_mu/(alpha0_mu + beta);
        arg_probit = gamma_crit - gamma0_mu ; 
        uu = normcdf(arg_probit,0,1);
        uu = binornd(1,uu);
    else
        alphaprev_mu = mean(alpha_prev);
        arg_probit = gamma_crit - (alphaprev_mu /(alphaprev_mu+beta));
        uu = normcdf(arg_probit,0,1);
        uu = binornd(1,uu);
        if uu ==0
            uu = 1- u(t-1);
        else
            uu= u(t-1);
        end
    end
    
    u = [u,uu];
    alpha_new_bar= zeros(1,length(alpha_prev));
    for i = 1:length(alpha_prev)
        alpha_new_bar(i) = gamrnd(A*alpha_prev(i) + B*u(t), 1);
        
        if y(t) == 1
            w(i) = 1 - betacdf( gamma_crit, alpha_new_bar(i), beta);
        else
            w(i) = betacdf( gamma_crit, alpha_new_bar(i), beta);
        end
        
    end
    alpha_new = [];
    w = w ./sum(w);
    draw_rep = mnrnd(length(w), w);
    for m = 1: length(alpha_prev) 
        if draw_rep(m) > 0
            alpha_new = [alpha_new,...
                ones(1,draw_rep(m)).*alpha_new_bar(m)];
        end
    end
    
    alpha_new = sort(alpha_new);
    
    hist(alpha_new, 1000);
    drawnow
    keyboard
    clf
    
    alpha_prev = alpha_new;
end  
