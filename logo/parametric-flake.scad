unit = [1, 0];
origin = [0, 0];


/*
    Returns a 2D rotation matrix given an angle.
*/
function rot2d(angle) = [
    [+cos(angle), -sin(angle)],
    [+sin(angle), +cos(angle)]
];


/*
    Calculates the points for a hexagon.
    Used to reference off of for creating the lambda.
    Points are created starting from the right and moving counter-clockwise.

         2   1

      3         0

         4   5
*/
function inner_hex_points(data) = [
    for (angle = [0 : 60 : 300]) 
    dict_get(data, "scale") * rot2d(angle) * unit
];



/*
    Calculates the points for making a lambda.

    Returns two a list of two lists.
    The first list contains the offset for making a flake.
    The second list is used to form the lambda polygon.
*/
function lambda_points(data) =
let (
    hex_points = inner_hex_points(data),
    thickness = dict_get(data, "thickness") / 2,
    top_left = hex_points[2],
    bottom_left = hex_points[4],
    bottom_right = hex_points[5],
    v_0 = thickness * unit,
    v_p60 = thickness * rot2d(60) * unit,
    v_n60 = thickness * rot2d(-60) * unit,
    v_n90 = thickness * rot2d(-90) * unit,
    gap = dict_get(data, "gap") * rot2d(-60) * unit
)
[
    [
        top_left + v_p60,
    ],
    [
        top_left - v_p60 + gap,
        top_left + v_p60 + gap,
        bottom_right + v_0,
        bottom_right - v_0,
        sqrt(3) * v_n90,
        bottom_left + v_0,
        bottom_left,
        bottom_left - v_n60,
        -v_0
    ]
];


/*
    Generates a single lambda at the origin.
*/
module lambda(data) {
    new_data = update_params(data);
    linear_extrude(dict_get(new_data, "height"))
    polygon(lambda_points(new_data)[1]);
}


/*
    Generates a NixOS flake.
*/
module flake(data) {
    new_data = update_params(data);
    colors = dict_get(data, "colors");
    echo(colors);
    for (idx = [0 : 5]) {
        color(colors[idx % len(colors)])
        rotate([0, 0, idx * 60]) 
        translate(-lambda_points(new_data)[0][0])
        translate([-dict_get(new_data, "scale"), 0, 0])
        linear_extrude(dict_get(new_data, "height"))
        polygon(lambda_points(new_data)[1]);
    }
}


/*
    Returns the value from a associative array/dictionary type structure given some key.

    Values can be of any type.
    The dictionary must of be of the form:
    [
        [ "key0", <value0> ],
        [ "key1", <value1> ],
        ...
    ]
*/
function dict_get(dict, key) =
  dict[search([key], dict)[0]][1];


/*
    Updates the user parameters so the flake is unit size when `scale = 1`.
*/
function update_params(data) = let
    // factor was empirically found. It gives a flake that is circumscribed by the unit circle.
    (factor = 2.25) [
    [ "gap", 0.75 * dict_get(data, "scale") * dict_get(data, "gap") / factor ],
    [ "height", dict_get(data, "height") ],
    [ "scale", dict_get(data, "scale") / factor ],
    [ "thickness", dict_get(data, "scale") * dict_get(data, "thickness") / factor ],
];


/*
    The parameters for generating a NixOS flake.

    `gap` - The gap between lambdas.
    `height` - The z-height of the flake.
    `scale` - The radial (x,y) size of the flake.
    `thickness` - The thickness of the lambda legs.

    `scale` updates `gap` and `thickness` so there is no need to compesate these values.
    A `gap` of 0 will leave no gap between the lambdas.
    A `gap` of 1 will remove the top portion of the long lambda leg until the point where the two lambda legs intersect.

    A `gap` of 0.05 to 0.15 is a good value for replicating the official NixOS flake.
    A `thickness` of 0.5 is a good value for replicating the official NixOS flake.
    OpenSCAD doesn't have a concept of units so use `scale` and `height` values in the desired ratio.
*/
params = [
    [ "gap", 0.1 ],
    [ "height", 1 ],
    [ "scale", 10 ],
    [ "thickness", 0.5 ],
    [ "colors", ["#5277C3", "#7EBAE4"]],
];


flake(params);
