// include the library code:
#include <LiquidCrystal.h>
#include <MD_AD9833.h>
#include <SPI.h>


// Pins for SPI comm with the AD9833 IC
#define DATA  11  ///< SPI Data pin number
#define CLK   13  ///< SPI Clock pin number
#define FSYNC 10  ///< SPI Load pin number (FSYNC in AD9833 usage)

MD_AD9833 AD(FSYNC);  // Hardware SPI
// MD_AD9833  AD(DATA, CLK, FSYNC); // Arbitrary SPI pins

// initialize the library by associating any needed LCD interface pin
// with the arduino pin number it is connected to
const int rs = 2, en = 3, d4 = 7, d5 = 6, d6 = 5, d7 = 4;;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

byte type = 0;
int32_t Freq = 100;
byte Range = 1; //0 = mHz, 1 = Hz, 2 = KHz (aiming for only ~1MHz to this is could enough)
String rangeStr = "Hz ";

byte cursorPos = 6;

const int B_Up = A1;
const int B_Down = A0;
const int B_Left = A3;
const int B_Right = A2;
const int B_Run = A4;

int BS_Up = LOW;
int BS_Down = LOW;
int BS_Left = LOW;
int BS_Right = LOW;
int BS_Run = LOW;

int BLS_Up = LOW;
int BLS_Down = LOW;
int BLS_Left = LOW;
int BLS_Right = LOW;
int BLS_Run = LOW;

unsigned long DebounceTime = 0;
bool lastActed = false;
int changeValue = 0;
int moveCursor = 0;
bool ForceUpdate = false;

String firstRow = "Fn:Off ";
String secondRow = "      100Hz ";




void setup() {

  AD.begin();

  Serial.begin(9600);
  
  // set up the LCD's number of columns and rows:
  lcd.begin(8, 2);
  // Print a message to the LCD.
  lcd.print(firstRow);  //print left side
  lcd.setCursor(0,1);     //go to right
  lcd.print(secondRow);

  lcd.setCursor(6,0);
  lcd.cursor();
  
  pinMode(16,OUTPUT);
  DDRD = B11111111;

  pinMode(B_Up,INPUT);
  pinMode(B_Down,INPUT);
  pinMode(B_Left,INPUT);
  pinMode(B_Right,INPUT);
  pinMode(B_Run,INPUT);

  DebounceTime = millis();

  AD.setMode(0);
  
}


