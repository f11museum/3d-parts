//

dd = 35; // diameter
hh = 20; // höjd

s_w = 11.5;
s_z = 3.5;
s_l = 20;

k_r = dd/2;
k_h = hh/2;
smooth = 60;

r = 6;
pad = 0.1;
ct = 2;

ch = 10;
$fs = 0.5;
$fa = 5.1;

C_M4_NUT = 8.4;
C_M4_DIAMETER = 4.1; // size of a hole that a M4 screw will slide through
C_M4_DIAMETER_THREAD = 3.8; // size of a hole that a M4 screw will create own threads in



rotate([90,0,0]) knob();
//switch_cut();


module knob() {
    
    difference() {
        union() {
            translate([0,k_h,0]) round_part();
            translate([0,-k_h,0]) mirror([0,1,0]) round_part();
            
        }
        translate([k_r-s_l,0,-s_z/2]) switch_cut();
    }
}

module round_part() {
    //rotate([90,0,0]) cylinder(d=dd, h= hh, center=true);
    rotate([90,0,0]) difference() {
        union() {
            // Basic cup shape
            difference() {
                cylinder(r = k_r, h = k_h ,center=false,$fn=smooth);
                //translate([0,0,ct])	cylinder(ch-ct+pad,cr-ct,cr-ct,center=false,$fn=smooth);
            }
        }		
        // Bottom Round
        difference() {
            rotate_extrude(convexity=10,  $fn = smooth)	translate([k_r-r+pad,-pad,0]) square(r+pad,r+pad);
            rotate_extrude(convexity=10,  $fn = smooth)	translate([k_r-r,r,0])	circle(r=r,$fn=smooth);
        }
    }
}

module switch_cut() {
    s1 = 13.2; // hur långt ut från spetsen på pinnen skruvhålet ska hamna
    wall = 3.8;
    translate([0,-s_w/2,0]) cube([s_l*2, s_w, s_z], center = false);
    
    hull() {
        translate([+s1,0,s_z+wall]) cylinder(d=C_M4_NUT, h= 4, $fn=6); //mutter
        translate([+s1+30,0,s_z+wall]) cylinder(d=C_M4_NUT, h= 4, $fn=6); //mutter
    }
    translate([+s1,0,-wall]) common_button_screw_tap(l = 15, l2 = 1);
}


module common_button_screw_tap(l = 10, l2 = 0) {
    screwhead_h = 30;
    tap_z = 1.1;
    union() {
        cylinder(d = C_M4_DIAMETER_THREAD, h= l);
        cylinder(d = C_M4_DIAMETER, h= l2);
        translate([0,0,-screwhead_h]) cylinder(d = 7, h=screwhead_h);
    }
}
