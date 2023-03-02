%Open Space Stationary

Openstill = rosbag('StationaryOS.bag');
OpenstillTopic = select(Openstill, "Topic", '/rtk_gps_message');
OpenstillStruct = readMessages(OpenstillTopic, 'DataFormat','struct');
%disp(Open_stillStruct);
OpenDataS = zeros(length(OpenstillStruct),3);
for s = 1:length(OpenstillStruct)
    OpenDataS(s,1) = OpenstillStruct{s}.UTMEasting;
    OpenDataS(s,2) = OpenstillStruct{s}.UTMNorthing;
    OpenDataS(s,3) = OpenstillStruct{s}.Altitude;
end 
OpenDataS(:,1) = OpenDataS(:,1)-min(OpenDataS(:,1));
OpenDataS(:,2) = OpenDataS(:,2)-min(OpenDataS(:,2));
OpenDataS(:,3) = OpenDataS(:,3)-mean(OpenDataS(:,3));
%Easting vs Northing
figure('Name',"Open Space Stationary Data, Easting vs Northing", 'NumberTitle', 'off')
scatter(OpenDataS(:,1), OpenDataS(:,2),'.')
hold on
grid on
title('Open Space Stationary, Easting vs Northing')
xlabel('UTMEasting (meters)')
ylabel('UTMNorthing (meters)')
hold off
%Altitude vs Time
figure('Name',"Open Space Stationary, Altitude vs Time", 'NumberTitle', 'off')
plot(linspace(1,length(OpenstillStruct),length(OpenstillStruct)), OpenDataS(:,3),'.')
grid on
title('Open Space Stationary, Altitude vs Time')
xlabel('Time (seconds)')
ylabel('Altitude (meters)')
hold off
%Histogram plot
figure('Name',"Histogram for Open Space Stationary", 'NumberTitle', 'off')
change_easting2_ = cellfun(@(m) double(m.UTMEasting)-OpenstillStruct{616}.UTMEasting,OpenstillStruct);
change_northing2 = cellfun(@(m) double(m.UTMNorthing)-OpenstillStruct{616}.UTMNorthing,OpenstillStruct);
overall_change2 = sqrt(change_easting2.^2 + change_northing2.^2);
RMSerror_OpenStationary = sqrt(sum(overall_change2.^2/616))
Hist_Still = histogram(overall_change2);
title('Histogram, Open Space Stationary')
xlabel('Error (m)')
ylabel('Frequency')

%Open Space Moving Data
Openmove = rosbag('MovingOS.bag');
OpenmovTopic = select(Openmove, "Topic", '/rtk_gps_message');
OpenmovStruct = readMessages(OpenmovTopic, 'DataFormat','struct');
%disp(Open_moveStruct);
OpenmyDataM = zeros(length(OpenmovStruct),2);
for m = 1:length(OpenmovStruct)
    OpenmyDataM(m,1) = OpenmovStruct{m}.UTMEasting;
    OpenmyDataM(m,2) = OpenmovStruct{m}.UTMNorthing;
    OpenmyDataM(m,3) = OpenmovStruct{m}.Altitude;