void loop() {
  // put your main code here, to run repeatedly:

  BS_Up = digitalRead(B_Up);
  BS_Down = digitalRead(B_Down);
  BS_Left = digitalRead(B_Left);
  BS_Right = digitalRead(B_Right);
  BS_Run = digitalRead(B_Run);

  int Rotation = 0;


  if (BS_Up != BLS_Up){
      DebounceTime = millis();
      BLS_Up = BS_Up;
    }
  if (BS_Down != BLS_Down){
      DebounceTime = millis();
      BLS_Down = BS_Down;
    }
  if (BS_Left != BLS_Left){
      DebounceTime = millis();
      BLS_Left = BS_Left;
    }
  if (BS_Right != BLS_Right){
      DebounceTime = millis();
      BLS_Right = BS_Right;
    }
  if (BS_Run != BLS_Run){
      DebounceTime = millis();
      BLS_Run = BS_Run;
    }

   String Command;
   int SerBytes = 0;
   int32_t Out = 0;
   SerBytes = Serial.available();
   if (SerBytes>0){
    SerBytes = 0;
    Command = Serial.readString();
    Out = ReadSCPI(Command);
    if (Out>0){
      Freq = Out;
    }
    if (Out<0){
      type = -Out-1;
    }
    DebounceTime = 0;
    ForceUpdate = true;
   }

  if (millis()-DebounceTime>10){
    if (lastActed == false){
      
      lastActed = true;

      if ((BS_Up==LOW)&(BS_Down==LOW)) {Rotation = 0;}
      
      if ((BS_Up==HIGH)&(BS_Down==LOW))   {changeValue =  1;}
      if ((BS_Up==LOW)&(BS_Down==HIGH)) {changeValue = -1;}
      if (BS_Left==HIGH) {moveCursor  =  1;}
      if (BS_Right==HIGH){moveCursor  = -1;}

      if ((changeValue != 0)|ForceUpdate){

        
        
        int multiplier = 1;
        if ((cursorPos == 0)|ForceUpdate){
          type = type + changeValue;
          if(type>5){type = 0;}
          if(type>4){type = 4;}
          if(type==0){firstRow="Fn:Off     ";}
          if(type==1){firstRow="Fn:Sine    ";}
          if(type==2){firstRow="Fn:Square  ";}
          if(type==3){firstRow="Fn:Square  ";}
          if(type==4){firstRow="Fn:Triangle";}
          }
        if (cursorPos == 9){
          Range = Range + changeValue;
          if(Range>3){Range = 0;}
          if(Range>2){Range = 2;}
          if(Range==0){rangeStr="mHz";}
          if(Range==1){rangeStr="Hz ";}
          if(Range==2){rangeStr="KHz";}
          }
        if ((cursorPos >= 1)&(cursorPos <= 8)){
          uint32_t multiplier = 1;
          if (cursorPos==1){multiplier = 10000000;}
          if (cursorPos==2){multiplier = 1000000;}
          if (cursorPos==3){multiplier = 100000;}
          if (cursorPos==4){multiplier = 10000;}
          if (cursorPos==5){multiplier = 1000;}
          if (cursorPos==6){multiplier = 100 ;}
          if (cursorPos==7){multiplier = 10  ;}
          if (cursorPos==8){multiplier = 1   ;}
          Freq = Freq + changeValue*multiplier;
          if (Freq<1){Freq=1;}
          if (Freq>12000000){Freq=12000000;}
          
          }

        String Padding = " ";
        if (Freq<10000000) {Padding = "  ";}
        if (Freq<1000000) {Padding = "   ";}
        if (Freq<100000) {Padding = "    ";}
        if (Freq<10000) {Padding = "     ";}
        if (Freq<1000) {Padding = "      ";}
        if (Freq<100) {Padding = "       ";}
        if (Freq<10) {Padding = "        ";}
        secondRow = Padding + String(Freq) + rangeStr;
        lcd.setCursor(0,0);
        lcd.print(firstRow);
        lcd.setCursor(0,1);
        lcd.print(secondRow);
          
        changeValue = 0;
        ForceUpdate = false;
        }
        
       if (moveCursor!=0){
        cursorPos = (cursorPos + moveCursor);
        if(cursorPos>10){cursorPos=0;}
        if(cursorPos>9){cursorPos=5;}
        moveCursor = 0;
       }

       if (BS_Run==HIGH){
        //SineFast(Freq);
       }

       static int lastType = 0;
       static uint32_t lastFreq = 0;
       if (Freq!=lastFreq)
       {
         AD.setFrequency(MD_AD9833::CHAN_0, Freq);
         lastFreq = Freq;
       }
       if (type!=lastType)
       {
         AD.setMode(type);
         lastType = type;
       }
       
    }

    
    if ( ((BS_Up==LOW) & (BS_Down==LOW)) & ((BS_Left==LOW) & (BS_Right==LOW))){lastActed = false;}
  }

 if(cursorPos==0){lcd.setCursor(3,0);}
 if(cursorPos>0){
  lcd.setCursor(cursorPos,1);
  }
  
}

int32_t ReadSCPI(String Command){
  //Takes a string as argument, format scpi command
  //outputs either a frequency as a positive int32, or
  //negative value encoded as the 5 options off, sinewave, squarewave1,squarewave2,triangle wave; 1,2,3,4,5
  int32_t Out = 0;

  if (Command.substring(0,4)=="FREQ"){
    Out = Command.substring(5).toInt();
    return Out;
  }
  if (Command.substring(0,4)=="WAVE"){
    Out = Command.substring(5).toInt();
    Out = -Out;
    return Out;
  }
  return 0;
}
