prologues:=3;

% units
u = 1cm;
xp :=3; yp := 3; zp := 5;

% reference frame points
pair O,Xr,Yr,Zr;
O = (0,0);
Xr = (-.7,-.7) scaled u;
Yr = (1,0) scaled u;
Zr = (0,1) scaled u;

% drawing the reference frame
vardef frameXYZ(expr s) =
  drawarrow O--Xr scaled s;
  drawarrow O--Yr scaled s;
  drawarrow O--Zr scaled s;
  label.llft(btex $x$ etex scaled 1.25, (Xr scaled s));
  label.rt(btex $y$ etex scaled 1.25, (Yr scaled s));
  label.top(btex $z$ etex scaled 1.25, (Zr scaled s));
enddef;

% 3d->2d projection
vardef project(expr x,y,z) = x*Xr + y*Yr + z*Zr enddef;

filenametemplate "spherical_coordinates.eps";

beginfig(1)

  frameXYZ(4);

  path theta, phi;
  pair vec, vec_proj;

  vec = project(2, 3, 5);
  vec_proj = project(2, 3, 0);

  draw vec withpen pencircle scaled 2bp;
  draw vec_proj withpen pencircle scaled 2bp;
  draw (0, 0)--vec;
  label.ulft(btex $r$ etex, 3/5[(0,0), vec]);
  draw (0, 0)--vec_proj dashed evenly;
  draw vec--vec_proj dashed evenly;

  theta = (0, 1.5*u) {dir 0} .. 1.5*u*vec/abs(vec) {dir (angle(vec) - 90)};
  draw theta;
  draw theta scaled 0.95;
  label.top(btex $\theta$ etex, point .5 of theta);

  phi = u*vec_proj/abs(vec_proj) {dir (angle(vec_proj) - 90)} .. project(1, 0, 0) {dir (angle(project(1, 0, 0)) - 90)} ;
  draw phi;
  label.bot(btex $\varphi$ etex, point .5 of phi);

endfig;

vardef drawstrip(expr phi) =

  vardef moebius(expr t, v) =
    (1 + v*cosd(t)/100)*cosd(2*t) * (-cosd(phi), sind(phi)) * u +
    (1 + v*cosd(t)/100)*sind(2*t) * (1,0) * u +
    v*sind(t)/100 * (0,1) * u
  enddef;

  for i = -20 step 1 until 160:
    for j = -50 step 2 until 49:
      path p;
      numeric c[];
      p = moebius(i,j) -- moebius(i+1,j) -- moebius(i+1,j+2) -- moebius(i,j+2) -- cycle;
      c1 := abs(j+1)/100;
      c2 := abs(i+1)/180;
      fill p scaled 2 withcolor (red * c2 + green*(1 - c1) + blue * c1);
      draw p scaled 2 withcolor white * 0.3;
    endfor;
  endfor;

enddef;

filenametemplate "moebius-35deg.eps";
beginfig(2)

  drawstrip(35);

endfig;

filenametemplate "moebius-65deg.eps";
beginfig(3)

  drawstrip(65);

endfig;
end
