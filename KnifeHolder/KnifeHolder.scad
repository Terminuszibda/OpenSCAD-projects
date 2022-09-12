
$fn=100;

module mainBody(){
rotate([0,90,0])
    linear_extrude(120)
    square([50,50] ,center = true);
}

module backDetail(){
translate([160,0,-40])
    minkowski(){
        cube(60, center=true);
        sphere(10, $fn=100);
    }
}

module frontDetail(cubeSize=[60,80,80]){

translate([-22,0,10])
    rotate([0,15,0])
    cube(cubeSize, center = true);


translate([6,25,0])
rotate([90,0,0])

linear_extrude(50)
polygon(points=[[0,0],[20,0],[30,37.3],[10,37.3]]);
}

module makeKnifeSlots(){
    translate([-5,0,-25])
    knifeSlot(slotWidth=1.95);
    translate([-5,-20,-25])
    knifeSlot(slotWidth=1.95);
    translate([-5,20,-25])
    knifeSlot(slotWidth=1.95);
    translate([0,10,5])
    knifeSlot(slotHeigth=14, slotWidth=1.55);
    translate([0,-10,5])
    knifeSlot(slotHeigth=14, slotWidth=1.55);
}

module knifeSlot(knifeLength = 115, slotWidth = 1.75, slotHeigth = 20){
color("Red")
    hull(){
        cube([knifeLength,slotWidth-0.5,2]);
        translate([7,(slotWidth-0.5)/2-(slotWidth+0.5)/2,slotHeigth])
        cube([knifeLength,slotWidth+0.5,2]);
    }
}


difference(){
    minkowski(){
        mainBody();
        rotate([45,0,0])
        cube(5, center = true);
    }

    frontDetail();
    
    makeKnifeSlots();
}

