function E = keplerEq(avg_anomaly,eccentricity,eps)
En  = avg_anomaly;
Ens = En - (En-eccentricity*sin(En)- avg_anomaly)/...
    (1 - eccentricity*cos(En));
while ( abs(Ens-En) > eps )
    En = Ens;
    Ens = En - (En - eccentricity*sin(En) - avg_anomaly)/...
        (1 - eccentricity*cos(En));
end
E = Ens;
end