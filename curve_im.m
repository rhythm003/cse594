function out = curve_im(im, Tmin, Tmax, perc)
out = double(im);
map = zeros(Tmax - Tmin + 1, 1);
sum = 0;
count = 0;
for i = 1:size(out, 1)*size(out, 2)
    if out(i) >= Tmin && out(i) <= Tmax
        sum = sum + out(i);
        count = count + 1;
    end
end
m = floor(sum / count);
Tmin = double(Tmin);
Tmax = double(Tmax);
m = double(m);
A = [Tmin^2, Tmin, 1; m^2, m, 1; Tmax^2, Tmax, 1];
Y = [Tmin, m + (Tmax - m)*perc, Tmax]';
X = A \ Y;
for i = Tmin:Tmax
    map(i - Tmin + 1) = floor(X(1)*i^2 +X(2)*i + X(3));
end

for i = 1:size(out, 1)*size(out, 2)
    if out(i) >= Tmin && out(i) <= Tmax
        out(i) = map(out(i)-Tmin + 1);
    end
end
out = uint8(out);