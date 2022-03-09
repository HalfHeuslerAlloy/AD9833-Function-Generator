$fn = 50;

module Button(Text){
    Width = 16;
    Length = 16;
    Height = 20;
    RadiusC = 2;
    RadiusS = 5;
    Taper = 0.8;
    
    Depth = 6;
    FS = Width*1.5;
    
    A = Length - RadiusC;
    B = Width - RadiusC;
    difference(){
        hull(){
            translate([ A, B, 0]) cylinder(r=RadiusC,h=0.1);
            translate([-A, B, 0]) cylinder(r=RadiusC,h=0.1);
            translate([ A,-B, 0]) cylinder(r=RadiusC,h=0.1);
            translate([-A,-B, 0]) cylinder(r=RadiusC,h=0.1);
            
            translate([ A*Taper, B*Taper, Height-0.1]) cylinder(r=RadiusC,h=0.1);
            translate([-A*Taper, B*Taper, Height-0.1]) cylinder(r=RadiusC,h=0.1);
            translate([ A*Taper,-B*Taper, Height-0.1]) cylinder(r=RadiusC,h=0.1);
            translate([-A*Taper,-B*Taper, Height-0.1]) cylinder(r=RadiusC,h=0.1);
        }
        translate([0,0,3.4])
        cube([2*A-0.5,2*B-0.5,7], center=true);
        L_AB = sqrt(A*A+B*B);
        translate([0,0,Height]) scale([L_AB,L_AB,RadiusS]) sphere(r=1);
        
        translate([0,-FS*0.05,Height-Depth]) linear_extrude(20)
        text(Text,size = FS,valign="center",halign="center");
    }
    //attachment rod
    difference(){
        cylinder(r=5.2/2,h=8);
        union(){
            translate([0,0,3.9]) cube([4.2,1.5,8],center=true);
            translate([0,0,3.9]) cube([1.5,4.2,8],center=true);
            translate([0,0,-0.8]) cylinder(r1=3.2,r2=0.2,h=3);
        }
    }
    rotate([0,0,90]) translate([2.5,-0.5,0]) cube([A-2.5,1,7]);
    rotate([0,0,-90]) translate([2.5,-0.5,0]) cube([A-2.5,1,7]);
}

Button("<");