end 
OpenmyDataM(:,1) = OpenmyDataM(:,1)-min(OpenmyDataM(:,1));
OpenmyDataM(:,2) = OpenmyDataM(:,2)-min(OpenmyDataM(:,2));
OpenmyDataM(:,3) = OpenmyDataM(:,3)-mean(OpenmyDataM(:,3));
%polyfit
L2_1_1 = polyfit(OpenmyDataM(1:20,1), OpenmyDataM(1:20,2),1);
L2_2_2 = polyfit(OpenmyDataM(20:64,1), OpenmyDataM(20:64,2),1);
L2_3_3 = polyfit(OpenmyDataM(64:80,1), OpenmyDataM(64:80,2),1);
L2_4_4 = polyfit(OpenmyDataM(81:128,1), OpenmyDataM(81:128,2),1);
%polyval 
H2_1_1 = polyval(L2_1_1,OpenmyDataM(1:20,1));
H2_2_2 = polyval(L2_2_2,OpenmyDataM(20:64,1));
H2_3_3 = polyval(L2_3_3,OpenmyDataM(64:80,1));
H2_4_4 = polyval(L2_4_4,OpenmyDataM(81:128,1));
%error calculation
error_northing_2_1 = OpenmyDataM(1:20,2)-H2_1_1;
squared_error_2_1 = error_northing_2_1.^2;
%
error_northing_2_2 = OpenmyDataM(20:64,2)-H2_2_2;
squared_error_2_2 = error_northing_2_2.^2;
%
error_northing_2_3 = OpenmyDataM(64:80,2)-H2_3_3;
squared_error_2_3 = error_northing_2_3.^2;
%
error_northing_2_4 = OpenmyDataM(81:128,2)-H2_4_4;
squared_error_2_4 = error_northing_2_4.^2;
%
overall_sum_2_1 = sum(squared_error_2_1, 'all');
overall_sum_2_2 = sum(squared_error_2_2, 'all');
overall_sum_2_3 = sum(squared_error_2_3, 'all');
overall_sum_2_4 = sum(squared_error_2_4, 'all');
overall_sum_2_Final = (overall_sum_2_1 + overall_sum_2_2 + overall_sum_2_3 + overall_sum_2_4)/(128);
%final RMS value calculation
RMS_OpenMoving = sqrt(overall_sum_2_Final)
%easting vs northing
figure('Name',"Open Moving Data, Easting vs Northing", 'NumberTitle', 'off')
scatter(OpenmyDataM(:,1),OpenmyDataM(:,2),'.')
hold on
plot(OpenmyDataM(1:20,1),H2_1_1,'-')
plot(OpenmyDataM(20:64,1),H2_2_2,'-')
plot(OpenmyDataM(64:80,1),H2_3_3,'-')
plot(OpenmyDataM(81:128,1),H2_4_4,'-')
grid on
title('Open Walking data, Easting vs Northing')
xlabel('UTMEasting (meters)')
ylabel('UTMNorthing (meters)')
hold off
%altitude vs time
figure('Name',"Open Moving Altitude", 'NumberTitle', 'off')
plot(linspace(1,length(OpenmovStruct),length(OpenmovStruct)), OpenmyDataM(:,3),'.')
grid on
title('Open Walking data, Altitude vs Time')
xlabel('Time (seconds)')
ylabel('Altitude (meters)')

%Occluded space Stationary
Occluded_still = rosbag('StationaryOCC.bag');
Occluded_stillTopic = select(Occluded_still, "Topic", '/rtk_gps_message');
Occluded_stillStruct = readMessages(Occluded_stillTopic, 'DataFormat','struct');
%disp(Occluded_stillStruct);
Occluded_my_DataS = zeros(length(Occluded_stillStruct),3);
for s2 = 1:length(Occluded_stillStruct)
    Occluded_my_DataS(s2,1) = Occluded_stillStruct{s2}.UTMEasting;
    Occluded_my_DataS(s2,2) = Occluded_stillStruct{s2}.UTMNorthing;
    Occluded_my_DataS(s2,3) = Occluded_stillStruct{s2}.Altitude;
end 
Occluded_my_DataS(:,1) = Occluded_my_DataS(:,1)-min(Occluded_my_DataS(:,1));
Occluded_my_DataS(:,2) = Occluded_my_DataS(:,2)-min(Occluded_my_DataS(:,2));
Occluded_my_DataS(:,3) = Occluded_my_DataS(:,3)-mean(Occluded_my_DataS(:,3));
%easting vs northing
figure('Name',"Occluded Space Stationary Data, Easting vs Northing", 'NumberTitle', 'off')
scatter(Occluded_my_DataS(:,1), Occluded_my_DataS(:,2), '.')
hold on
grid on
title('Occluded Space Stationary, Easting vs Northing')
xlabel('UTMEasting (meters)')
ylabel('UTMNorthing (meters)')
hold off
%altitude vs time
figure('Name',"Occluded Space Stationary, Altitude vs Time", 'NumberTitle', 'off')
plot(linspace(1,length(Occluded_stillStruct),length(Occluded_stillStruct)), Occluded_my_DataS(:,3),'.')
grid on
title('Occluded Space Stationary, Altitude vs Time')
xlabel('Time (seconds)')
ylabel('Altitude (meters)')
%histogram plot
figure('Name',"Histogram for Occluded Space Stationary", 'NumberTitle', 'off')
change_easting1 = cellfun(@(m) double(m.UTMEasting)-Open_stillStruct{614}.UTMEasting,Open_stillStruct);
change_northing1 = cellfun(@(m) double(m.UTMNorthing)-Open_stillStruct{614}.UTMNorthing,Open_stillStruct);
overall_change1 = sqrt(change_easting1.^2 + change_northing1.^2);
RMSerror_OccludedStationary1 = sqrt(sum(overall_change1.^2/614))
Hist_Still_1 = histogram(overall_change1);
title('Histogram, Occluded Space Stationary')
xlabel('Error (m)')
ylabel('Frequency')

