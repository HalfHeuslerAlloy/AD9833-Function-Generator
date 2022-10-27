module ShieldedBox(Lx,Ly,Lz,Rad,HoleRad=1.4,WallThk = 2){
    difference(){
        hull(){
            translate([   Rad,   Rad,0])
                cylinder(r1=Rad/2,r2=Rad,h=Rad/2);
            translate([Lx-Rad,   Rad,0])
                cylinder(r1=Rad/2,r2=Rad,h=Rad/2);
            translate([   Rad,Ly-Rad,0])
                cylinder(r1=Rad/2,r2=Rad,h=Rad/2);
            translate([Lx-Rad,Ly-Rad,0])
                cylinder(r1=Rad/2,r2=Rad,h=Rad/2);
            
            translate([   Rad,   Rad,Lz - 1]) cylinder(r=Rad,h=1);
            translate([Lx-Rad,   Rad,Lz - 1]) cylinder(r=Rad,h=1);
            translate([   Rad,Ly-Rad,Lz - 1]) cylinder(r=Rad,h=1);
            translate([Lx-Rad,Ly-Rad,Lz - 1]) cylinder(r=Rad,h=1);
        }
        union(){
            translate([WallThk,Rad+HoleRad*1.5,Rad/2])
                cube([Lx-WallThk*2,Ly-Rad*2-HoleRad*3,Lz]);
            translate([Rad+HoleRad*1.5,WallThk,Rad/2])
                cube([Lx-Rad*2-HoleRad*3,Ly-WallThk*2,Lz]);
            
            translate([   Rad,   Rad,Lz/2])
                cylinder(r=HoleRad,h=Lz);
            translate([Lx-Rad,   Rad,Lz/2])
                cylinder(r=HoleRad,h=Lz);
            translate([   Rad,Ly-Rad,Lz/2])
                cylinder(r=HoleRad,h=Lz);
            translate([Lx-Rad,Ly-Rad,Lz/2])
                cylinder(r=HoleRad,h=Lz);
            
            translate([0,0,Lz])hull(){
            translate([   Rad,   Rad,-Rad/2])
                cylinder(r=Rad-WallThk,h=Rad*1.1);
            translate([Lx-Rad,   Rad,-Rad/2])
                 cylinder(r=Rad-WallThk,h=Rad*1.1);
            translate([   Rad,Ly-Rad,-Rad/2])
                cylinder(r=Rad-WallThk,h=Rad*1.1);
            translate([Lx-Rad,Ly-Rad,-Rad/2])
                cylinder(r=Rad-WallThk,h=Rad*1.1);
            }
            
        }
    }
}

module ShieldedLid(Lx,Ly,Rad,HoleRad=1.4,WallThk = 2){
    difference(){
    union(){
        hull(){
            translate([   Rad,   Rad,1])
                cylinder(r1=Rad,r2=Rad/2,h=Rad/2);
            translate([Lx-Rad,   Rad,1])
                cylinder(r1=Rad,r2=Rad/2,h=Rad/2);
            translate([   Rad,Ly-Rad,1])
                cylinder(r1=Rad,r2=Rad/2,h=Rad/2);
            translate([Lx-Rad,Ly-Rad,1])
                cylinder(r1=Rad,r2=Rad/2,h=Rad/2);
            
            translate([   Rad,   Rad,0]) cylinder(r=Rad,h=1);
            translate([Lx-Rad,   Rad,0]) cylinder(r=Rad,h=1);
            translate([   Rad,Ly-Rad,0]) cylinder(r=Rad,h=1);
            translate([Lx-Rad,Ly-Rad,0]) cylinder(r=Rad,h=1);
        }
        hull(){
            translate([   Rad,   Rad,-Rad/2]) cylinder(r=Rad-WallThk-0.5,h=Rad);
            translate([Lx-Rad,   Rad,-Rad/2]) cylinder(r=Rad-WallThk-0.5,h=Rad);
            translate([   Rad,Ly-Rad,-Rad/2]) cylinder(r=Rad-WallThk-0.5,h=Rad);
            translate([Lx-Rad,Ly-Rad,-Rad/2]) cylinder(r=Rad-WallThk-0.5,h=Rad);
        }
     
    }
        
        translate([   Rad,   Rad,-Rad])
            cylinder(r=HoleRad,h=50);
        translate([Lx-Rad,   Rad,-Rad])
            cylinder(r=HoleRad,h=50);
        translate([   Rad,Ly-Rad,-Rad])
            cylinder(r=HoleRad,h=50);
        translate([Lx-Rad,Ly-Rad,-Rad])
            cylinder(r=HoleRad,h=50);
    }
}

module Panel(Width, Height,Thick){
    
    RimT = 2.4;
    
    translate([0,0,-Thick]) cube([Width,Height,Thick]);
    
    translate([0,0,0]) rotate([-90,22.5,0])
        cylinder(r=RimT,h=Height,$fn = 8);
    translate([0,0,0]) rotate([90,22.5,90])
        cylinder(r=RimT,h=Width,$fn = 8);
    translate([Width, Height,0]) rotate([-90,22.5,90])
        cylinder(r=RimT,h=Width,$fn = 8);
    translate([Width, Height,0]) rotate([90,22.5,0])
        cylinder(r=RimT,h=Height,$fn = 8);
    
    hull(){
    translate([0,1,0]) rotate([90,22.5,0])
        cylinder(r=RimT,h=1,$fn = 8);
    translate([1,0,0]) rotate([90,22.5,-90])
        cylinder(r=RimT,h=1,$fn = 8);
    }
    translate([Width,Height,0]) rotate([0,0,180]) hull(){
    translate([0,1,0]) rotate([90,22.5,0])
        cylinder(r=RimT,h=1,$fn = 8);
    translate([1,0,0]) rotate([90,22.5,-90])
        cylinder(r=RimT,h=1,$fn = 8);
    }
    translate([0,Height,0]) rotate([0,0,-90]) hull(){
    translate([0,1,0]) rotate([90,22.5,0])
        cylinder(r=RimT,h=1,$fn = 8);
    translate([1,0,0]) rotate([90,22.5,-90])
        cylinder(r=RimT,h=1,$fn = 8);
    }
    translate([Width,0,0]) rotate([0,0,90]) hull(){
    translate([0,1,0]) rotate([90,22.5,0])
        cylinder(r=RimT,h=1,$fn = 8);
    translate([1,0,0]) rotate([90,22.5,-90])
        cylinder(r=RimT,h=1,$fn = 8);
    }
    
}