import("stdfaust.lib");

fuzziiDepth = hslider("fuzziiDepth", 0.75, 0.75, 30, 0.01) : si.smoo;
fuzziiParam = hslider("fuzziiParam", 0.4, 0.03, 0.7, 0.01) : si.smoo;
fuzziitone = vslider("fuzziiTone",-7.5,-15,0,0.1);


filter = fi.high_shelf(fuzziitone + 12.5, 720.0);
  pre_filter = fi.dcblocker : fi.lowpass(1, 2000.0);


divide(input) = (((((input: pre_filter : filter )*fuzziiDepth-1)/((input: pre_filter : filter )+(0.5/fuzziiDepth + fuzziiParam) : max(0.0001)) : ef.cubicnl(0,1)))/2 + (0 : ef.cubicnl(2,-1))*0.1) ;


fuzzii = (divide+0.15)/(3+0.25*fuzziiDepth);

process= _: fuzzii : _;
