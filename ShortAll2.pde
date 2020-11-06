Ring[] rings;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.TimeZone;

import java.awt.event.MouseWheelEvent;
import java.awt.event.MouseWheelListener;

import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PVector;

PanZoomController panZoomController;

float scale = 1;
float xPan = 720;
float yPan = 450;
boolean zoomIn = false;
boolean zoomOut = false;
boolean panUp = false;
boolean panDown = false;
boolean panLeft = false;
boolean panRight = false;
float panSpeed = 5;
float zoomSpeed = 1.04;

float pulse = 0;
int c = 100;
Table table;
float size=0;
Bubble[] bubbles;
String[] labels = new String[850];
Ring r,pr;
Bubble oneB;
Bunch b;
PImage bg;
float count = 0;
int pointCounter = 0;
int bunchCounter = 0;
int bunchSum = 0;

PFont Font1;
PFont Font2;
int counter2016=0;
int counter2017=0;
int counter2018=0;
int counter2019=0;
int counter2020=0;
int counter2015=0;

float[] XAll;
float[] YAll;
float[] angleAll;
float[] angleCounterAll;
int[] articleMonth;
float[] circleNumber;
float[] circleNumber2;
MonthArticles[] eachMonth;
MonthArticles[] eachMonth2;
int[] maximumAngleNow;


int globalCounter = 0;
int globalCount = 0;
int globalX = 0;
int[] bunch;
int[] linksIndex;
int savedTime;
int totalTime = 700;

PGraphics pg;

