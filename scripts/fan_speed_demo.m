
function fan_speed_demo()
	% fuzzy controller creation
	fis = newfis('CPU Fan Speed');

	fis = addvar(fis, 'input', 'core temperature', [0 100]);
	fis = addmf(fis, 'input', 1, 'cold', 'trimf', [0 0 50]);
	fis = addmf(fis, 'input', 1, 'warm', 'trimf', [30 50 70]);
	fis = addmf(fis, 'input', 1, 'hot', 'trimf', [50 100 100]);

	fis = addvar(fis, 'input', 'clock speed', [0 4]);
	fis = addmf(fis, 'input', 2, 'low', 'trimf', [0 0 1.5]);
	fis = addmf(fis, 'input', 2, 'warm', 'trimf', [0.5 2 3.5]);
	fis = addmf(fis, 'input', 2, 'hot', 'trimf', [2.5 4 4]);

	fis = addvar(fis, 'output', 'fan speed', [0 6000]);
	fis = addmf(fis, 'output', 1, 'slow', 'trimf', [0 0 3500]);
	fis = addmf(fis, 'output', 1, 'fast', 'trimf', [2500 6000 6000]);

	rules = [1 1 1 1 1;
			 1 2 1 1 1;
			 1 3 2 1 1;
			 2 1 1 1 1;
			 2 2 1 1 1;
			 2 3 2 1 1;
			 3 1 2 1 1;
			 3 2 2 1 1;
			 3 3 2 1 1];

	fis = addrule(fis, rules);

	fig_handle = figure;
	set(fig_handle, 'Position', [50 50 1300 600])
	subplot(2, 2, 1)
	plotfis(fis)

	subplot(2, 2, 2)
	plotmf(fis, 'input', 1)

	subplot(2, 2, 3)
	plotmf(fis, 'output', 1)

	subplot(2, 2, 4)
	plotmf(fis, 'input', 2)

	% test values
	core_temps = [80; 75; 25; 90];
	clocks = [3.5; 1.5; 1.2; 3.8];
	fan_speeds = zeros(4, 1);

	for i = 1:4
		fan_speeds(i, :) = evalfis([core_temps(i, :), clocks(i, :)], fis);
	end
	table_ = table(core_temps, clocks, fan_speeds)
end
