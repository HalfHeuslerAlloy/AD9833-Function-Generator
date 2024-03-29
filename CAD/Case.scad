$fn = 50;

include<Components.scad>;
include<Utils.scad>;

module Dial(){
    color("lightblue"){
        difference(){
            union(){
                translate([0,0,-3]) cylinder(r1=12,r2=11,h=13);
                translate([0,0,-4]) cylinder(r1=11,r2=12,h=1);
            }
            union(){
                N = 15;
                for(i=[0:N]){
                    rotate([0,-5,i*(360/N)]) translate([13,0,-3]) cylinder(r=2,h=13);
                    }
                translate([0,0,9]) cylinder(r1=7,r2=10,h=2);
                 
                translate([0,0,-5]) cylinder(r=6,h=5);
                translate([0,0,-4.5]) cylinder(r1=7,r2=6,h=1);
                    
                translate([0,0,-1]) intersection(){
                    cylinder(r=3.1,h=8);
                    translate([-4,-3.1,0]) cube([8,4.6,15]);
                    }
                }
        }
    }
}

module ControlPanel(){
    
    Screen_Pos = [10,20,0];
    Dial_Pos = [80,10,0];
    BNC_Pos = [85,10,5];
    
    RightB_Pos = [55,10,0];
    LeftB_Pos = [35,10,0];
    
    Power_Pos = [12,10,5];
    
    union(){
        translate(Screen_Pos-[0,0,2]) LCD();
        translate(Dial_Pos+[0,0,8.5]) Dial();
        //translate(BNC_Pos) BNCSocket();
        translate(Dial_Pos+[0,0,-6.1]) RotaryEncoder();
        translate(LeftB_Pos+[0,0,3.1]) color("blue") MechKey();
        translate(RightB_Pos+[0,0,3.1]) color("blue") MechKey();
    }
        
    difference(){
        union(){
            //translate([-0.3,0,-1.8]) cube([5,60,4.6]);
            //translate([95.5-0.2,0,-1.8]) cube([5,60,4.6]);
            *union(){
            translate([2,0,0.5]) rotate([-90,22,0])
                cylinder(r=2.4,h=57.5,$fn=8);
            translate([98,-0.05,0.5]) rotate([-90,22,0])
                cylinder(r=2.4,h=57.5,$fn=8);
            translate([1,-1,0.5]) rotate([90,22,90])
                cylinder(r=2.4,h=98,$fn=8);
            translate([2.2,0,0]) cube([94.6,57.5,4]);
            }
            translate([2.2,57.5,0]) rotate([180,0,0]) Panel(94.6,57.5,4);
        }
        union(){
            //Knob
            translate(Dial_Pos-[0,0,1]) cylinder(r=7.1/2,h=7);
            translate(Dial_Pos) cube([18,18,5],center=true);
            //translate(Dial_Pos-[0,0,1]) cylinder(r=8,h=0.1);
            
            //BNC
            //intersection(){
            //translate(BNC_Pos-[0,0,6]) cylinder(r=9.6/2,h=7);
            //translate(BNC_Pos-[0,0,6]) cube([10,8.5,20],center=true);
            //}
            //translate(BNC_Pos-[0,0,8]) cylinder(r=7.5,h=5);
            
            //Power switch
            intersection(){
            translate(Power_Pos-[0,0,6]) cylinder(r=7.1/2,h=7);
            translate(Power_Pos-[0,0,6]) cube([5.5,8.5,20],center=true);
            }
            translate(Power_Pos-[0,0,6]) cylinder(r=8.2/2,h=2);
            
            //Screen
            translate(Screen_Pos){
                
                translate([-1,-1,-5]) cube([82,38,5]);
                translate([4.5,4,-0.1]) cube([70.7,27.7,6.1]);
                translate([0,6.15,-0.1]) cube([80,23.7,3]);
                translate([5,0,-0.1]) cube([70,36,3]);
                //Holes
                ScRad = 2/2;
                translate([2.5,2.5,-0.1]) cylinder(r=ScRad,h=2);
                translate([80-2.5,2.5,-0.1]) cylinder(r=ScRad,h=2);
                translate([2.5,36-2.5,-0.1]) cylinder(r=ScRad,h=2);
                translate([80-2.5,36-2.5,-0.1]) cylinder(r=ScRad,h=2);
            }
            
            //Bottons
            translate(LeftB_Pos){
                translate([0,0,8]) cube([16,16,10], center=true);
                translate([0,0,0]) cube([14.3,14.3,10], center=true);
            }
            //Bottons
            translate(RightB_Pos){
                translate([0,0,8]) cube([16,16,10], center=true);
                translate([0,0,0]) cube([14.3,14.3,10], center=true);
            }
        }
    } 
}
module BackPanelText(){
    
