# FanSpeed-Fuzzy-demo
Demo of a Fuzzy Logic-based CPU Fan Speed Controller

| [MATLAB](https://www.mathworks.com/videos/whats-new-in-matlab-in-r2015b-and-r2016a-120995.html) | ![](https://cdn.rawgit.com/raymelon/EmergencyResponseUnitLocator/b62eda41/misc/MALTAB-R2015b-orange.svg) |
|-|-|

The aim is to control the CPU Fan Speed based on the system's current core temperature (in degrees Celsius) and current clock speed (in GHz). 

![](https://github.com/raymelon/FanSpeed-Fuzzy-demo/blob/master/fis/funcdiagram.JPG)

The ranges used are calibrated based on the current computer models, thus these ranges are subject to change as time pass by. The ranges are as follows:

| Fuzzy Variables | Units | Ranges (based on 2016 computer models) |
|-|-|-|
| Core temperature | degrees Celsius (°C) | 0 to 100 |
| Clock speed frequency | Gigahertz (GHz) | 0 to 4 |
| Fan speed | Revolutions per minute (RPM) | 0 to 6000 |

## Fuzzy Membership Functions

#### Core Temperature
![](https://github.com/raymelon/FanSpeed-Fuzzy-demo/blob/master/fis/coretemp.JPG)

#### Clock Speed
![](https://github.com/raymelon/FanSpeed-Fuzzy-demo/blob/master/fis/clockspeed.JPG)

#### Fan Speed
![](https://github.com/raymelon/FanSpeed-Fuzzy-demo/blob/master/fis/fanspeed.JPG)


## Fuzzy Rules

| Core Temperature | | Clock Speed | | Fan Speed |
|-|-|-|-|-|
| cold | AND | low | THEN | slow |
| cold | AND | normal | THEN | slow |
| cold | AND | turbo | THEN | fast |
| warm | AND | low | THEN | slow |
| warm | AND | normal | THEN | slow |
| warm | AND | turbo | THEN | fast |
| hot | AND | low | THEN | fast |
| hot | AND | normal | THEN | fast |
| hot | AND | turbo | THEN | fast |

## Simulation
```
>> fan_speed_demo

table_ = 

    core_temps    clocks    fan_speeds
    __________    ______    __________

    80            3.5       4715.8    
    75            1.5       4654.3    
    25            1.2       1367.8    
    90            3.8       4811.5    

>> 
```

