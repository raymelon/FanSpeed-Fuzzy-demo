
function fan_speed_demo()
	% fuzzy controller creation
	fis = newfis('CPU Fan Speed');

	fis = addvar(fis, 'input', 'core temperature', [0 100]);
	fis = addmf(fis, 'input', 1, 'cold', 'trimf', [0 0 50]);
	fis = addmf(fis, 'input', 1, 'warm', 'trimf', [30 50 70]);
	fis = addmf(fis, 'input', 1, 'hot', 'trimf', [50 50 100]);

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

	% test values
	test(80, 3.5, fis);
	test(75, 1.5, fis);
	test(25, 1.2, fis);
	test(90, 3.8, fis);

	% evalfis([80 3.5], fis)
	% evalfis([75 1.5], fis)
	% evalfis([25 1.2], fis)
	% evalfis([90 3.8], fis)

end

function test(temp, clock_, fis)

	fprintf(['core temp (deg C):\t%f', ...
			'\nclock (GHz):\t\t%f', ... 
			'\nfan speed (rpm):\t%f\n\n'], ...
			temp, ...
			clock_, ...
			evalfis([temp, clock_], fis) ...
			)
end