void setup(){
  size(1099,1099);
  pg = createGraphics(1099, 1099);
  savedTime = millis();
  Font1 = createFont("Arial Bold", 18);
  Font2 = createFont("Arial Bold", 10);
  loadData();
  bg = loadImage("C:/Users/Abdul Sittar/Downloads/background4.PNG");
  
  panZoomController = new PanZoomController(this);
  
  for(int i = 1; i <= 72; i++){
  
  if(i<=12){         labels[i-1]="01-"+i+"-2015"; }
    else if(i<=24) { labels[i-1]="01-"+(i-12)+"-2016"; }
    else if(i<=36) { labels[i-1]="01-"+(i-24)+"-2017"; }
    else if(i<=48) { labels[i-1]="01-"+(i-36)+"-2018"; }
    else if(i<=60) { labels[i-1]="01-"+(i-48)+"-2019"; }
    else if(i<=72) { labels[i-1]="01-"+(i-60)+"-2020"; }
  
}
   background(bg);
   fill(#FC0015);
   textFont(Font1); 
   text("English",10,20);
   fill(#00D2FA);
   textFont(Font1); 
   text("German",10,40);
   fill(#000EFF);
   textFont(Font1); 
   text("Portuguese",10,60);
   fill(#F6FF00);
   textFont(Font1); 
   text("Spanish",10,80);
   fill(#FE00FF);
   textFont(Font1); 
   text("Slovene",10,100);
   //fill(#F29382);
   //textFont(Font1); 
   //text("01/01/2015 - 01/01/2020",600,20);
   
}
 //<>// //<>// //<>//
void draw(){
  
    PVector pan = panZoomController.getPan();
    pushMatrix();
    translate(pan.x, pan.y);
    scale(panZoomController.getScale());
  
  int passedTime = millis() - savedTime;
  if (passedTime > totalTime) {

    if(pointCounter <= bubbles.length){
       pointCounter = pointCounter +1; 
       
    } else {
      noLoop();
    
  }
   if(bunchCounter < bunch.length){
   try {
     //print("drawn\n");
     //print(bunch[bunchCounter]);
     if(bunchCounter == 0){
       b = new Bunch(eachMonth[bunchCounter].articles);
     }else{
       b = new Bunch(eachMonth[bunchCounter].articles);
     }
   if(oneB.over){
     oneB.mouseOver();
   }}
   catch (Exception e) {
    //print(e);
   }
    bunchSum = bunchSum + bunch[bunchCounter];
    bunchCounter = bunchCounter + 1; 
    totalTime = totalTime + 900;
    }
 } else {
       
    }
    //23//60//114//150//195//235//278//322//364
    
 if(count < 72){
      r = new Ring(int(width/2), int(height/2), 0.000000001, size, labels[(int)count]);
      r.display();
  }
  count += 0.030;
  if(count >= 820){
    //noLoop();
  }
  size = size + 0.35;
 
  if(size > height){
    //size = 0; 
  }  
  
  popMatrix();
  
}

void keyPressed() {
    panZoomController.keyPressed();
 }
 void mouseDragged() {
   panZoomController.mouseDragged();
 }
 void mouseWheel(MouseEvent event) {
   panZoomController.mouseWheel(event.getCount());
 }


void loadData() { 
  
   int counterInMonths = 0;
  
  table = loadTable("C:/AbdulSittar/Slovenia/Courses/FinalDS-July/SPEdgesAllAnimation.csv", "header");
  circleNumber = new float[72];
  
  for(int a=0;a<72;a++)
  {
    circleNumber[a]=0;
  }
  
  bubbles = new Bubble[table.getRowCount()];
  eachMonth = new MonthArticles[72];
  maximumAngleNow = new int[72];
  linksIndex = new int[table.getRowCount()];
  
  for (int i = 0; i<table.getRowCount(); i++) {
    
    // Iterate over all the rows in a table.
    TableRow row = table.getRow(i);
    String stime = row.getString("from-time");
    String ttime = row.getString("to-time");
    // Make a Bubble object out of the data from each row.
    
    try {
    
    Date sdate = new SimpleDateFormat("YYYY/mm/dd-HH:MM:SS-").parse(stime);
    Date tdate = new SimpleDateFormat("YYYY/mm/dd-HH:MM:SS-").parse(ttime);
    //Date sdate = new SimpleDateFormat("mm/dd/YYYY-HH:MM:SS-").parse(stime);
    //Date tdate = new SimpleDateFormat("mm/dd/YYYY-HH:MM:SS-").parse(ttime);    
    
    String[] parts = stime.split("-");
    String[] date = parts[0].split("/");
    int year  =  Integer.parseInt(date[0]);
    int month =  Integer.parseInt(date[1]);
    int day   = Integer.parseInt(date[2]);
    //print(year);
    
    //print(month);print("\t");print(sdate); print("\n");
    Calendar calendar = Calendar.getInstance();
    calendar.setTime(sdate);
    //print(calendar.get(Calendar.YEAR));
    //if(calendar.get(Calendar.YEAR) == 2014){
      if(year == 2015){
      
      circleNumber[month] = circleNumber[month]+1; 
      counterInMonths += 1;
      
    }else if(year == 2016){
      
      //print("2016");
      circleNumber[month+12] = circleNumber[month+12]+1;
      counterInMonths += 1;
      
    }else if(year == 2017){
      //print("2017 here comes");
      circleNumber[month+24] = circleNumber[month+24]+1;
      counterInMonths += 1;
      
    }else if(year == 2018){
      
      circleNumber[month+36] = circleNumber[month+36]+1;
      counterInMonths += 1;
      
    }else if(year == 2019){
      
      circleNumber[month+48] = circleNumber[month+48]+1;
      counterInMonths += 1;
      
    }else if(year == 2020){
      
      circleNumber[month+60] = circleNumber[month+60]+1;
      counterInMonths += 1;
    }

    } catch (Exception e) {
      //print("article per month ");
      //print(e);
      //print("\n");
    }
  }

   double angle = 0;
   articleMonth = new  int[counterInMonths];
   
   int doubleCounter = 0;
   int angleCounter = 0;
    
    int numberBunch=0;
    for(int j=0; j<circleNumber.length; j++){
      //print("\n");
      //print(circleNumber[j]);
      maximumAngleNow[j] = 8;
      numberBunch = numberBunch + 1;
    }  
    
    bunch = new int[numberBunch];
    for(int j=0; j<circleNumber.length; j++){
      maximumAngleNow[j] = 8;
      if((int) circleNumber[j] > 0){
        bunch[j] = (int) circleNumber[j];
        eachMonth[j] = new MonthArticles(bunch[j]);
        if(eachMonth[j].articles != null){
            //print(eachMonth[j].articles.length);
            //print(" Not Null ");
        }
      } /*else {
        
        bunch[j] = 0;
        eachMonth[j] = new MonthArticles(bunch[j]);
        print(eachMonth[j].articles.length);
        print(" Not Null ");
      }*/
    }
    
    for (int i = 0; i<table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    String source = row.getString("from");
    String target = row.getString("to");
    String pub1 = row.getString("from-pub-uri");
    String pub2 = row.getString("to-pub-uri");
    float weight = row.getFloat("weight");
    String stime = row.getString("from-time");
    String ttime = row.getString("to-time");
    
    try {
      //Date sdate = new SimpleDateFormat("mm/dd/YYYY-HH:MM:SS-").parse(stime);
      //Date tdate = new SimpleDateFormat("mm/dd/YYYY-HH:MM:SS-").parse(ttime); 
      Date sdate = new SimpleDateFormat("YYYY/mm/dd-HH:MM:SS-").parse(stime);
      Date tdate = new SimpleDateFormat("YYYY/mm/dd-HH:MM:SS-").parse(ttime);
      String[] parts = stime.split("-");
      String[] date = parts[0].split("/");
      int year  =  Integer.parseInt(date[0]);
      int month =  Integer.parseInt(date[1]);
      int day   =  Integer.parseInt(date[2]);
    
      Calendar calendar = Calendar.getInstance();
      calendar.setTime(sdate);
      if(year == 2015){
      
      MonthArticles m = eachMonth[month];
      //print(m.articles.length);
      m.addArticle(new Bubble(0, 0,0,0, weight+6, source, target, pub1, pub2, sdate, tdate, 0, 0, 0, 0));
      //print(" **** added");
      
      } else if(year == 2016){
      
      MonthArticles m = eachMonth[month+12];
      //print(m.articles.length);
      m.addArticle(new Bubble(0, 0,0,0, weight+6, source, target, pub1, pub2, sdate, tdate, 0, 0, 0, 0));
      //print(" **** added");
      
     } else if(year == 2017){
      
      MonthArticles m = eachMonth[month+24];
      //print(m.articles.length);
      m.addArticle(new Bubble(0, 0,0,0,  weight+6, source, target, pub1, pub2, sdate, tdate, 0, 0, 0, 0));
      //print(" **** added 2017");
      
     } else if(year == 2018){
      
      MonthArticles m = eachMonth[month+36];
      //print(m.articles.length);
      m.addArticle(new Bubble(0, 0,0,0,  weight+6, source, target, pub1, pub2, sdate, tdate, 0, 0, 0, 0));
      //print(" **** added");
      
     } else if(year == 2019){
      
      MonthArticles m = eachMonth[month+48];
      //print(m.articles.length);
      m.addArticle(new Bubble(0, 0,0,0, weight+6, source, target, pub1, pub2, sdate, tdate, 0, 0, 0, 0));
      //print(" **** added");
      
     } else if(year == 2020){
      
      MonthArticles m = eachMonth[month+60];
      //print(m.articles.length);
      m.addArticle(new Bubble(0, 0,0,0, weight+6, source, target, pub1, pub2, sdate, tdate, 0, 0, 0, 0));
      //print(" **** added");
    }
      
    } catch (Exception e) {
      //print(" article per month ");
      //print(e);
      //print("\n");
    }
  }
  
  int zCount = 0;
  for(int i =0; i< eachMonth.length; i++){
    MonthArticles m = eachMonth[i];
    if(m != null){
    if(m.articles.length > 0){
    zCount += 1; 
    }
  }}
    
  eachMonth2 = new MonthArticles[zCount];
  circleNumber2 = new float[zCount];
  
   int pc = 0;  
   for(int i =0; i< eachMonth.length; i++)
   {
      MonthArticles m = eachMonth[i];
      if(m != null)
         if(m.articles.length > 0)
           { 
             eachMonth2[pc] = m;
             circleNumber2[pc] = circleNumber[i]; 
             pc += 1;
         }
    }

    //all circles
    for(int j=0; j<zCount; j++){
      
      //initialize outer Found 
      boolean[] outerFound= new boolean[table.getRowCount()];
       for(int a=0; a<table.getRowCount(); a++){
         outerFound[a] = false;
       }
       //initialize inner Found
        int ch=0;
         //first...second....third....fourth..... circle
         
         for(int k=0; k<circleNumber2[j]; k++){     
                 Bubble first = eachMonth2[j].articles[k];  
                 boolean[] innerFound = new boolean[(int)circleNumber2[j]];
                 angleCounter = 13 * k;
                 //all circle
                 ch = j+1;
                 if(j == zCount-1){
                     ch = zCount-1;
                 }
                 angle = maximumAngleNow[j];
                 for(int m=j; m<=ch; m++){
                   for(int a=0; a<circleNumber2[j]; a++){
                   innerFound[a] = false;
                     }
                    
                    for(int n=0; n<circleNumber2[m]; n++){
                         Bubble second = eachMonth2[m].articles[n];
                         
                         if(first.target.equals(second.source) && first.weight > 0.7){
                                    if(m==j){
                                      //if(innerFound[n] == false){
                                         //innerFound[n] = true;
                                         //(360.0/circleNumber[m]);
                                         if(first.drawn == false){
                                           angle = angle + 8;
                                           angleCounter = (m+1)*8;
                                           first.drawn = true;
                                           first.x = (float) ((width/2-12)+angleCounter * Math.cos(Math.toRadians(angle)));
                                           first.y = (float) ((height/2-4)+angleCounter * Math.sin(Math.toRadians(angle)));
                                           first.angle = (float)angle;
                                           first.diffAngle = (float)angleCounter;
                                         }
                                         doubleCounter += 1;
                                         if(second.drawn == false){
                                           //angleCounter = (m+1)*6;
                                            second.drawn = true;
                                            second.x = (float) ((width/2-12)+first.diffAngle * Math.cos(Math.toRadians(first.angle+8)));
                                            second.y = (float) ((height/2-4)+first.diffAngle * Math.sin(Math.toRadians(first.angle+8)));
                                            second.angle = first.angle;
                                            second.diffAngle = first.diffAngle;
                                            //first.angle = first.angle+8;
                                           
                                         }
                                         doubleCounter += 1;
                                         if(first.innerComleted == false){
                                           //print("distance "+dist(first.x, first.y, second.x, second.y));
                                           if(dist(first.x, first.y, second.x, second.y) < 100){
                                               first.innerComleted = true;
                                               first.lxi = second.x;
                                               first.lyi = second.y;
                                         }
                                         }
                                         break;
                                    //  }
                                    } else {
                                         
                                      //if(outerFound[n] == false){
                                        // outerFound[n] = true;
                                        
                                         //(360.0/circleNumber[m]);
                                         if(first.drawn == false){
                                           angle = angle+8;
                                           angleCounter = (m+1)*8;
                                           first.drawn = true;
                                           first.x = (float) ((width/2-12)+angleCounter * Math.cos(Math.toRadians(angle)));
                                           first.y = (float) ((height/2-4)+angleCounter * Math.sin(Math.toRadians(angle)));
                                           first.angle = (float)angle;
                                           first.diffAngle = (float)angleCounter;
                                         }
                                         
                                         doubleCounter += 1;
                                         if(second.drawn == false){
                                            //angleCounter = (m+1)*6;
                                            second.drawn = true;
                                            second.x = (float)((width/2-12)+8+first.diffAngle * Math.cos(Math.toRadians(first.angle+8)));
                                            second.y = (float)((height/2-4)+8+first.diffAngle * Math.sin(Math.toRadians(first.angle+8)));
                                            second.angle = first.angle;
                                            second.diffAngle = first.diffAngle;
                                         }
                                         doubleCounter += 1;
                                         if(first.outerComleted == false){
                                           if(dist(first.x, first.y, second.x, second.y) < 10){
                                               first.outerComleted = true;
                                               first.lxo = second.x;
                                               first.lyo = second.y;
                                           }
                                         }
                                         break;
                                         //}
                              }
                         }
                         
                       }
                       maximumAngleNow[j] = (int)angle;
                     }
         }
                   //angleCounter += 13;
    }
    
    
    /*for(int j=0; j<circleNumber2.length; j++){
        for(int k=0; k<circleNumber2[j]; k++){     
            Bubble first = eachMonth2[j].articles[k];  
            if(first.drawn == false){
               angle = (k+1)*8;//(360.0/circleNumber[j]);
               angleCounter = (j+1)*8;
               first.drawn = true;
               first.x = (float) ((width/2-12)+angleCounter * Math.cos(Math.toRadians(angle)));
               first.y = (float) ((height/2-4)+angleCounter * Math.sin(Math.toRadians(angle)));
               first.angle = (float)angle;
               first.diffAngle = (float)angleCounter;
               }
        }
    }*/
}

class Ring {
  
  float speed;
  float offset;
  float x;
  float y;
  float size;
  String t;
  Boolean isVisible;
  PShape p;
  PShape pt;
  
  Ring(float x, float y, float s, float o, String te){
    this.x = x;
    this.y = y;
    this.speed = s;
    this.offset = o;
    this.t = te;
    this.isVisible =  true;
    this.size = -2;
  }
  
  void removeIt(Ring pr){
    //text("",);
  }
  
  void display(){
    
    if (size > height+50){
      size = -2;
    } else {
      size += offset;
    }
    p = createShape(ELLIPSE,x,y,size,size);
    p.setStroke(2);
    p.setFill(color(#F29382, 1));
    //shape(p);
    ////pt = createShape(Text,x,y,size,size);
    fill(0);
    rect(x+400,y-520,100, 30);
    fill(255);
    textFont(Font1); 
    text(this.t,x+400,y-500);
  }
}

class Bunch {
 Bubble[] objects;
 Bunch(Bubble[] objects) {
    this.objects = objects;
    for(int k=0; k<=objects.length; k++){
        Bubble bData = objects[k];
      //try {
       // oneB = new Bubble(bData.x, bData.y, bData.weight, bData.source, bData.target, bData.pub1,bData.pub2, bData.stime, bData.ttime, bData.lxi, bData.lyi, bData.lxo, bData.lyo);  
        bData.display();
     // }
     //catch (Exception e) {
     //print(e);
      //}
    }
  } 
}

public class Bubble {
  float x, y;
  float weight;
  String source;
  String target;
  String pub1;
  String pub2;
  Date stime;
  Date ttime;
  boolean over = false;
  PShape dot;
  boolean anyConnection = false;
  float lxi, lyi, lxo, lyo, angle, diffAngle;
  boolean innerComleted = false;
  boolean outerComleted = false;
  boolean drawn = false;
 
  
  // Create the Bubble
  Bubble(float tempX, float tempY, float angle, float diffAngle,float tempD, String source, String target,String pub1,String pub2, Date stimes, Date ttimet, float lx2, float ly2, float lx3, float ly3) {
    this.x = tempX;
    this.y = tempY;
    this.angle = angle;
    this.diffAngle = diffAngle;
    this.weight = tempD;
    this.source = source;
    this.target = target;
    this.pub1 = pub1;
    this.pub2 = pub2;
    this.stime = stimes;
    this.ttime = ttimet;
    this.lxi = lx2;
    this.lyi = ly2;
    this.lxo = lx3;
    this.lyo = ly3;
    this.innerComleted = false;
    this.outerComleted = false;
    this.drawn = false;
    
  }
  
  Bubble(){
    this.x = 0;
    this.y = 0;
    this.angle = 0;
    this.diffAngle=0;
    this.weight = 0;
    this.source = "";
    this.target = "";
    this.pub1 = "";
    this.pub2 = "";
    this.stime = new Date();
    this.ttime = new Date();
    this.lxi = -1;
    this.lyi = -1;
    this.lxo = -1;
    this.lyo = -1;
    this.innerComleted = false;
    this.outerComleted = false;
    this.drawn = false;
  }
  
  // Checking if mouse is over the bubble
  void rollover(float px, float py) {
    float d = dist(px, py, x, y);
    if (d<weight/2) {
      over = true; 
    } else {
      over = false;
    }
  }
  
  void mouseOver() {
    background(50,80,140);
  }
  
  void display() {
     beginShape();
     PShape doto = createShape(ELLIPSE,x, y, weight, weight);
     if(this.source.contains("English")){doto.setFill(#FC0015);}
      else if(this.source.contains("German")){doto.setFill(#00D2FA);}
      else if(this.source.contains("Spanish")){doto.setFill(#F6FF00);}
      else if(this.source.contains("Por")){doto.setFill(#000EFF);}
      else if(this.source.contains("Slovene")){doto.setFill(#FE00FF);}
      shape(doto);
      endShape();
    
    Boolean alreadyDrawn = false;
    if(lxi > 0 && lyi > 0){
     beginShape();
     PShape l1 = createShape(LINE,x,y, lxi, lyi);
     l1.setStroke(255);
     shape(l1);
     endShape();
     globalCounter += 1;
     print(source);
     print(target);
     print("\n");
     if(globalCounter % 10 == 0){
     float yValue = 500+globalCounter-5 ;
     //fill(255);
     //textFont(Font2); 
     //text(source,15+globalX,yValue-380);
     alreadyDrawn = true;
     if(globalCounter % 970 == 0){
        globalCounter = 1; 
        globalCount += 1;
        globalX = 70*globalCount;
     }
     }
    }
    
    if(lxo > 0 && lyo > 0){
      globalCounter += 1;
     beginShape();
     PShape l2 = createShape(LINE,x,y, lxo, lyo);
     l2.setStroke(255);
     shape(l2);
     endShape();
     print(source);
     print(target);
     print("\n");
     if(globalCounter % 10 == 0){
     if(alreadyDrawn == false){
         float yValue = 500+globalCounter;//(float)(Math.random() * (200 - 30 + 1) + 30);
         //yValue = -1 * yValue;
         //pushMatrix();
    //  fill(255);
    // textFont(Font2); 
         //translate(50+globalCounter,yValue);
         //rotate(-HALF_PI);
    //     text(source,15+globalX,yValue-380);
         //popMatrix();
     }
     }
    }
  }
}

class MonthArticles {
  public Bubble[] articles;
  int top = 0;
  int total= 0;
  
  // Create the Bubble
 public MonthArticles(int total) {
    //print(total);
    if(this.articles == null){
       this.articles = new Bubble[total];
       this.top = 0;
       this.total = total;
       for(int i = 0; i< total; i++){
         this.articles[i] = new Bubble();
       }
    } else {
      //print("already initialized");
    }
  }
  
  public void addArticle(Bubble b){
    if(this.articles == null){
        this.articles = new Bubble[this.total];
    }
     this.articles[this.top]=b;
     this.top += 1;   
  }
}



public class PanZoomController {

  private final PVector DIR_UP = new PVector(0, -1);
  private final PVector DIR_DOWN = new PVector(0, 1);
  private final PVector DIR_LEFT = new PVector(-1, 0);
  private final PVector DIR_RIGHT = new PVector(1, 0);

  private float panVelocity = 40;
  private float scaleVelocity = 0.01f;
  private float minLogScale = -5;
  private float maxLogScale = 5;

  private float logScale = 0;
  private float scale = 1;
  private PVector pan = new PVector();

  private PApplet p;

  public PanZoomController(PApplet p) {
    this.p = p;
  }

  public void mouseDragged() {
    PVector mouse = new PVector(p.mouseX, p.mouseY);
    PVector pmouse = new PVector(p.pmouseX, p.pmouseY);
    pan.add(PVector.sub(mouse, pmouse));
  }

  public void keyPressed() {
    if (p.key == PConstants.CODED) {
      switch (p.keyCode) {
      case PApplet.UP:
        moveByKey(DIR_UP);
        break;
      case PApplet.DOWN:
        moveByKey(DIR_DOWN);
        break;
      case PApplet.LEFT:
        moveByKey(DIR_LEFT);
        break;
      case PApplet.RIGHT:
        moveByKey(DIR_RIGHT);
        break;
      }
    }
  }

  public void mouseWheel(int step) {
    logScale = PApplet.constrain(logScale + step * scaleVelocity,
      minLogScale,
      maxLogScale);
    float prevScale = scale;
    scale = (float) Math.pow(2, logScale);

    PVector mouse = new PVector(p.mouseX, p.mouseY);
    pan = PVector.add(mouse,
      PVector.mult(PVector.sub(pan, mouse), scale / prevScale));
  }

  private void moveByKey(PVector direction) {
    pan.add(PVector.mult(direction, panVelocity));
  }

  public float getScale() {
    return scale;
  }

  public void setScale(float scale) {
    this.scale = scale;
  }

  public PVector getPan() {
    return pan;
  }

  public void setPan(PVector pan) {
    this.pan = pan;
  }

  public void setPanVelocity(float panVelocity) {
    this.panVelocity = panVelocity;
  }

  public void setScaleVelocity(float scaleVelocity) {
    this.scaleVelocity = scaleVelocity;
  }

  public void setMinLogScale(float minLogScale) {
    this.minLogScale = minLogScale;
  }

  public void setMaxLogScale(float maxLogScale) {
    this.maxLogScale = maxLogScale;
  }
}
