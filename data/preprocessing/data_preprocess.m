% Data preprocessing

load sp500.mat
warning off
DataBist = readtable("BIST100Data.csv");
tr10bond = readtable("tr10by.csv");
usdtry = readtable("usdtry.csv");
pmi = readtable("turkeypmi.xlsx");
cds10 = readtable("Turkey CDS 10 Year.csv");
tr2bond = readtable("Turkey 2 Year Bond Yield Historical Data.csv");
cds2 = readtable("Turkey CDS 2 Year.csv");
eem = readtable("EEM ETF.csv");
vix = readtable("VIX Price.csv");
m2 = readtable("turkey_M2.xlsx");
fed_rate = readtable("fed_rate.xlsx");
brent = readtable("Brent Oil.csv");
dax = readtable("DAX Price.csv");
nikkei = readtable("Nikkei225 Price.csv");
gdp = readtable("turkey_gdp_growth.xlsx");
inflation = readtable("turkey_inflation_year.xlsx");
interest = readtable("turkey_policy_rate_.xlsx");
unemp = readtable("turkey_unemployment.xlsx");
xauusd = readtable("XAU to USD Price.csv");
dollar = readtable("US Dollar Index.csv");

IndexBIST = flip(DataBist.Close);
IndexOpen = flip(DataBist.Open);
IndexHigh = flip(DataBist.High);
IndexLow = flip(DataBist.Low);
IndexDate = flip(DataBist.Date);
IndexVol = flip(DataBist.Volume);

% calculating exponential moving average (ema)
function [ema_arr] = ema(index,n)
    alpha = 2/(n+1);
    ema_arr = zeros(length(index),1);
    ema_arr(n) = mean(index(1:n));

    for i=(n+1):1:length(index)
        ema_arr(i) = index(i)*alpha + ema_arr(i-1)*(1-alpha);
    end
end

% calculating average true range (atr)
function at_range = atr(high,low,close,period)
        
    tr_range = zeros(length(close));
    tr_range(1) = high(1)-low(1);

    for i = 2:length(close)
        t_range_hl = high(i)-low(i);
        t_range_h_pc = abs(high(i)-close(i-1));
        t_range_l_pc = abs(low(i)-close(i-1));
        tr_range(i) = max([t_range_hl,t_range_h_pc,t_range_l_pc]);
    end
    at_range = ema(tr_range,period);
end

rsi = rsindex(IndexBIST);
[bol_mid, bol_up, bol_low] = bollinger(IndexBIST);
[macd_l,macdsig] = macd(IndexBIST);

ema_20 = ema(IndexBIST,20);
ema_50 = ema(IndexBIST,50);
ema_200 = ema(IndexBIST,200);

atr14 = atr(IndexHigh,IndexLow,IndexBIST,14);

can = [IndexOpen(200:end,:),IndexHigh(200:end,:),IndexLow(200:end,:),IndexBIST(200:end,:)];

figure;
tile = tiledlayout(7,1,"TileSpacing","compact","Padding","compact");
nexttile(tile,[4 1]);
candle(can,"k");
hold on
p1 = plot(ema_20(200:end),"r");
p2 = plot(ema_50(200:end),"b");
p3 = plot(ema_200(200:end),"g");
p5 = plot([bol_mid(200:end), bol_up(200:end), bol_low(200:end)]);
title("BIST 100 Index with Daily EMA = 20,50,200 ");
legend([p1,p2,p3],{"20 Day EMA", "50 Day EMA","200 Day EMA"});
nexttile(tile,[1 1]);
p4 = plot(rsi(200:end));
title("RSI (14)");

nexttile(tile,[1 1]);
plot([macd_l(200:end),macdsig(200:end)]);
title("MACD");

nexttile(tile,[1 1]);
plot(atr14(200:end));
title("ATR (14)");

hold off

start_date = IndexDate(200);
Data_f = flip(DataBist);
Data_clip = Data_f(200:end,:);
IndexDate = IndexDate(200:end);
IndexDate = datetime(IndexDate,"InputFormat","dd.MM.yyyy");
IndexDay = weekday(IndexDate);
IndexWeek = week(IndexDate);
IndexMonth = month(IndexDate);
IndexQuarter = quarter(IndexDate);
IndexYear = year(IndexDate);