    USB_B_Pos = [40.8,29,0];
    BJS_Pos = [19,35,0];
    
    SF = 5;
    
    linear_extrude(0.2) translate(BJS_Pos+[0,6,0])
        text("12V",size=SF,halign="center");
    linear_extrude(0.2) translate(USB_B_Pos+[0,12,0])
        text("USB",size=SF,halign="center");
    
    W = 60;
    H = 62;
    LW = 0.5;
    Rad = 5;
    Brdr = 5;
    difference(){
        hull(){
            translate([Rad+Brdr,Rad+Brdr,0])
                cylinder(r=Rad,h=0.2);
            translate([W-Rad-Brdr,Rad+Brdr,0])
                cylinder(r=Rad,h=0.2);
            translate([Rad+Brdr,H-Rad-Brdr,0])
                cylinder(r=Rad,h=0.2);
            translate([W-Rad-Brdr,H-Rad-Brdr,0])
            cylinder(r=Rad,h=0.2);
        }
        translate([0,0,-0.1]) hull(){
            translate([Rad+LW+Brdr,Rad+LW+Brdr,0])
                cylinder(r=Rad-LW,h=0.4);
            translate([W-Rad-LW-Brdr,Rad+LW+Brdr,0])
                cylinder(r=Rad-LW,h=0.4);
            translate([Rad+LW+Brdr,H-Rad-LW-Brdr,0])
                cylinder(r=Rad-LW,h=0.4);
            translate([W-Rad-LW-Brdr,H-Rad-LW-Brdr,0])
                cylinder(r=Rad-LW,h=0.4);
        }
    }
    
}

module BackPanel(){
    
    USB_B_Pos = [40,24,0];
    BJS_Pos = [18,31,0];
    
    *union(){
        translate(USB_B_Pos-[0,0,11]) rotate([-90,-90,0]) USB_B();
        translate(BJS_Pos-[0,0,10.2]) rotate([0,0,180]) BarrelJackSocket();
    }
        
    difference(){
        union(){
            *union(){
            translate([1,0,0.5]) rotate([-90,22,0])
                cylinder(r=2.4,h=57.5,$fn=8);
            translate([57,0,0.5]) rotate([-90,22,0])
                cylinder(r=2.4,h=57.5,$fn=8);
            
            translate([2.2,0,0]) cube([54.6,57.5,4]);
            
            translate([1,-1,0.5]) rotate([90,22,90])
                cylinder(r=2.4,h=57,$fn=8);
            }
            
            translate([2.2,57.5,0]) rotate([180,0,0]) Panel(54.6,57.5,4);
            
            //USB
            translate(USB_B_Pos-[12,7,21]) cube([24,5.2,21]);
        }
        union(){
            
            //USB
            translate(USB_B_Pos-[6.3,0.2,1]) cube([12.6,11,10.7]);
            intersection(){
                translate(USB_B_Pos-[12,9,21]) cube([24,12,21]);
                translate(USB_B_Pos-[0,8,2]) rotate([-90,0,0])
                cylinder(r=10,h=7);
            }
            translate(USB_B_Pos-[7.5,8,14.8]) rotate([-90,0,0])
                cylinder(r=1,h=7);
            translate(USB_B_Pos-[-7.5,8,14.8]) rotate([-90,0,0])
                cylinder(r=1,h=7);
            
            //Barrel Jack socket
            translate(BJS_Pos-[0,1.15,-2])
                cube([9.4,11.2,5],center=true);
            translate(BJS_Pos-[0,3.2,0])
                cube([4,11.4,2.2],center=true);
        }
    } 
}

module Amp_Panel(){
    
    BNC_Pos = [20,30,5];
    
    difference(){
        translate([2.2,57.5,0]) rotate([180,0,0]) Panel(34.6,57.5,4);
        union(){
            //BNC
            intersection(){
            translate(BNC_Pos-[0,0,6]) cylinder(r=9.6/2,h=7);
            translate(BNC_Pos-[0,0,6]) cube([10,8.3,20],center=true);
            }
            translate(BNC_Pos-[0,0,8]) cylinder(r=7.5,h=5);
            translate([5,3,-1]) cube([29,51,4.6]);
        }
    }
}

module Base(){
    Size = [190,100,10];
    Rad = 10;
    Wall = 5;
    BaseT = 5;
    Rim = 2.5;
    
    //Screen
    Control_Pos = [15,0,0];
    
