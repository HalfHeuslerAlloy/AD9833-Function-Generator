Arduino Nano and AD9833 based function generator.
Uses an LCD display and supports most of the functions of the AD9833.
Very basic support for SCPI commands over the back serial port.

Features:
    * Outputs square,triangle and sinewaves
    * 1Hz - 12MHz
    * 16*2 Display interface
    * Mechanical keyboard switches
    * Rotary dial
    * Very simple SCPI commands over serial
    * OpenSCAD design case

Future:
    * Amplifyier module



Current SCPI commands:
    "FREQ Num"
        Set the frequency is Hz.
    "WAVE Num"
        Set the wave type. Encoded as 5 options off, sinewave, squarewave1,squarewave2,triangle wave; 1,2,3,4,5