tr10bond_f = flip(tr10bond);
usdtry_f = flip(usdtry);
pmi_f = flip(pmi);
sp500_f = flip(sp500);
cds10_f = flip(cds10);
tr2bond_f = flip(tr2bond);
cds2_f = flip(cds2);
eem_f = flip(eem);
vix_f = flip(vix);
m2_f = flip(m2);
fed_rate_f = flip(fed_rate);
brent_f = flip(brent);
dax_f = flip(dax);
nikkei_f = flip(nikkei);
gdp_f = flip(gdp);
inflation_f = flip(inflation);
interest_f = flip(interest);
unemp_f = flip(unemp);
xauusd_f = flip(xauusd);
dollar_f = flip(dollar);

Data_j = outerjoin(Data_clip,tr10bond_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,usdtry_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,pmi_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,sp500_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,cds10_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,tr2bond_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,cds2_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,eem_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,vix_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,m2_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,fed_rate_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,brent_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,dax_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,nikkei_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,gdp_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,inflation_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,interest_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,unemp_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,xauusd_f(:,1:2),"Keys","Date",MergeKeys=true);
Data_j = outerjoin(Data_j,dollar_f(:,1:2),"Keys","Date",MergeKeys=true);

Data_j.Properties.VariableNames(8) = "TR10BY";
Data_j.Properties.VariableNames(9) = "USDTRY";
Data_j.Properties.VariableNames(10) = "PMI";
Data_j.Properties.VariableNames(11) = "SP500";
Data_j.Properties.VariableNames(12) = "CDS10";
Data_j.Properties.VariableNames(13) = "TR2BY";
Data_j.Properties.VariableNames(14) = "CDS2";
Data_j.Properties.VariableNames(15) = "EEM";
Data_j.Properties.VariableNames(16) = "VIX";
Data_j.Properties.VariableNames(17) = "M2";
Data_j.Properties.VariableNames(18) = "FEDRATE";
Data_j.Properties.VariableNames(19) = "BRENT";
Data_j.Properties.VariableNames(20) = "DAX";
Data_j.Properties.VariableNames(21) = "NIKKEI";
Data_j.Properties.VariableNames(22) = "GDPGROWTHYOY";
Data_j.Properties.VariableNames(23) = "INFLATION";
Data_j.Properties.VariableNames(24) = "INTEREST";
Data_j.Properties.VariableNames(25) = "UNEMPLOYMENT";
Data_j.Properties.VariableNames(26) = "XAUUSD";
Data_j.Properties.VariableNames(27) = "DOLLARIDX";

Data_j = Data_j(~isnan(Data_j{:,"Close"}),:);

tr10bond_p = fillmissing(Data_j.TR10BY,"previous");
usdtry_p = fillmissing(Data_j.USDTRY,"previous");
pmi_p = fillmissing(Data_j.PMI,"previous");
sp500_p = fillmissing(Data_j.SP500,"previous");
cds10_p = fillmissing(Data_j.CDS10,"previous");
tr2bond_p = fillmissing(Data_j.TR2BY,"previous");
cds2_p = fillmissing(Data_j.CDS2,"previous");
eem_p = fillmissing(Data_j.EEM,"previous");
vix_p = fillmissing(Data_j.VIX,"previous");
m2_p = fillmissing(Data_j.M2,"previous");
fed_rate_p = fillmissing(Data_j.FEDRATE,"previous");
brent_p = fillmissing(Data_j.BRENT,"previous");
dax_p = str2double(erase(cellstr(fillmissing(Data_j.DAX,"previous")),","));
nikkei_p = str2double(erase(cellstr(fillmissing(Data_j.NIKKEI,"previous")),","));
gdp_p = fillmissing(Data_j.GDPGROWTHYOY,"previous");
inflation_p = fillmissing(Data_j.INFLATION,"previous");
interest_p = fillmissing(Data_j.INTEREST,"previous");
unemp_p = fillmissing(Data_j.UNEMPLOYMENT,"previous");
xauusd_p = str2double(erase(cellstr(fillmissing(Data_j.XAUUSD,"previous")),","));
dollar_p = fillmissing(Data_j.DOLLARIDX,"previous");

IndexVol(1119) = 0.7972; % do not delete

