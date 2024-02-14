use <parametric-flake.scad>

params = [
    [ "gap", 0.1 ],
    [ "height", 1 ],
    [ "scale", 10 ],
    [ "thickness", 0.5 ],
    [ "colors", ["#5277C3", "#7EBAE4"]],
];

flake(params);
