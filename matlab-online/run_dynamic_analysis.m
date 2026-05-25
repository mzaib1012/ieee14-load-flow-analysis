% Automated Control Script for IEEE 14-Bus Dynamic Analysis
model_name = 'ieee14_dynamic_sim';

fprintf('Loading Simscape Model Topology...\n');
load_system(model_name);

fprintf('Initializing Dynamic Transient Fault Run (3000ms window)...\n');
simOut = sim(model_name, 'StopTime', '3.0');

% Extract simulated voltage vectors from the Scope data logs
time = simOut.tout;
% Note: The exact naming depends on your signal logging properties
try
    v_bus2 = simOut.logsout.get('bus2_voltage').Values.Data;
    
    % Generate Professional Plot Asset for GitHub Documentation
    figure('Position', [100, 100, 800, 500]);
    plot(time, v_bus2, 'LineWidth', 2, 'Color', '#D95319');
    grid on;
    title('Dynamic Voltage Recovery Tracking Profile at Bus 2 During Short-Circuit Fault');
    xlabel('Time (Seconds)');
    ylabel('Voltage Magnitude (per-unit)');
    saveas(gcf, 'dynamic_voltage_recovery.png');
    fprintf('Success: Plot asset saved to workspace.\n');
catch
    fprintf('Simulation complete. Set up your scope logging to export visual graphics.\n');
end
