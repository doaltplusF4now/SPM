
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import javax.swing.ImageIcon;
import ddf.minim.ugens.*;
SoundManager GameAudio = new SoundManager();
public int CameraState;
ArrayList<ArrayList<Integer>>currentLevel = new ArrayList<ArrayList<Integer>>();
ArrayList<cube>IBlock = new ArrayList<cube>();
String[] Levelreader;
Minim minim;
AudioPlayer player;
float ang = 0;
int frames;
boolean IsLoaded = false;
float eyeX,eyeY,eyeZ;
int RotationState = 0;
int scale = 20;
boolean CurrentlyLoading = false;
float d = 400;
ImageIcon titlebaricon;
boolean IsRotating = false;
ArrayList<Integer[]> LoadedBlocks = new ArrayList<Integer[]>();
float foucusX,foucusY,foucusZ,postfoucusX,postfoucusY,postfoucusZ;
levelLoader load = new levelLoader();
/*PImage icon = loadImage("icon.PNG");
surface.setIcon(icon);*/
void setup(){
  IBlock.clear();
size(1200, 900, P3D);
minim = new Minim(this);
GameAudio.play("pink floyd","A");
//GameAudio.play("pink floyed","A");
changeAppTitle("SPM//I like potatoes");
titlebaricon = new ImageIcon(loadBytes("favicon.ico"));
eyeX = width/2;

eyeY = height/2- scale*15;

eyeZ = d;
foucusX = width/2;
foucusY = height/2;
foucusZ = 0;
postfoucusX = width/2;
postfoucusY = height/2;
postfoucusZ = 0;
}
void draw(){
frames++;
renderFrame();
rotationTransition();
}
void renderFrame(){
if(IsLoaded == false){
  load();
}else{
beginCamera();
background(0);
noStroke();
lights();
editCam(0);
camera(postfoucusX,postfoucusY,postfoucusZ,foucusX,foucusY,foucusZ,0,1,0);
ortho(-width/4, width/4, -height/4, height/4);
if(IsLoaded ==false){
}
Renderscene();
endCamera();
}
}
public void load(){
  if(CurrentlyLoading == false){
  CurrentlyLoading = true;
  load.StartLoad(5,5,5);
  frame.setIconImage(titlebaricon.getImage());
  }else{
  load.LoadUpdate();
  }
}
public void editCam(float fraction){
 UpdateAngle();
  postfoucusX = foucusX*fraction+eyeX*(1-fraction);
 postfoucusY = foucusY*fraction+eyeY*(1-fraction);
 postfoucusZ = foucusZ*fraction+eyeZ*(1-fraction);
 
}
public void Renderscene(){
for (int i = 0; i < IBlock.size() ; i++){
IBlock.get(i).render(scale);
}
}
public AudioPlayer getSound(String m){
  player = minim.loadFile(m);
  return player;
}
void lol (int levelID){
    String[]Levelreader = loadStrings(levelID +"LDATA"+".txt");
    for (int i = 0; i < Levelreader.length ; i++ ){
    
    }
  }
void rotationTransition(){
if(IsRotating == true && (!(ang%90 == 0))){
ang+=2;
if (ang%90 == 0){
RotationState++;
}
}else{
IsRotating = false;
RotationState %= 4;
}
 UpdateAngle();
}
void UpdateAngle() {
  if (ang>=360){
    ang=0;
  }
  eyeX = (width/2)-d*(sin(radians(ang)));
  eyeZ = d*cos(radians(ang));
}
void keyPressed(){
  if (keyCode == ' ' && IsRotating == false){
    IsRotating = true;
    ang+=2;
  }
}
void changeAppTitle(String title) {
  surface.setTitle(title);
}