    //Future Amp
    Amp_Pos = [120,0,0];
    
    //Back panel
    Back_Pos = [20,100-8,0];
    
    union(){
        translate(Control_Pos+[8,4,5.2]) rotate([90,0,0]) ControlPanel();
        translate(Amp_Pos+[8,4,5.2]) rotate([90,0,0]) Amp_Panel();
        translate(Back_Pos+[67,4,5.2]) rotate([90,0,180]) BackPanel();
        color("black") translate(Back_Pos+[68,8.2,2.5]) rotate([90,0,180])
            BackPanelText();
    }

    
    difference(){
        union(){
        difference(){
            union(){
                //Main Base
                hull(){
                    translate([Rad,Rad,0])
                        cylinder(r=Rad,h=Size[2]);
                    translate([Size[0]-Rad,Rad,0])
                        cylinder(r=Rad,h=Size[2]);
                    translate([Rad,Size[1]-Rad,0])
                        cylinder(r=Rad,h=Size[2]);
                    translate([Size[0]-Rad,Size[1]-Rad,0])
                        cylinder(r=Rad,h=Size[2]);
                }
                //Rim
                hull(){
                    translate([Rad,Rad,Size[2]])
                        cylinder(r1=Rad-Rim,r2=Rad-Rim-1,h=2);
                    translate([Size[0]-Rad,Rad,Size[2]])
                        cylinder(r1=Rad-Rim,r2=Rad-Rim-1,h=2);
                    translate([Rad,Size[1]-Rad,Size[2]])
                        cylinder(r1=Rad-Rim,r2=Rad-Rim-1,h=2);
                    translate([Size[0]-Rad,Size[1]-Rad,Size[2]])
                        cylinder(r1=Rad-Rim,r2=Rad-Rim-1,h=2);
                }
                //Bottom Chamfer
                hull(){
                    translate([Rad,Rad,-2])
                        cylinder(r1=Rad-2,r2=Rad,h=2);
                    translate([Size[0]-Rad,Rad,-2])
                        cylinder(r1=Rad-2,r2=Rad,h=2);
                    translate([Rad,Size[1]-Rad,-2])
                        cylinder(r1=Rad-2,r2=Rad,h=2);
                    translate([Size[0]-Rad,Size[1]-Rad,-2])
                        cylinder(r1=Rad-2,r2=Rad,h=2);
                }
            }
            difference(){
                hull(){
                    translate([Rad,Rad,BaseT])
                        cylinder(r=Rad-Wall,h=Size[2]);
                    translate([Size[0]-Rad,Rad,BaseT])
                        cylinder(r=Rad-Wall,h=Size[2]);
                    translate([Rad,Size[1]-Rad,BaseT])
                        cylinder(r=Rad-Wall,h=Size[2]);
                    translate([Size[0]-Rad,Size[1]-Rad,BaseT])
                        cylinder(r=Rad-Wall,h=Size[2]);
                }
                //Bolt supports
                union(){
                    translate([Rad,Rad,-5])
                        cylinder(r=7,h=22);
                    translate([Size[0]-Rad,Rad,-5])
                        cylinder(r=7,h=22);
                    translate([Rad,Size[1]-Rad,-5])
                        cylinder(r=7,h=22);
                    translate([Size[0]-Rad,Size[1]-Rad,-5])
                        cylinder(r=7,h=22);
                }
        }
        }
        
        //Feet
        *difference(){
            union(){
                translate([Rad*2,Rad*2,-5])
                    cylinder(r1=5,r2=Rad-1,h=5);
                translate([Size[0]-Rad*2,Rad*2,-5])
                    cylinder(r1=5,r2=Rad-1,h=5);
                translate([Rad*2,Size[1]-Rad*2,-5])
                    cylinder(r1=5,r2=Rad-1,h=5);
                translate([Size[0]-Rad*2,Size[1]-Rad*2,-5])
                    cylinder(r1=5,r2=Rad-1,h=5);
            }
            union(){
                translate([Rad*2,Rad*2,-5.4])
                    cylinder(r=4.1,h=1);
                translate([Size[0]-Rad*2,Rad*2,-5.4])
                    cylinder(r=4.1,h=1);;
                translate([Rad*2,Size[1]-Rad*2,-5.4])
                    cylinder(r=4.1,h=1);;
                translate([Size[0]-Rad*2,Size[1]-Rad*2,-5.4])
                    cylinder(r=4.1,h=1);;
            }
        
    }
        //Control Frame
        translate(Control_Pos+[3,0,0]) cube([7,8,63]);
        translate(Control_Pos+[0,0,0]) cube([9,5,63]);
        translate(Control_Pos+[105,0,0]) cube([10,8,63]);
        translate(Control_Pos+[-2,Rim+1,0]) cube([119,Rim-1,65]);
        
        //Amp Frame
        translate(Amp_Pos) cube([10,8,63]);
        translate(Amp_Pos+[45,0,0]) cube([8,8,63]);
        translate(Amp_Pos+[45,0,0]) cube([10,5,63]);
        translate(Amp_Pos+[-2,Rim+1,0]) cube([59,Rim-1,65]);
        
        //Back Frame
        translate(Back_Pos) cube([10,8,63]);
        translate(Back_Pos+[65,0,0]) cube([10,8,63]);
        translate(Back_Pos+[-2,Rim+0.5,0]) cube([79,Rim-1,65]);
        
        }
    
        //Control Frame
        translate(Control_Pos+[7.8,1.6, 2]) cube([99.4,4.8,66]);
        translate(Control_Pos+[10,-0.01, 5]) cube([95,10,66]);
        
        //Amp Frame
        translate(Amp_Pos+[7.8,1.6, 2]) cube([39.4,4.8,66]);
        translate(Amp_Pos+[10,-0.01, 5]) cube([35,10,66]);
        
        //Back Frame
        translate(Back_Pos+[7.8,1.6, 2]) cube([59.4,4.8,66]);
        translate(Back_Pos+[10,-0.01, 5]) cube([55,10,66]);
        
        //Bolts
        union(){
            translate([Rad,Rad,-5])
                cylinder(r=2.2,h=20);
            translate([Size[0]-Rad,Rad,-5])
                cylinder(r=2.2,h=20);
            translate([Rad,Size[1]-Rad,-5])
                cylinder(r=2.2,h=20);
            translate([Size[0]-Rad,Size[1]-Rad,-5])
                cylinder(r=2.2,h=20);
        }
        union(){
            translate([Rad,Rad,-5])
                cylinder(r=4.7,h=14);
            translate([Size[0]-Rad,Rad,-5])
                cylinder(r=4.7,h=14);
            translate([Rad,Size[1]-Rad,-5])
                cylinder(r=4.7,h=14);
            translate([Size[0]-Rad,Size[1]-Rad,-5])
                cylinder(r=4.7,h=14);
        }
    
    
    }
    
    
}


