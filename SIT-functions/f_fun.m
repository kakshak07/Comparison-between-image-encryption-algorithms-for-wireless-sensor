function a = funM(a)
a=[P_fun(a(1:4)),Q_fun(a(5:8)),P_fun(a(9:12)),Q_fun(a(13:16))];
a=[Q_fun([a(1:2),a(5:6)]),P_fun([a(3:4),a(7:8)]),Q_fun([a(9:10),a(13:14)]),P_fun([a(11:12),a(15:16)])];
a=[P_fun([a(1:2),a(5:6)]),Q_fun([a(3:4),a(7:8)]),P_fun([a(9:10),a(13:14)]),Q_fun([a(11:12),a(15:16)])];
end