%Occluded Space Moving Data
Occ_move = rosbag('MovingOCC.bag');
Occ_moveTopic = select(Occ_move, "Topic", '/rtk_gps_message');
Occ_moveStruct = readMessages(Occ_moveTopic, 'DataFormat','struct');
%disp(Open_moveStruct);
Occ_my_DataM = zeros(length(Occ_moveStruct),2);
for m = 1:length(Occ_moveStruct)
    Occ_my_DataM(m,1) = Occ_moveStruct{m}.UTMEasting;
    Occ_my_DataM(m,2) = Occ_moveStruct{m}.UTMNorthing;
    Occ_my_DataM(m,3) = Occ_moveStruct{m}.Altitude;
end 
Occ_my_DataM(:,1) = Occ_my_DataM(:,1)-min(Occ_my_DataM(:,1));
Occ_my_DataM(:,2) = Occ_my_DataM(:,2)-min(Occ_my_DataM(:,2));
Occ_my_DataM(:,3) = Occ_my_DataM(:,3)-mean(Occ_my_DataM(:,3));
%polyfit
L_2_1 = polyfit(Occ_my_DataM(1:20,1), Occ_my_DataM(1:20,2),1);
L_2_2 = polyfit(Occ_my_DataM(15:40,1), Occ_my_DataM(15:40,2),1);
L_2_3 = polyfit(Occ_my_DataM(50:60,1), Occ_my_DataM(50:60,2),1);
L_2_4 = polyfit(Occ_my_DataM(70:90,1), Occ_my_DataM(70:90,2),1);
%polyval 
H_2_1 = polyval(L_2_1,Occ_my_DataM(1:20,1));
H_2_2 = polyval(L_2_2,Occ_my_DataM(15:40,1));
H_2_3 = polyval(L_2_3,Occ_my_DataM(50:60,1));
H_2_4 = polyval(L_2_4,Occ_my_DataM(70:90,1));
%error calculation
error_northing2_1_1 = Occ_my_DataM(1:20,2)-H_2_1;
squared_error2_1_1 = error_northing2_1_1.^2;
%
error_northing2_2_2 = Occ_my_DataM(15:40,2)-H_2_2;
squared_error2_2_2 = error_northing2_2_2.^2;
%
error_northing2_3_3 = Occ_my_DataM(50:60,2)-H_2_3;
squared_error2_3_3 = error_northing2_3_3.^2;
%
error_northing2_4_4 = Occ_my_DataM(70:90,2)-H_2_4;
squared_error2_4_4 = error_northing2_4_4.^2;
%
overall_sum2_1_1 = sum(squared_error2_1_1, 'all');
overall_sum2_2_2 = sum(squared_error2_2_2, 'all');
overall_sum2_3_3= sum(squared_error2_3_3, 'all');
overall_sum2_4_4= sum(squared_error2_4_4, 'all');
overall_sum2_Final_1 = (overall_sum2_1_1 + overall_sum2_2_2 + overall_sum2_3_3 + overall_sum2_4_4)/(128);
%final RMS value calculation
RMS_occMoving = sqrt(overall_sum2_Final_1)
%easting vs northing
figure('Name',"Occluded Moving Data, Easting vs Northing", 'NumberTitle', 'off')
scatter(Occ_my_DataM(:,1),Occ_my_DataM(:,2),'.')
hold on
plot(Occ_my_DataM(1:20,1),H_2_1,'-')
plot(Occ_my_DataM(15:40,1),H_2_2,'-')
plot(Occ_my_DataM(50:60,1),H_2_3,'-')
plot(Occ_my_DataM(70:90,1),H_2_4,'-')
grid on
title('Occluded Walking data, Easting vs Northing')
xlabel('UTMEasting (meters)')
ylabel('UTMNorthing (meters)')
hold off
%altitude vs time
figure('Name',"Occluded Moving Altitude", 'NumberTitle', 'off')
plot(linspace(1,length(Occ_moveStruct),length(Occ_moveStruct)), Occ_my_DataM(:,3),'.')
grid on
title('Occluded Walking data, Altitude vs Time')
xlabel('Time (seconds)')
ylabel('Altitude (meters)')