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
    * Amplifier module



Current SCPI commands:
    "FREQ Num"
        Set the frequency in Hz.
    "WAVE Num"
        Set the wave type. Encoded as a number between 1-5. Options are:
            Off (1), Sinewave (2), Squarewave1 (3),Squarewave2 (4), Triangle wave (5)
