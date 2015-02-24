module hand(height, width, length) {
	rotate(a=0) {
	translate ([-width/4,-width/2,-height/2]) {
		union () {
			cube(size = [length,width,height]);
			translate([length,width/2,0]) {
				cylinder(h=height,r=width/2,$fn=20);
			}
			rotate(a=60) {
				union () {
					cube(size = [length+width/2,width,height]);
					translate([length+width/2,width/2,0]) {
						cylinder(h=height,r=width/2,$fn=20);
					}
				}
			}
		}
	}
	}
}

height=2.5;
width=2.5;
length=10;
radius=15;
hole=2;

difference() {
	rotate (a=90) {
		union () {
			cylinder(h=height,r=radius,$fn=6,center=true);
			for (i = [0:6]) {
				translate([cos(360*i/6)*radius,sin(360*i/6)*radius,0]) {
					rotate(a=360*i/6) {
						hand(height,width,length);
					}
				}
			}
		}
	}
	translate([0,radius*1/2,0]) {
		cylinder(h=height+1, r=hole, center=true);
	}
}