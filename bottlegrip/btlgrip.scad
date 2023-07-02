
$fn=150;

uppart = 7.5;
btldiam  = 38;

module grip() {
    minkowski(){
        square(size=[10, 6], center=true);
        rotate(45)
        square(4);
    }
}

module contacterBtl() {
    rotate(-10)
    rotate_extrude(angle=290)
    translate([27,0,0])
    grip();
}

module curveBTM() {
    rotate([270,90,0]) {
        rotate_extrude(angle=180)
        translate([20,0,0]) 
        rotate(90)
        grip();
    }
}


module handleUlt() {
    rotate([0,0,90])
        linear_extrude(20)
        grip();

    translate([-20,0,0]) {
        rotate([270,0,0]) {
            rotate_extrude(angle=70)
            translate([20,0,0]) 
            rotate(90)
            grip();
        }
        translate([5,0,-13.45]) {
            rotate([250,0,90]) {
                linear_extrude(30)
                grip();
            }
        }
        translate([15, 0, 26.7])
            rotate([250,0,90]) {
                linear_extrude(53)
                grip();
            }

        rotate([0, -20, 0])
            translate([-29,0,0])
            curveBTM();
    }
}

union()
{
    contacterBtl();

    rotate([45, 90, 0])
    {
        translate([0,0,-50])
        handleUlt();
    }
}