module Case(){
    Size = [190,100,10];
    Rad = 10;
    Wall = 5;
    BaseT = 5;
    Rim = 2.5;
    Height = 60;
    
    //Screen
    Control_Pos = [15,0,0];
    
    //Future Amp
    Amp_Pos = [120,0,0];
    
    //Back panel
    Back_Pos = [20,100-8,0];
    
    module Nut_Slot(Rad,Wall){
        difference(){
            union(){
            //translate([0,0,-4.8]) cylinder(r=4.8,h=8);
            hull(){
                translate([0,0,0]) cylinder(r=5.6,h=5);
                translate([-Rad/2-1,0,0]) cube([1,10,15]);
            }
        }
            union(){
                translate([0,0,2]) rotate([0,0,15])
                    cylinder(r=4.5,h=30,$fn=6);
                translate([0,0,-0.5]) cylinder(r=2.2,h=12);
                translate([0,0,6]) cylinder(r=5,h=15);
            }
        }
    }
    
    translate([Rad,Rad,1.9]) rotate([0,0,0])
        Nut_Slot(Rad,Wall);
    translate([Size[0]-Rad,Size[1]-Rad,1.9]) rotate([0,0,180])
        Nut_Slot(Rad,Wall);
    translate([Size[0]-Rad,Rad,1.9]) rotate([0,0,0])
        mirror([1,0,0]) Nut_Slot(Rad,Wall);
    translate([Rad,Size[1]-Rad,1.9]) rotate([0,0,180])
        mirror([1,0,0]) Nut_Slot(Rad,Wall);
    