% Cyclical date for day, week, month and quarter
function [ysin, ycos] = cyclical(x)
    ysin = sin(2*pi.*x/max(x));
    ycos = cos(2*pi.*x/max(x));
end

[IndexDay_sin, IndexDay_cos] = cyclical(IndexDay); 
[IndexWeek_sin, IndexWeek_cos] = cyclical(IndexWeek);
[IndexMonth_sin, IndexMonth_cos] = cyclical(IndexMonth);
[IndexQuarter_sin, IndexQuarter_cos] = cyclical(IndexQuarter);

% Binary feature to mark the days in which macroeconomic feautures released
function y = updated_mark(x)

    y = zeros(length(x),1);

    for i = 2:length(x)
        y(i) = (x(i) ~= x(i-1));
    end

end

pmi_upt = updated_mark(pmi_p);
m2_upt = updated_mark(m2_p);
inf_upt = updated_mark(inflation_p);
int_upt = updated_mark(interest_p);
unemp_upt = updated_mark(unemp_p);
gdp_upt = updated_mark(gdp_p);
fed_rate_upt = updated_mark(fed_rate_p);

% Feature that counts how many days past since the last release or update
function y = daysince(x)
  y = zeros(length(x),1);
    for k = 2:length(x)
      if x(k) == 1
          y(k) = 0;
      else
          y(k) = y(k-1)+1;
      end
    end
end

pmi_ds = daysince(pmi_upt);
m2_ds = daysince(m2_upt);
inf_ds = daysince(inf_upt);
int_ds = daysince(int_upt);
unemp_ds = daysince(unemp_upt);
gdp_ds = daysince(gdp_upt);
fedrate_ds = daysince(fed_rate_upt);

dif = zeros(length(IndexBIST(200:end)),1);
dif(2:end) = diff(log(IndexBIST(200:end)));

close = IndexBIST(200:end);
close_lag1 = [zeros(1,1);close(1:end-1)];
close_lag2 = [zeros(2,1);close(1:end-2)];
close_lag3 = [zeros(3,1);close(1:end-3)];

Feature_table = table(IndexDate ,IndexDay_sin, IndexDay_cos, IndexWeek_sin, IndexWeek_cos, IndexMonth_sin, IndexMonth_cos, ...
    IndexQuarter_sin, IndexQuarter_cos, IndexYear, IndexOpen(200:end),IndexHigh(200:end),...
    IndexLow(200:end),IndexVol(200:end),ema_20(200:end), ema_50(200:end), ema_200(200:end),rsi(200:end), ...
    macd_l(200:end), macdsig(200:end), atr14(200:end), bol_mid(200:end), bol_low(200:end), bol_up(200:end),...
    tr10bond_p,tr2bond_p,cds10_p,cds2_p,usdtry_p,xauusd_p,dollar_p,brent_p,eem_p,sp500_p,dax_p, nikkei_p, vix_p,...
    pmi_p,pmi_upt, pmi_ds, m2_p, m2_upt, m2_ds, inflation_p, inf_upt, inf_ds, interest_p, int_upt,int_ds, unemp_p, unemp_upt, unemp_ds,...
    gdp_p, gdp_upt, gdp_ds, ...
    fed_rate_p, fed_rate_upt, fedrate_ds, dif,  IndexBIST(200:end), ...
    VariableNames={'date','day_sin','day_cos','week_sin','week_cos','month_sin', 'month_cos','quarter_sin','quarter_cos','year','open','high','low','volume','ema20','ema50','ema200','rsi14','macdline','macdsignal',...
    'atr14','bollingermid','bollingerlow','bollingerup','tr10by','tr2by','cds10','cds2','usdtry','xauusd',...
    'dollarindex','brentoil','emergingeem','sp500','dax','Nikkei','vix','pmi','pmi_upt','pmi_ds','m2','m2_upt', 'm2_ds',...
    'inflationyoy','inf_upt', 'inf_ds', 'interestrate', 'int_ump', 'int_ds',...
    'unemployment', 'unemp_upt','unemp_ds','gdpgrowth','gdp_upt','gdp_ds','fedrate','fed_upt','fedrate_ds','dif','close'});

writetable(Feature_table, 'Xtable.csv');

