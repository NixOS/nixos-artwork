
// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.
fudge = 0.1;

resize = 1.2;
h = 1.3;
hole = 1.6;

module poly_use4877(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[14.207302,24.606074],[49.535701,-36.577571],[57.571512,-22.955866],[48.295577,-6.991831],[66.717461,-6.943450],[70.643564,-0.136878],[66.634395,6.824948],[40.412750,6.742153],[30.078745,24.607594]]);
  }
}

module poly_use4867(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[28.458722,0.008829],[24.048793,-7.633090],[19.638494,-15.274795],[15.227887,-22.916323],[10.817037,-30.557711],[6.406008,-38.198996],[1.994864,-45.840215],[-6.827516,-61.122604],[8.987139,-61.270958],[18.174426,-45.255754],[27.427286,-61.185376],[35.285004,-61.182278],[39.309521,-54.229323],[26.127003,-31.562097],[36.358720,-13.756949]]);
  }
}

module poly_use4875(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[6.242489,-38.482132],[-14.321266,-38.519856],[-27.360264,-61.269896],[-35.393881,-61.261111],[-39.325426,-54.457909],[-30.156475,-38.479555],[-48.619947,-38.530715],[-56.398803,-24.761012],[14.165366,-24.757388],[6.242489,-38.482132]]);
  }
}

module poly_use4865(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-14.163043,24.603341],[56.353710,24.610099],[48.574866,38.380159],[30.111644,38.328989],[39.280671,54.306992],[35.349053,61.110382],[27.315368,61.119393],[14.276240,38.369401],[-6.191601,38.327891]]);
  }
}

module poly_use4863(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-14.126419,-24.758850],[-49.535698,36.564898],[-57.571510,22.943194],[-48.295574,6.979159],[-66.717461,6.930749],[-70.643564,0.124177],[-66.634393,-6.837620],[-40.412747,-6.754854],[-29.997860,-24.764369]]);
  }
}

module poly_path4861(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-28.291283,-0.227362],[6.874205,61.122604],[-8.940450,61.270958],[-18.127737,45.255754],[-27.380597,61.185376],[-35.238315,61.182278],[-39.262832,54.229323],[-26.080314,31.562097],[-36.191280,13.454298]]);
  }
}

$fn=25;
difference() {
    union() {
        scale([resize,resize,1]){
        poly_use4877(h);
        poly_use4867(h);
        poly_use4875(h);
        poly_use4865(h);
        poly_use4863(h);
        poly_path4861(h);
        }
    }
    translate([resize*4.5,resize*9.7,-0.1]) cylinder(h=h+0.2, r=resize*hole);
}