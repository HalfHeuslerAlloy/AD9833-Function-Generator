module LCD(){
    difference(){
        union(){
            color("green") cube([80,36,1.6]);
            color("grey") translate([4.8,4.36,0.1]) cube([70.1,27,6.1]);
            color([0,0,0]) translate([5,7,-3.3]) cube([4,1,4]);
            color([0,0,0]) translate([5,28,-3.3]) cube([4,1,4]);
            color([0,0,0]) translate([38,7,-3.3]) cube([4,1,4]);
            color([0,0,0]) translate([38,28,-3.3]) cube([4,1,4]);
            color([0,0,0]) translate([70,7,-3.3]) cube([4,1,4]);
            color([0,0,0]) translate([70,28,-3.3]) cube([4,1,4]);
            }
        union(){
            translate([2.5,2.5,-0.1]) cylinder(r=2.5/2,h=2);
            translate([80-2.5,2.5,-0.1]) cylinder(r=2.5/2,h=2);
            translate([2.5,36-2.5,-0.1]) cylinder(r=2.5/2,h=2);
            translate([80-2.5,36-2.5,-0.1]) cylinder(r=2.5/2,h=2);
        }
    }
}

module USB_B(){
    difference(){
        union(){
            translate([0,-12.1/2,0]) color("grey")  cube([16.3,12.1,10.7]);
            translate([0,0,-1.51/2]) color("green")  cube([20.2,20.2,1.51],center=true);
        }
        union(){
            translate([-3.8, 15/2,-1.6]) cylinder(r=1.5,h=2);
            translate([-3.8,-15/2,-1.6]) cylinder(r=1.5,h=2);
        }
    }
}

module BarrelJackSocket(){
    color([0.3,0.3,0.3])union(){
        cylinder(r=4, h=14.25);
        translate([-9.2/2,-4.4,10.88]) cube([9.2,11.1,3.48]);
        translate([-9.2/2,0,0]) cube([9.2,6.7,14.25]);
        translate([0,6.7,10.5]) rotate([-90,0,0])
        cylinder(r=0.9,h=2);
    }
}

module MechKey(){
    union(){
        rotate([180,0,0]) cylinder(r=1.9,h=8);
        translate([0,0,-4.94/2]) cube([13.91,13.97,4.94],center=true);
        translate(-[15.56,15.57,0]/2) cube([15.56,15.57,1]);
        hull(){
            translate(-[13.73,14.48,-2]/2) cube([13.73,14.48,1.2]);
            translate([0,1,6]) cube([11,9.5,0.1],center=true);
        }
        
        translate([0,0,10.5]/2) cube([1.1,4,10.5], center=true);
        translate([0,0,10.5]/2) cube([4,1.1,10.5], center=true);
        
        difference(){
            translate([0,0,10.5]/2) cube([7,5.3,10.5],center=true);
            cylinder(r=5.5/2,h=10.6);
        }
    }
    
}

module BNCSocket(){
    color("pink"){
    cylinder(r=12.5/2,h=1.2);
    cylinder(r=10/2,h=11);
    difference(){
        union(){
        rotate([180,0,0]) cylinder(r=9.2/2,h=10);
        translate([0,0,-11.5]) cylinder(r1=5.6/2,r2=9.2/2,h=1.5);
        }
        union(){
            translate([-5,8.2/2,-14]) cube([10,6,20]);
            rotate([0,0,180]) translate([-5,8.2/2,-14]) cube([10,6,20]);
        }
    }
    rotate([180,0,0]) cylinder(r=2/2,h=17);
    }
}

module RotaryEncoder(){
    L = 19.8;
    F = 7;
    color("grey")union(){
        cylinder(r=6.9/2,h=11);
        difference(){
            cylinder(r=3,h=L);
            translate([-3,1.53,L-F]) cube([6,6,F+1]);
        }
        translate([0,0,3]) cube([13.5,12.8,5.85],center=true);
        translate([0,7,-1]) cube([6,1,6],center=true);
        translate([0,-7,-1]) cube([6,1,6],center=true);
        
        A = 11.3/2;
        B = 9.5/2;
        translate([A,B,0]) cylinder(r=0.5,h=6.66);
        translate([-A,B,0]) cylinder(r=0.5,h=6.66);
        translate([A,-B,0]) cylinder(r=0.5,h=6.66);
        translate([-A,-B,0]) cylinder(r=0.5,h=6.66);
    }
}