public class cube{
PImage m;
int x;
int y;
boolean IsRender = true;
boolean IsTint = false;
int ID;
int BID;
int z;
int dist = scale*2;
public cube(int BlockID,int x, int y, int z){
ID = BlockID;
this.x = x;
this.y = y;
this.z = z;
m = loadImage("/Textures/"+ ID + ".PNG");
LoadedBlocks.add(new Integer[]{this.x,this.y,this.z});
BID = LoadedBlocks.size();
}
public void render(int scale){
  IsTint = false;
   IsRender = false;
    if (GetDistance(float(x),float(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist &&GetDist(x,z,player.x,player.z)<scale*dist){
    IsRender = true;
    }else{
    if(IsRotating&& GetDist(x,z,player.x,player.z)<scale*50){
      IsRender = true;
      IsTint = true;
    }
    }
    
  if (IsRender){
  IsIntersecting();
 beginShape(QUADS);
 if(IsTint){
 tint(50);
 }else{
   tint(255,255);
 }
  texture(m);
  vertex(-scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 0);
  vertex( scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y,  scale+z, 0, 1);
  vertex( scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y, -scale+z, 1, 0);
  vertex(-scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y, -scale+z, 0, 1);
  //top face. always show
  /*vertex(-scale+x,  scale+y,  scale+z, 0, 0);
  vertex( scale+x,  scale+y, scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);*/
  //bottom face. never show
  vertex(-scale+x, -scale+y, -scale+z, 0, 0);
  vertex( scale+x, -scale+y, -scale+z, 1, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 1);
  vertex(-scale+x, -scale+y,  scale+z, 0, 1);
  vertex( scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y, -scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y,  scale+z, 0, 1);
  vertex(-scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y,  scale+z, 1, 0);
  vertex(-scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);
  endShape();
  }
}
public void IsIntersecting(){
  if(BID != 1){
  if(GetDistance(float(x),float(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist &&GetDist(x,z,player.x,player.z)<scale*dist){//lies on the line of intersection
    crossSection();
  }
  }
}
public void crossSection(){
  PShape cubeobj;
  int k =0;
  ArrayList<Float[]> m = new ArrayList<Float[]>();
   ArrayList<Float> j = new ArrayList<Float>();
  PVector a = new PVector(-scale+x, -scale+z);
  PVector b = new PVector( scale+x, -scale+z);
  PVector c = new PVector( scale+x, scale+z);
  PVector d = new PVector(-scale+x, scale+z);
m.add(compareIntersection(a,b));
m.add(compareIntersection(b,c));
m.add(compareIntersection(c,d));
m.add(compareIntersection(d,a));

cubeobj = createShape();
cubeobj.beginShape(); 
for(int i = 0; i < m.size(); i++){
if(m.get(i).length > 1){
  k++;
cubeobj.vertex(m.get(i)[1],m.get(i)[2]);
j.add(m.get(i)[1]);
j.add(m.get(i)[2]);
}
}

if( k > 1){
 /* println(player.shiftX + "/" +player.shiftZ + "/" + k);
  if(player.shiftZ == 0){
  C2Dplane.add(new flatObj((j.get(0)-player.x)/player.shiftX,float(-scale+y),(j.get(3)-player.x),scale+y,cubeobj));
  }else{
   if(player.shiftX == 0){
   C2Dplane.add(new flatObj((j.get(0)-player.x),float(-scale+y),(j.get(1)-player.z)/player.shiftZ,scale+y,cubeobj));
   }else{
     C2Dplane.add(new flatObj((j.get(0)-player.x)/player.shiftX,float(-scale+y),(j.get(1)-player.z)/player.shiftZ,scale+y,cubeobj));
   }
  }*/
}
}
public Float[] compareIntersection(PVector A, PVector B){
  float eq = 0;
  float x;
  float z;
  Float[] res = new Float[] {0.0};
  float IntersectionState = 0;
  if(A.y == B.y &&B.y == player.z){
   IntersectionState =2;
  }else{
  if(A.x == B.x &&B.x == player.x){
   IntersectionState =3;
  }else{
    if(player.shiftX == 0){
      IntersectionState = 4;
      if(player.x > min(A.x,B.x)&& player.x < max(A.x,B.x)){
      }
    }else{
        if(player.shiftZ == 0){
        
        }else{
        
        }
    }
    
    }
  }
  
  
  return res;
}
public float GetDistance(float x, float y, float x1, float y1, float x2, float y2) {
    float A = x - x1;
    float B = y - y1;
    float C = x2 - x1;
    float D = y2 - y1;
    float E = -D;
    float F = C;
    float dot = A * E + B * F;
    float len_sq = E * E + F * F;
    return dot* dot/ len_sq;
  }
public float GetDist(float x, float y, float x1,float y1){
  return sqrt((x-x1)*(x-x1)+(y-y1)*(y-y1));
}
}