    difference(){
        union(){
        difference(){
            union(){
            hull(){
                translate([Rad,Rad,0])
                    cylinder(r=Rad,h=Height);
                translate([Size[0]-Rad,Rad,0])
                    cylinder(r=Rad,h=Height);
                translate([Rad,Size[1]-Rad,0])
                    cylinder(r=Rad,h=Height);
                translate([Size[0]-Rad,Size[1]-Rad,0])
                    cylinder(r=Rad,h=Height);
            }
            hull(){
                translate([Rad,Rad,Height])
                    cylinder(r1=Rad,r2=Rad-2,h=2);
                translate([Size[0]-Rad,Rad,Height])
                    cylinder(r1=Rad,r2=Rad-2,h=2);
                translate([Rad,Size[1]-Rad,Height])
                    cylinder(r1=Rad,r2=Rad-2,h=2);
                translate([Size[0]-Rad,Size[1]-Rad,Height])
                    cylinder(r1=Rad,r2=Rad-2,h=2);
            }
        }
            hull(){
                translate([Rad,Rad,-BaseT])
                    cylinder(r=Rad-Wall,h=Height);
                translate([Size[0]-Rad,Rad,-BaseT])
                    cylinder(r=Rad-Wall,h=Height);
                translate([Rad,Size[1]-Rad,-BaseT])
                    cylinder(r=Rad-Wall,h=Height);
                translate([Size[0]-Rad,Size[1]-Rad,-BaseT])
                    cylinder(r=Rad-Wall,h=Height);
            }
        }
        
        }
        //Rim
        FitA = 0.4;
        translate([0,0,-0.1]){
            hull(){
                translate([Rad,Rad,0])
                    cylinder(r1=Rad-Rim+FitA,r2=Rad-Rim-1+FitA,h=2);
                translate([Size[0]-Rad,Rad,0])
                    cylinder(r1=Rad-Rim+FitA,r2=Rad-Rim-1+FitA,h=2);
                translate([Rad,Size[1]-Rad,0])
                    cylinder(r1=Rad-Rim+FitA,r2=Rad-Rim-1+FitA,h=2);
                translate([Size[0]-Rad,Size[1]-Rad,0])
                    cylinder(r1=Rad-Rim+FitA,r2=Rad-Rim-1+FitA,h=2);
            }
        }
    
        //Control Frame
        translate(Control_Pos+[-0.5,-0.01, -0.1]) cube([121,10,53.1]);
        translate(Control_Pos+[7.8,1.6, 2]) cube([99.4,4.8,58]);
        translate(Control_Pos+[-2.5,Rim+0.5,0]) cube([120,Rim,58]);
        //Amp Frame
        translate(Amp_Pos+[-0.5,-0.01,-0.1]) cube([56,10,53.1]);
        translate(Amp_Pos+[7.8,1.6, 2]) cube([39.4,4.8,58]);
        translate(Amp_Pos+[-2.5,Rim+0.5,0]) cube([60,Rim,58]);
        //Back Frame
        translate(Back_Pos+[-0.5,-0.01,-0.1]) cube([76,10,53.1]);
        translate(Back_Pos+[7.8,1.6, 2]) cube([59.4,4.8,58]);
        translate(Back_Pos+[-2.5,Rim,0]) cube([80,Rim,58]);
    
    
    }
    
    
}

module RF_Unit(){
    union(){
        difference(){
            ShieldedBox(50,50,20,5);
            
            //BNC
            translate([25,10,11]) rotate([90,0,0]) intersection(){
            translate([0,0,6]) cylinder(r=9.4/2,h=7);
            translate([0,0,6]) cube([8.3,10,20],center=true);
            }
            translate([25,1.5,11]) rotate([90,0,0]) cylinder(r=7,h=5);
            translate([-0.1,20,10]) cube([5,10,2]);
        }
        
        HoleA = 1.2;
        
        translate([35,18,0]) difference(){
            cylinder(r=HoleA*3,h=8);
            translate([0,0,-0.5]) cylinder(r=HoleA,h=10);
        }
        translate([35,31,0]) difference(){
            cylinder(r=HoleA*3,h=8);
            translate([0,0,-0.5]) cylinder(r=HoleA,h=10);
        }
    }
    rotate([180,0,0]) translate([0,5,-3.5])  ShieldedLid(50,50,5);
}

//translate([0,0,0]) rotate([180,0,0]) BackPanel();
//translate([0,0,4.2]) color("Black") BackPanelText();
//translate([0,0,50]) Dial();

*difference(){
    union(){
        Base();
        translate([0,0,10.5]) color("lightblue") Case();
    }
    translate([-100,-100,00]) rotate([0,-10,0])  cube([1000,1000,1000]);
}

*difference(){
    union(){
        translate([31,0.1,5]) rotate([0,-90,0]) RF_Unit();
        //translate([0,0,0]) rotate([90,0,0]) Amp_Panel();
        //translate([20,-4,30]) rotate([90,0,0]) BNCSocket();
    }
    //translate([20,-10,0]) cube([100,100,100]);
}

//translate([0,0,0]) RF_Unit();
difference(){
    Amp_Panel();
    translate([-5,-20,-5]) cube([80,20,50]);
}
//Base();
//rotate([180,0,0]) Case();