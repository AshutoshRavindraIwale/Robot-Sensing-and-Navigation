% Stationary data 1
bag1 = rosbag('2023-02-06-05-08-36.bag');
bagInfo1 = rosbag('info','2023-02-06-05-08-36.bag');
disp(bagInfo1)

stationary_data_topic1 = select(bag1, 'Topic', "/gps");
stationary_struct1 = readMessages(stationary_data_topic1,'DataFormat','struct');
disp(stationary_struct1);

stationary_data1 = zeros(length(stationary_struct1),3);
for H = 1:length(stationary_struct1)
    stationary_data1(H,1) = stationary_struct1{H}.UTMEasting;
    stationary_data1(H,2) = stationary_struct1{H}.UTMNorthing;
    stationary_data1(H,3) = stationary_struct1{H}.Altitude;
end
stationary_data1(:,1) = stationary_data1(:,1)-min(stationary_data1(:,1));
stationary_data1(:,2) = stationary_data1(:,2)-min(stationary_data1(:,2));
stationary_data1(:,3) = stationary_data1(:,3)-mean(stationary_data1(:,3));


%Easting(X) vs Northing(Y)
figure('Name',"Stationary Data 1(Open space) Easting vs Northing",'NumberTitle','off')
scatter(stationary_data1(:,1),stationary_data1(:,2),'.')
hold on
grid on
title('Open space, Easting VS Northing')
xlabel('UTMEasting (meters)')
ylabel('UTMNorthing (meters)')
hold off

%Altitude(X) Vs Time(Y)

figure('Name',"Stationary Data 1(Open space) Altitude vs Time",'NumberTitle','off')
plot(linspace(1,length(stationary_data1),length(stationary_data1)), stationary_data1(:,3), '.')
hold on
grid on
title('Open space, Altitude VS Time')
xlabel('Time (seconds)')
ylabel('Altitude (meters)')
hold off

%Histogram Plot 1
figure('Name',"Histogram of Open space 1",'NumberTitle','off')
changingeasting1 = cellfun(@(m) double(m.UTMEasting)-stationary_struct1{605}.UTMEasting,stationary_struct1);
changingnorthing2 = cellfun(@(m) double(m.UTMNorthing)-stationary_struct1{605}.UTMNorthing,stationary_struct1);
totalchange2 = sqrt(changingeasting1.^2 + changingnorthing2.^2);
histogram_stationary1 = histogram(totalchange2);
title('Histogram, Open space ')




%Stationary data 2 


bag2 = rosbag('2023-02-06-04-29-10.bag');
bagInfo2 = rosbag('info','2023-02-06-04-29-10.bag');
disp(bagInfo2)

stationary_data_topic2 = select(bag2, 'Topic', "/gps");
stationary_struct2 = readMessages(stationary_data_topic2,'DataFormat','struct');
disp(stationary_struct2);

stationary_data2 = zeros(length(stationary_struct2),3);
for j = 1:length(stationary_struct2)
    stationary_data2(j,1) = stationary_struct2{j}.UTMEasting;
    stationary_data2(j,2) = stationary_struct2{j}.UTMNorthing;
    stationary_data2(j,3) = stationary_struct2{j}.Altitude;
end
stationary_data2(:,1) = stationary_data2(:,1)-min(stationary_data2(:,1));
stationary_data2(:,2) = stationary_data2(:,2)-min(stationary_data2(:,2));
stationary_data2(:,3) = stationary_data2(:,3)-mean(stationary_data2(:,3));



%Easting(X) vs Northing(Y)
figure('Name',"Stationary Data 2(Occluded space) Easting vs Northing",'NumberTitle','off')
scatter(stationary_data2(:,1),stationary_data2(:,2),'.')
hold on
grid on
title('Occluded Area, Easting VS Northing')
xlabel('UTMEasting (meters)')
ylabel('UTMNorthing (meters)')
hold off

%Altitude(X) Vs Time(Y)

figure('Name',"Stationary Data 2(Occluded space) Altitude vs Time",'NumberTitle','off')
plot(linspace(1,length(stationary_data2),length(stationary_data2)), stationary_data2(:,3), '.')
hold on
grid on
title('Occluded Area, Altitude VS Time')
xlabel('Time (seconds)')
ylabel('Altitude (meters)')
hold off

%Histogram Plot 1
figure('Name',"Histogram of Occluded space 1",'NumberTitle','off')
changingeasting_1 = cellfun(@(m) double(m.UTMEasting)-stationary_struct2{306}.UTMEasting,stationary_struct2);
changingnorthing_2 = cellfun(@(m) double(m.UTMNorthing)-stationary_struct2{306}.UTMNorthing,stationary_struct2);
totalchange2 = sqrt(changingeasting_1.^2 + changingnorthing_2.^2);
histogram_stationary2 = histogram(totalchange2)
title('Histogram, Occluded space ')

%Walking_data 
bag3 = rosbag('2023-02-06-04-39-17.bag');
bagInfo3 = rosbag('info','2023-02-06-04-39-17.bag');
disp(bagInfo3)

stationary_data_topic3 = select(bag3, 'Topic', "/gps");
stationary_struct3 = readMessages(stationary_data_topic3,'DataFormat','struct');
disp(stationary_struct3);

stationary_data3 = zeros(length(stationary_struct3),2);
for l = 1:length(stationary_struct3)
    stationary_data3(l,1) = stationary_struct3{l}.UTMEasting;
    stationary_data3(l,2) = stationary_struct3{l}.UTMNorthing;
    stationary_data3(l,3) = stationary_struct3{l}.Altitude;
end
stationary_data3(:,1) = stationary_data3(:,1)-min(stationary_data3(:,1));
stationary_data3(:,2) = stationary_data3(:,2)-min(stationary_data3(:,2));
stationary_data3(:,3) = stationary_data3(:,3)-mean(stationary_data3(:,3));
Q = polyfit(stationary_data3(:,1),stationary_data3(:,2),1);
L = polyval(Q,stationary_data3(:,1));
errnorthing = stationary_data3(:,2)-L;
Squareerr = errnorthing.^2;
Totalsum = sum(Squareerr,'all');
Totalsum = Totalsum/302;
rms_value = sqrt(Totalsum)

%Easting(X) vs Northing(Y)
figure('Name',"Stationary Data 3 (Walking data) Easting vs Northing",'NumberTitle','off')
scatter(stationary_data3(:,1),stationary_data3(:,2),'.')
hold on
grid on
title('Walking Data, Easting VS Northing')
xlabel('UTMEasting (meters)')
ylabel('UTMNorthing (meters)')
hold off

%Altitude(X) Vs Time(Y)

figure('Name',"Stationary Data 3 (Walking data) Altitude vs Time",'NumberTitle','off')
plot(linspace(1,length(stationary_data3),length(stationary_data3)), stationary_data3(:,3), '.')
hold on
grid on
title('Walking data, Altitude VS Time')
xlabel('Time (seconds)')
ylabel('Altitude (meters)')
hold off

%Histogram Plot 1
figure('Name',"Histogram of Walking data",'NumberTitle','off')
changingeasting11 = cellfun(@(m) double(m.UTMEasting)-stationary_struct3{303}.UTMEasting,stationary_struct3);
changingnorthing22 = cellfun(@(m) double(m.UTMNorthing)-stationary_struct3{303}.UTMNorthing,stationary_struct3);
totalchange22 = sqrt(changingeasting11.^2 + changingnorthing22.^2);
histogram_stationary11 = histogram(totalchange22);
title('Histogram, Walking data ')
