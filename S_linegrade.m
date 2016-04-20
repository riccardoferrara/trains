function [ S ] = S_linegrade( w, k, Av, Wc )
%power spectral density of the railway trach for line grades of one to six
%(line grade one is the worst line and six is the best line) from America
%Railway Standard


S = (0.25*Av*Wc^2)/((w^2+Wc^2)*w^2);