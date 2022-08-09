// Distance between mounting points
X_distance = 58;
Y_distance = 49;

// Mounting points
loc1 = [85   ,10   ,-5];
loc2 = [85   ,10+Y_distance,-5];
loc3 = [85-X_distance,10   ,-5];
loc4 = [85-X_distance,10+Y_distance,-5];

module MakeSpacerHole(diam){
    linear_extrude(6)
    circle(d=diam, $fn=20);
}
module MakeBoltHole(diam){
    linear_extrude(20)
    circle(d=diam, $fn=20);
}

module baseCube(){
    difference() {
        cube([90,64,5]);
        //Card slot
        translate([91,34,-4])
        cylinder(h=10,r1=10,r2=10, $fn=50);
    }
}

color("SlateGray")
difference(){
    union(){ 
        minkowski(){
            baseCube();
            sphere(1);
        }
        
        intersection(){
            translate([45,45,10])
            rotate([0,180,0])
            import("data/perlinnoise.stl");

            translate([0,0,-5])
            baseCube();
        }
        
        translate([85,10,5])
        sphere(d=8, $fn=40);
        
        translate([85,10+Y_distance,5])
        sphere(d=8, $fn=40);
        
        translate([85-X_distance,10,5])
        sphere(d=8, $fn=40);
        
        translate([85-X_distance,10+Y_distance,5])
        sphere(d=8, $fn=40);
    }
    
    translate(loc1)
    MakeBoltHole(3);
    translate([85,10,-4])
    MakeSpacerHole(7);

    translate(loc2)
    MakeBoltHole(3);
    translate([85,10+49,-4])
    MakeSpacerHole(7);
    
    translate(loc3)
    MakeBoltHole(3);
    translate([85-58,10,-4])
    MakeSpacerHole(7);
    
    translate(loc4)
    MakeBoltHole(3);
    translate([85-58,10+49,-4])
    MakeSpacerHole(7);

    translate([5,8,7])
    minkowski(){
        cube([15,52,5]);
        sphere(3);
    }
}

translate([0,-24,0])
color("LimeGreen")
difference(){
    union(){

        minkowski(){
            cube([90,24,36]);
            sphere(1);
        }
        translate([45,0,27])
        intersection(){
            import("data/perlinnoise.stl");
            translate([-45,0,7])
            cube([90,24,7]);
        }
        
        intersection(){

            translate([45,-21,10])
            rotate([0,180,0])
            import("data/perlinnoise.stl");

            translate([0,0,-5])
            cube([90,24,7]);
        }
    }

    translate([-5,-5,-5])
        cube([100,24,35]);

        translate([25,12,34])
        MakeSpacerHole(7);

        translate([25,12,25])
        MakeBoltHole(4);

        translate([65,12,34])
        MakeSpacerHole(7);

        translate([65,12,25])
        MakeBoltHole(4);

}