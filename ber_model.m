hits = 0;
hit_rand = rand;
for a = 1:length(BER)
    if hit_rand < BER(a)
        hits = hits + 1;
    end
end
