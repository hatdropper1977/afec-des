for counter = 1:1e6
ber_model;
if(hits)
    %tally
    hit_miss(1,hits) = hit_miss(1,hits)+1;
    
    %generate
    d       = lt(rand(1,4),0.5);
    c_tx    = mod(d*G,2);
    
    %transmit
    c_rx    = c_tx;
    
    %hit
    hit_index = ceil(rand(1,hits)*7);
    for ind = 1:hits
        c_rx(hit_index(ind)) = ...
            mod(c_rx(hit_index(ind))+1,2);
    end
    
    %receive
    s1  = mod(c_rx*H',2);
    if sum(s1) ~= 0
        %repair
        s = s1*[4 2 1]';
        e_lookup = e(S==s,:);
        e_least  = 1;
        ham_least = ...
            sum(mod(c_rx+mod(c_rx+e_lookup(1,:),2),2));
        for a = 2:length(e_lookup)
            ham_test = ...
                sum(mod(c_rx+mod(c_rx+e_lookup(a,:),2),2));
            if ham_test < ham_least;
                e_least = a;
                ham_least = ham_test;
            end
        end
        
        %check
        c_rx_fix = mod(c_rx + e_lookup(e_least,:),2);
        if sum(mod(c_rx_fix+c_tx,2))
            hit_miss(2,hits) = hit_miss(2,hits) + 1;
        end
    end
end
end     
