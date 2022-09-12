$fn = 50;

handleLength = 55;
outerHandleRadius = 12;
innerHandleRadius = 9;

gripLength = 80;
gripRadius = 14;
// socket cutout variables
socketRadius = 3.85;
socketDepth = 22;

grooveLocation = [10,35];
coverHeight = handleLength - 5;

// Assemble parts
innerHandle(handleLength = handleLength, innerHandleRadius = innerHandleRadius, outerHandleRadius = outerHandleRadius);
outerCover(coverHeight = coverHeight, outerRadius = outerHandleRadius, innerHandleRadius = innerHandleRadius);
Grip(gripLength=gripLength, gripRadius=gripRadius);

module outerCover(coverHeight = 55 ,outerRadius = 13, innerHandleRadius = 10.2)
{
    partGap = 1.0;
    outerInnerRadius = innerHandleRadius + partGap;
    union(){
        difference(){
            cylinder(r=outerRadius, h= coverHeight);
            translate([0,0,-1])
            cylinder(r=outerInnerRadius, h= coverHeight+2);
        }

        rotate_extrude(){
            translate([outerRadius - 1,coverHeight,0])
            circle(r=1);
        }

        // Make groove bearing
        intersection(){
            cylinder(r=outerInnerRadius, h= coverHeight+2);
            for(zHeigth=grooveLocation){
                for(zDif=[0:45:360]){
                    rotate([0,0,zDif])
                    translate([outerInnerRadius+(partGap / 2),0,zHeigth])
                    sphere(r=outerHandleRadius/4);
                }
            }
        }
        for (twist = [100]){
            for(zDif=[0:45:360]){
                rotate([0,0,zDif])
                translate([0, 0, coverHeight/2])
                linear_extrude(height = coverHeight, center = true, convexity = 10, twist = twist)
                translate([outerRadius, 0, 0])
                circle(r = 1, $fn=8);
            }
        }
    }
}

module innerHandle(handleLength = 60, innerHandleRadius = 10.2, outerHandleRadius = 13)
{
    topCylinderHeight = 15;
    difference(){
        union(){
            // Middle Cylinder
            translate([0,0,-2])
            cylinder(r=innerHandleRadius, h=handleLength);
            
            // Top Cylinder
                translate([0,0,handleLength-2])
                cylinder(r=outerHandleRadius, h=topCylinderHeight);

            // Create inverse fillet
            fillet = 3;
            rotate_extrude(){
                translate([outerHandleRadius,handleLength-fillet-2,0])
                rotate([0,0,90])
                difference(){
                    square(size=fillet);
                    circle(fillet);
                }
            }
        }

        // ToolGrip cavity
        #translate([0,0,handleLength-topCylinderHeight+6])
        cylinder(r1=6,r2=5.9, h=11);
        translate([0,0,handleLength-topCylinderHeight+9+6])
        #difference(){
            sphere(r=6.2);
            translate([0,0,-6])
            cube([30,30,16], center=true);
        }

        // Top Fillet
        fillet = 3;
        rotate_extrude(){
            translate([outerHandleRadius-3,handleLength+topCylinderHeight-fillet-1,0])
            //rotate([90,90,0])
            difference(){
                square(size=fillet);
                circle(fillet);
            }
        }

        // Create Bearing Grooves 
        for(zHeigth=grooveLocation){
            rotate_extrude(){
                translate([innerHandleRadius,zHeigth,0])
                circle(r=(innerHandleRadius/3)+0.25);
            }
        }

        // Make socket insert
        translate([0,0,handleLength+topCylinderHeight-2])
        rotate([180,0,0])
        cylinder(r=socketRadius, h= socketDepth, $fn=6);
    }

    ToolGrip([0,0,handleLength-topCylinderHeight+0+6]);
}

module ToolGrip(location = [0,0,120])
{
    cutOutHeight = 11;
    difference(){
        intersection(){
            union(){
                difference(){
                    translate(location)
                    cylinder(r1=socketRadius+2.2,r2=socketRadius+1.0, h=cutOutHeight);
                    translate(location+[0,0,1])
                    cylinder(r1=socketRadius,r2=socketRadius, h=12);
                }

                rotate_extrude(){
                    translate([socketRadius+1.0,location[2]+cutOutHeight,0])
                    circle(r=1.5);
                }
            }
            translate(location)
            cylinder(r1=socketRadius+2.2,r2=socketRadius+0.5, h=14);
        }
        translate([0,0,location[2]+12])
        cube([3,20,20], center= true);

        translate([0,0,location[2]+2])
        rotate([180,0,0])
        cylinder(r=socketRadius, h= socketDepth, $fn=6);
    }
}

module Grip(gripLength=50, gripRadius=18)
{
    locationOffset = [0,0,-2];
    difference(){
        // Base handle
        translate(locationOffset)
        rotate([180,0,0])
        linear_extrude(gripLength)
        circle(r=gripRadius);

        fillet = 1;
        // Top Grip Fillet
        rotate_extrude(){
            translate([gripRadius - fillet,- fillet + locationOffset[2],0])
            difference(){
                square(size=fillet);
                circle(fillet);
            }
        }
        // Add text to bottom
        translate([-15,5,-gripLength+locationOffset[2]])
        linear_extrude(0.4){
            translate([14,0,0])
            text("TX",  valign="center", size=gripRadius / 3);

            rotate([0,180,0])
            translate([-15,-10,0])
            text("40",  valign="center", size=gripRadius / 3);
        }
    }



    module gripDecoration() {
        for(zDif=[0:45:360]){
            rotate([0,0,zDif])
            children();
        }
    }

    gripDecoration(){
        gripDecorationSize = 2;

        translate([gripRadius-1.5,0,-0-(gripLength * 0.9)+(gripLength / 1.5)])
        sphere(r=gripDecorationSize);
        translate([gripRadius-1.5,0,-(gripLength * 0.9)])
        cylinder(r=gripDecorationSize, h= gripLength / 1.5);
        translate([gripRadius-1.5,0,-(gripLength * 0.9)])
        sphere(r=gripDecorationSize);
    }
}