%Calcolo le costanti C0,C1,C2,C3,C4,C5,C6,C7
C0 = 1 / (alfa * dt ^ 2);
C1 = delta / (alfa * dt);
C2 = 1 / (alfa * dt);
C3 = 1 / (2 * alfa) - 1;
C4 = delta / alfa - 1;
C5 = dt / 2 * (delta / alfa - 2);
C6 = dt * (1 - delta);
C7 = delta * dt;