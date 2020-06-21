clc
clear all
images = imageDatastore(fullfile(toolboxdir('vision'), 'visiondata', ...
    'NewTsukuba'));
% Create the camera parameters object using camera intrinsics from the
% New Tsukuba dataset.
K = [615 0 320; 0 615 240; 0 0 1]';
cameraParams = cameraParameters('IntrinsicMatrix', K);

% Load ground truth camera poses.
load(fullfile(toolboxdir('vision'), 'visiondata', ...
    'visualOdometryGroundTruth.mat'));
% Create an empty viewSet object to manage the data associated with each view.
vSet = viewSet;

% Read and display the first image.
Irgb = readimage(images, 1);
player = vision.VideoPlayer('Position', [20, 400, 650, 510]);
step(player, Irgb);
prevI = undistortImage(rgb2gray(Irgb), cameraParams);

% Detect features.
prevPoints = detectSURFFeatures(prevI, 'MetricThreshold', 500);

% Select a subset of features, uniformly distributed throughout the image.
numPoints = 150;
prevPoints = selectUniform(prevPoints, numPoints, size(prevI));

% Extract features. Using 'Upright' features improves matching quality if
% the camera motion involves little or no in-plane rotation.
prevFeatures = extractFeatures(prevI, prevPoints, 'Upright', true);

% Add the first view. Place the camera associated with the first view
% at the origin, oriented along the Z-axis.
viewId = 1;
vSet = addView(vSet, viewId, 'Points', prevPoints, 'Orientation', eye(3),...
    'Location', [0 0 0]);
% Setup axes.
figure
axis([-220, 50, -140, 20, -50, 300]);

% Set Y-axis to be vertical pointing down.
view(gca, 3);
set(gca, 'CameraUpVector', [0, -1, 0]);
camorbit(gca, -120, 0, 'data', [0, 1, 0]);

grid on
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
hold on

% Plot estimated camera pose.
cameraSize = 7;
camEstimated = plotCamera('Size', cameraSize, 'Location',...
    vSet.Views.Location{1}, 'Orientation', vSet.Views.Orientation{1},...
    'Color', 'g', 'Opacity', 0);

% Plot actual camera pose.
camActual = plotCamera('Size', cameraSize, 'Location', ...
    groundTruthPoses.Location{1}, 'Orientation', ...
    groundTruthPoses.Orientation{1}, 'Color', 'b', 'Opacity', 0);

% Initialize camera trajectories.
trajectoryEstimated = plot3(0, 0, 0, 'g-');
trajectoryActual    = plot3(0, 0, 0, 'b-');

legend('Estimated Trajectory', 'Actual Trajectory');
title('Camera Trajectory');
% Read and display the image.
viewId = 2;
Irgb = readimage(images, viewId);
step(player, Irgb);

% Convert to gray scale and undistort.
I = undistortImage(rgb2gray(Irgb), cameraParams);

% Match features between the previous and the current image.
[currPoints, currFeatures, indexPairs] = helperDetectAndMatchFeatures(...
    prevFeatures, I);

% Estimate the pose of the current view relative to the previous view.
[orient, loc, inlierIdx] = helperEstimateRelativePose(...
    prevPoints(indexPairs(:,1)), currPoints(indexPairs(:,2)), cameraParams);

% Exclude epipolar outliers.
indexPairs = indexPairs(inlierIdx, :);

% Add the current view to the view set.
vSet = addView(vSet, viewId, 'Points', currPoints, 'Orientation', orient, ...
    'Location', loc);
% Store the point matches between the previous and the current views.
vSet = addConnection(vSet, viewId-1, viewId, 'Matches', indexPairs);
vSet = helperNormalizeViewSet(vSet, groundTruthPoses);
helperUpdateCameraPlots(viewId, camEstimated, camActual, poses(vSet), ...
    groundTruthPoses);
helperUpdateCameraTrajectories(viewId, trajectoryEstimated, trajectoryActual,...
    poses(vSet), groundTruthPoses);

prevI = I;
prevFeatures = currFeatures;
prevPoints   = currPoints;