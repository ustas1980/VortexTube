unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLScene, GLCoordinates, GLObjects, GLWin32Viewer, GLCrossPlatform,
  BaseClasses, GLGeomObjects,
  GLColor, GLGui, GLWindows, GLExtrusion, ExtCtrls, StdCtrls,
  Tests, MathUtils, Unit2, Buttons, GLHUDObjects, GLGraph, GLBitmapFont, Menus,
  GLSpaceText, GLMultiPolygon,
  Math;

type
  TForm1 = class(TForm)
    GLSceneViewer1: TGLSceneViewer;
    GLScene1: TGLScene;
    GLCamera1: TGLCamera;
    GLBaseControl1: TGLBaseControl;
    GLDummyCube1: TGLDummyCube;
    GLPipe1: TGLPipe;
    DiscreteRoot: TGLBaseControl;
    GLLightSource1: TGLLightSource;
    CheckBox1: TCheckBox;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    btnCountSpeed: TButton;
    edSpeedX: TEdit;
    edSpeedY: TEdit;
    Label1: TLabel;
    edSpeedZ: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnViewLeft: TSpeedButton;
    btnViewRight: TSpeedButton;
    Label5: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    btnFlowLine: TButton;
    edFlowLineX: TEdit;
    edFlowLineY: TEdit;
    edFlowLineZ: TEdit;
    edFlowLineLength: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    edFlowLineStep: TEdit;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edTubeLength: TEdit;
    edTubeHeight: TEdit;
    edSpeed: TEdit;
    edRectCount: TEdit;
    edHeightRibsCount: TEdit;
    btnSaveParams: TButton;
    btnViewUp: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Label17: TLabel;
    FreeVortexesRoot: TGLBaseControl;
    TestRoot: TGLBaseControl;
    GroupBox4: TGroupBox;
    Label20: TLabel;
    edStep: TEdit;
    btnStart: TButton;
    btnStop: TButton;
    btnStep: TButton;
    lbModelStep: TLabel;
    lbModelTime: TLabel;
    lbH: TLabel;
    cbShowTube: TCheckBox;
    AxesRoot: TGLBaseControl;
    AxesDummyCube: TGLDummyCube;
    GLBitmapFont1: TGLBitmapFont;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    miExit: TMenuItem;
    N2: TMenuItem;
    miInflowPoints: TMenuItem;
    N3: TMenuItem;
    Button1: TButton;
    cbShowFreeFrames: TCheckBox;
    Label18: TLabel;
    edH: TEdit;
    imChooseDiscrStep: TMenuItem;
    Label19: TLabel;
    edTubeWidth: TEdit;
    edWidthRibsCount: TEdit;
    Label21: TLabel;
    plLeftOuter: TGLPlane;
    plLeftInner: TGLPlane;
    TubeRoot: TGLBaseControl;
    plRightOuter: TGLPlane;
    plRightInner: TGLPlane;
    plTopOuter: TGLPlane;
    plTopInner: TGLPlane;
    plBottomOuter: TGLPlane;
    plBottomInner: TGLPlane;
    btnFlowLineCoords: TButton;
    procedure FormCreate(Sender: TObject);
    procedure GLSceneViewer1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GLSceneViewer1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure btnCountSpeedClick(Sender: TObject);
    procedure btnInflowPointsInfoClick(Sender: TObject);
    procedure btnViewLeftClick(Sender: TObject);
    procedure btnViewRightClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure btnFlowLineClick(Sender: TObject);
    procedure btnSaveParamsClick(Sender: TObject);
    procedure btnViewUpClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnStepClick(Sender: TObject);
    procedure cbShowTubeClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbShowFreeFramesClick(Sender: TObject);
    procedure imChooseDiscrStepClick(Sender: TObject);
    procedure btnFlowLineCoordsClick(Sender: TObject);
  private
    RotateFlag: Boolean;
    RotatePrevX, RotatePrevY: Integer;
    StopFlag: Boolean;
    //
//    showCountSpeedMsg: Boolean;
    //
    procedure InitVortexes1;
    procedure InitVortexes;
    procedure BuildSystem1;
    procedure BuildSystem;
    procedure UpdateSystem1;
    procedure UpdateSystem;
    procedure SolveSystem;
    procedure MoveVortexFrames;
    procedure DumpVortexFrames;
    procedure CountCalcFrameArea(var CalcFrame: TCalcFrame);
    function CountSpeed(p: T3dPoint): T3dVector;
    procedure DrawFlowLine(p: T3dPoint; Length, Step: Extended);
    procedure VizualizeVortexFrame(f: TVortexFrame; glContainer: TGLBaseControl; color: TColorVector);
    function IsPointInsideTube(p: T3dPoint): Boolean;
  public
    { Public declarations }
  end;

// Параметры области
var
  TubeLength: Extended = 1.0; // Длина трубы в метрах
  TubeHeight: Extended = 0.4; // Высота трубы в метрах
  TubeWidth:  Extended = 0.4; // Ширина трубы в метрах
  RectCount: Integer = 12;    // Кол-во прямоугольных рамок
  HeightNumPoints: Integer = 6; // Кол-во точек по высоте прямоуг. рамки
  WidthNumPoints: Integer = 6;  // Кол-во точек по ширине прямоуг. рамки
  Speed: Extended = 1.0; // Скорость воздуха в приточном отверстии

var
  VortexFrames: TVortexFrameArray;
  FreeVortexFrames: TVortexFrameArray;
  CalcPoints: TCalcPointArray;
  CalcFrames: TCalcFrameArray;
  Matr: TFloatMatr;
  Gamma: TFloatArray;
  BreakVortexRibs: TBreakVortexRibArray;
  DiscrStep: Extended = 0.05; // Шаг дискретности
  DiscrStep2: Extended; // Шаг дискретности в квадрате
  DiscrStepSpeed: Extended = 0.05; // Шаг дискретности при расчете скорости
  DiscrStepTube: Extended = 0.05001; // "Шаг дискретности" при движении точек вблизи трубы
  ModelStep: Integer = 0;
  ModelTime: Extended = 0.0;
  MinCalcPointRibDistance: Extended;

var
  Form1: TForm1;

implementation

uses uFlatProjection, uDiscrStepInfo, uFlowLineCoords;

{$R *.dfm}

function TForm1.CountSpeed(p: T3dPoint): T3dVector;
var
  i, k: Integer;
  v: T3dVector;
  SkipFlag: Boolean;
//
//  str: string;
//
begin
  SetVector(Result, 0, 0, 0);
  for k := 0 to High(VortexFrames) do
  begin
{}
    SkipFlag := False;
    for i := 0 to High(VortexFrames[k].Ribs) do
    begin
      if PointsDistance(p,VortexFrames[k].Ribs[i].a)<DiscrStepSpeed{50} then
      begin
        SkipFlag := True;
        break;
      end;
    end;
    if SkipFlag then
      continue;
{}
    SetVector(v, 0, 0, 0);
    for i := 0 to High(VortexFrames[k].Ribs) do
    begin
//      if (PointsDistance(p,VortexFrames[k].Ribs[i].a)>DiscrStepSpeed) and
//         (PointsDistance(p,VortexFrames[k].Ribs[i].b)>DiscrStepSpeed)
//      then
        v := VectorsAdd(v,funcG(VortexFrames[k].Ribs[i].a,VortexFrames[k].Ribs[i].b,p))
//
//      else str := str + 'fx[' + IntToStr(k) + ',' + IntToStr(i) + '] ';
//
    end;
    Result := VectorsAdd(Result,ScaleVector(v,Gamma[k]));
  end;
  for k := 0 to High(FreeVortexFrames) do
  begin
{}
    SkipFlag := False;
    for i := 0 to High(FreeVortexFrames[k].Ribs) do
    begin
      if PointsDistance(p,FreeVortexFrames[k].Ribs[i].a)<DiscrStepSpeed{50} then
      begin
        SkipFlag := True;
        break;
      end;
    end;
    if SkipFlag then
      continue;
{}
    SetVector(v, 0, 0, 0);
    for i := 0 to High(FreeVortexFrames[k].Ribs) do
    begin
//      if (PointsDistance(p,FreeVortexFrames[k].Ribs[i].a)>DiscrStepSpeed) and
//         (PointsDistance(p,FreeVortexFrames[k].Ribs[i].b)>DiscrStepSpeed)
//      then
        v := VectorsAdd(v,funcG(FreeVortexFrames[k].Ribs[i].a,FreeVortexFrames[k].Ribs[i].b,p))
//
//      else str := str + 'fr[' + IntToStr(k) + ',' + IntToStr(i) + '] ';
//
    end;
    Result := VectorsAdd(Result,ScaleVector(v,FreeVortexFrames[k].Gamma));
  end;
//
//  if showCountSpeedMsg then
//    ShowMessage(str);
//
end;

procedure TForm1.DrawFlowLine(p: T3dPoint; Length: Extended; Step: Extended);
var
  curLen: Extended;
  v: T3dVector;
  lns: TGLLines;
  pp: T3dPoint;
  ppInside, pInside: Boolean;
begin
  lns := TGLLines.Create(Self);
  lns.NodesAspect := lnaInvisible;
  lns.LineColor.Initialize(clrForestGreen);
  lns.LineWidth := 2;
  lns.AddNode(p.x, p.y, p.z);
  curLen := 0;
  fFlowLineCoords.mmFlowLineCoords.Lines.Clear;
  fFlowLineCoords.mmFlowLineCoords.Lines.Add(
    FloatToStrF(p.x,ffFixed,10,6) + chr(9) +
    FloatToStrF(p.y,ffFixed,10,6) + chr(9) +
    FloatToStrF(p.z,ffFixed,10,6)
  );
  while curLen < Length do
  begin
    v := CountSpeed(p);
    v := ScaleVector(v, Step/VectorModulus(v));
    pp := p;
    p.x := p.x + v.x;
    p.y := p.y + v.y;
    p.z := p.z + v.z;
    ppInside := IsPointInsideTube(pp);
    pInside := IsPointInsideTube(p);
    if (ppInside and (p.x<0)) then Break;
    if (ppInside <> pInside) then
    begin
      if (Abs(p.x)<TubeLength/2) and (Abs(pp.x)<TubeLength/2) then
        Break;
    end;
    lns.AddNode(p.x, p.y, p.z);
    fFlowLineCoords.mmFlowLineCoords.Lines.Add(
      FloatToStrF(p.x,ffFixed,10,6) + chr(9) +
      FloatToStrF(p.y,ffFixed,10,6) + chr(9) +
      FloatToStrF(p.z,ffFixed,10,6)
    );
    curLen := curLen + Step;
  end;
  DiscreteRoot.AddChild(lns);
end;

procedure TForm1.DumpVortexFrames;
var F: TextFile;
    i: Integer;
begin
  AssignFile(F,'vortex_frames.txt');
  Append(F);
  writeln(F,'Step ' + IntToStr(ModelStep));
  writeln(F,'-------');
  for i := 0 to High(FreeVortexFrames) do
  begin
    writeln(F,IntToStr(i):3,': ',
      '(',FreeVortexFrames[i].Ribs[0].a.x:7:4,',',FreeVortexFrames[i].Ribs[0].a.y:7:4,',',FreeVortexFrames[i].Ribs[0].a.z:7:4,') - ',
      '(',FreeVortexFrames[i].Ribs[0].b.x:7:4,',',FreeVortexFrames[i].Ribs[0].b.y:7:4,',',FreeVortexFrames[i].Ribs[0].b.z:7:4,')'
    );
  end;
  writeln(F);
  CloseFile(F);
end;

procedure TForm1.CountCalcFrameArea(var CalcFrame: TCalcFrame);
var
  Points: T2dPointArray;
  i: Integer;
begin
  SetLength(Points,High(CalcFrame.Ribs)+1);
  for i := 0 to High(CalcFrame.Ribs) do
  begin
    Points[i].x := CalcFrame.Ribs[i].a.z;
    Points[i].y := CalcFrame.Ribs[i].a.y;
  end;
  CalcFrame.s := ConvexPoligonArea(Points);
end;

procedure TForm1.InitVortexes;
var
  i, j: Integer;
  lns: TGLLines;
  sph: TGLSphere;
  pl: TGLPlane;
  m: Extended;
  color: TColorVector;
begin
  SetLength(FreeVortexFrames,0);
  InitVortexes1;

  DiscrStepSpeed := DiscrStep;
  // Если DiscrStepTube=DiscrStepSpeed, то может возникать выч. погрешность при сходе вихрей
  // Нужно сделать эти величины отличающимися, поэтому умножаем на 1.001
  DiscrStepTube := DiscrStepSpeed*1.001;

  ModelStep := 0;
  ModelTime := 0.0;
  lbModelStep.Caption := '';
  lbModelTime.Caption := '';

  // -- Визуализация дискретизации
  // Сначала удаляем старую дискретизацию (если она была)
  DiscreteRoot.DeleteChildren;
  FreeVortexesRoot.DeleteChildren;
  // Визуализация круговых рамок
  for i:= 0 to High(VortexFrames) do
  begin
    if i=RectCount-1 then color:=clrMaroon else color:=clrNavy;
    VizualizeVortexFrame(VortexFrames[i], DiscreteRoot, color);
  end;
  for i:=0 to TubeRoot.Count-1 do
  begin
    pl := (TubeRoot.Children[i] as TGLPlane);
    if pl.Position.Y<>0 then pl.Height := TubeWidth
                        else pl.Height := TubeHeight;
    pl.Width := TubeLength;
    pl.Position.Y := Sign(pl.Position.Y) * TubeHeight/2;
    pl.Position.Z := Sign(pl.Position.Z) * TubeWidth/2;
  end;
  // Визуализация расчетных точек
  for i := 0 to High(CalcPoints) do
  begin
    sph := TGLSphere.Create(Self);
    sph.Slices := 4;
    sph.Stacks := 4;
    sph.Radius := 0.008;
    sph.Material.FrontProperties.Emission.Initialize(clrOrangeRed);
    sph.Material.FrontProperties.Diffuse.Initialize(clrOrangeRed);
    sph.Position.X := CalcPoints[i].p.x;
    sph.Position.Y := CalcPoints[i].p.y;
    sph.Position.Z := CalcPoints[i].p.z;
    DiscreteRoot.AddChild(sph);
  end;
  // Визуализация рамок в приточном отверстии
  for i := 0 to High(CalcFrames) do
  begin
    lns:= TGLLines.Create(self);
    for j := 0 to High(CalcFrames[i].Ribs) do
      lns.AddNode(CalcFrames[i].Ribs[j].a.x, CalcFrames[i].Ribs[j].a.y, CalcFrames[i].Ribs[j].a.z);
    lns.AddNode(CalcFrames[i].Ribs[0].a.x, CalcFrames[i].Ribs[0].a.y, CalcFrames[i].Ribs[0].a.z);
    lns.NodesAspect := lnaInvisible;
    lns.LineColor.Initialize(clrOrangeRed);
    lns.LineWidth := 1;
    DiscreteRoot.AddChild(lns);
    sph := TGLSphere.Create(Self);
    sph.Slices := 4;
    sph.Stacks := 4;
    sph.Radius := 0.008;
    sph.Material.FrontProperties.Emission.Initialize(clrOrangeRed);
    sph.Material.FrontProperties.Diffuse.Initialize(clrOrangeRed);
    sph.Position.X := CalcFrames[i].p.x;
    sph.Position.Y := CalcFrames[i].p.y;
    sph.Position.Z := CalcFrames[i].p.z;
    DiscreteRoot.AddChild(sph);
  end;
end;

// Дискретизация для случая,
// когда приточное отверстие представлено вихревыми рамками
procedure TForm1.InitVortexes1;
var
  i, j, kCalc, kVort, InflowNumPoints: Integer;
  x, xStep, y, yStep, z, zStep: Extended;
  n: T3dVector;
begin
  // Дискретизация трубы
  x := -TubeLength/2;
  xStep := TubeLength/(RectCount);
  SetLength(VortexFrames, RectCount);
  for i:= 0 to RectCount-1 do
  begin
    // Делаем пропуск в центре трубы (здесь будут вихревые рамки для притока)
    if i = RectCount div 2 then
      x := x + xStep;
    // Инициализация вихревой прямоугольной рамки на трубе
    VortexFrames[i].RibsCount := 4;
    SetLength(VortexFrames[i].Ribs, VortexFrames[i].RibsCount);
    SetPoint(VortexFrames[i].Ribs[0].a,x,TubeHeight/2,TubeWidth/2);
    SetPoint(VortexFrames[i].Ribs[0].b,x,TubeHeight/2,-TubeWidth/2);
    VortexFrames[i].Ribs[1].a := VortexFrames[i].Ribs[0].b;
    SetPoint(VortexFrames[i].Ribs[1].b,x,-TubeHeight/2,-TubeWidth/2);
    VortexFrames[i].Ribs[2].a := VortexFrames[i].Ribs[1].b;
    SetPoint(VortexFrames[i].Ribs[2].b,x,-TubeHeight/2,TubeWidth/2);
    VortexFrames[i].Ribs[3].a := VortexFrames[i].Ribs[2].b;
    VortexFrames[i].Ribs[3].b := VortexFrames[i].Ribs[0].a;
    x := x + xStep;
  end;

  // Инициализация расчетных точек на трубе
  x := -TubeLength/2+xStep/2;
  n.x := 0; n.y := -1; n.z := 0;
  SetLength(CalcPoints, RectCount);
  for i:= 0 to RectCount-1 do
  begin
    CalcPoints[i].p.x := x;
    CalcPoints[i].p.y := TubeHeight/2;
    CalcPoints[i].p.z := 0;
    CalcPoints[i].n := n;
    x := x + xStep;
  end;

  // TODO: расчет MinCalcPointRibDistance

  // Инициализация расчетных точек в приточном отверстии
  InflowNumPoints := HeightNumPoints * WidthNumPoints;
  kCalc := High(CalcPoints)+1; // индекс расчетной точки
  kVort := High(VortexFrames)+1; // индекс вихревой рамки
  SetLength(CalcPoints,High(CalcPoints)+1+InflowNumPoints);
  SetLength(VortexFrames,High(VortexFrames)+1+InflowNumPoints);
  n.x := -1; n.y := 0; n.z := 0;
  x := 0;
  yStep := TubeHeight/HeightNumPoints;
  zStep := TubeWidth/WidthNumPoints;
  for i := 0 to HeightNumPoints-1 do
  begin
    for j := 0 to WidthNumPoints-1 do
    begin
      y := -TubeHeight/2 + i*yStep;
      z := -TubeWidth/2 + j*zStep;
      SetLength(VortexFrames[kVort].Ribs,4);
      SetPoint(VortexFrames[kVort].Ribs[0].a,x,y,z);
      SetPoint(VortexFrames[kVort].Ribs[0].b,x,y,z+zStep);
      VortexFrames[kVort].Ribs[1].a := VortexFrames[kVort].Ribs[0].b;
      SetPoint(VortexFrames[kVort].Ribs[1].b,x,y+yStep,z+zStep);
      VortexFrames[kVort].Ribs[2].a := VortexFrames[kVort].Ribs[1].b;
      SetPoint(VortexFrames[kVort].Ribs[2].b,x,y+yStep,z);
      VortexFrames[kVort].Ribs[3].a := VortexFrames[kVort].Ribs[2].b;
      VortexFrames[kVort].Ribs[3].b := VortexFrames[kVort].Ribs[0].a;
      CalcPoints[kCalc].p.x := x;
      CalcPoints[kCalc].p.y := y + 0.5*yStep;
      CalcPoints[kCalc].p.z := z + 0.5*zStep;
      CalcPoints[kCalc].n := n;
      Inc(kVort);
      Inc(kCalc);
    end;
  end;

  MinCalcPointRibDistance := Min(xStep/2,Min(yStep/2,zStep/2));

(*
  // Инициализация ребер отрыва
  SetLength(BreakVortexRibs, CircleNumPoints);
  x := TubeLength/2;
  angleDelta := 2*Pi/CircleNumPoints;
  for i := 0 to CircleNumPoints-1 do
  begin
    SetPoint(p1, x, cos(i*angleDelta)*TubeRadius, sin(i*angleDelta)*TubeRadius);
    SetPoint(p2, x, cos((i+1)*angleDelta)*TubeRadius, sin((i+1)*angleDelta)*TubeRadius);
    BreakVortexRibs[i].a := p1;
    BreakVortexRibs[i].b := p2;
    BreakVortexRibs[i].VortexFrameInd := CircleNumPoints-1;
  end;
*)
end;

function TForm1.IsPointInsideTube(p: T3dPoint): Boolean;
begin
  Result := (Abs(p.x)<TubeLength/2) and (Abs(p.y)<TubeHeight/2) and (Abs(p.z)<TubeWidth/2);
end;

procedure TForm1.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MoveVortexFrames;
var
  i, j, k, rCount: Integer;
  v: T3dVector;
  pr: T3dPoint;
  dt,r,TubeLength2,TubeLength2Out,TubeDiscr: Extended;
  xOld,xNew,yOld,yNew,zOld,zNew: Extended;
  TubeWidth2,TubeHeight2,TubeWidth2In,TubeHeight2In,TubeWidth2Out,TubeHeight2Out: Extended;
  dx,dr,scaler: Extended;
  NewFrames,TmpFrames: TVortexFrameArray;
  NewFrame: TVortexFrame;
  str: String;
  p,p2: T3dPoint;
  DisappearFlag,oldInside,newInside: Boolean;
begin
  //dt := abs(DiscrStep/Speed); //0.01
  dt := StrToFloat(edStep.Text);
  TubeLength2 := TubeLength/2;
  TubeLength2Out := TubeLength/2 + DiscrStepTube;
  TubeHeight2 := TubeHeight/2;
  TubeHeight2In := TubeHeight/2 - DiscrStepTube;
  TubeHeight2Out := TubeHeight/2 + DiscrStepTube;
  TubeWidth2 := TubeWidth/2;
  TubeWidth2In := TubeWidth/2 - DiscrStepTube;
  TubeWidth2Out := TubeWidth/2 + DiscrStepTube;

  // 1. Перемещение существующих свободных вихр. рамок (расчет новых положений)
  SetLength(TmpFrames,Length(FreeVortexFrames));
  for i := 0 to High(FreeVortexFrames) do
  begin
    rCount := Length(FreeVortexFrames[i].Ribs);
    SetLength(TmpFrames[i].Ribs,rCount);
    for j := 0 to rCount - 1 do
    begin
      v := CountSpeed(FreeVortexFrames[i].Ribs[j].b);
      // проверка пересечения точки с областью
      with FreeVortexFrames[i].Ribs[j] do
      begin
        SetPoint(p, b.x + v.x*dt, b.y + v.y*dt, b.z + v.z*dt);
        xOld := abs(b.x);  yOld := abs(b.y);  zOld := abs(b.z);
        xNew := abs(p.x);  yNew := abs(p.y);  zNew := abs(p.z);
        // Проверка пересечения с трубой
        if (xOld<TubeLength2)or(xNew<TubeLength2) then
        begin
          oldInside := (abs(b.y)<TubeHeight2)and(abs(b.z)<TubeWidth2);
          newInside := (abs(p.y)<TubeHeight2)and(abs(p.z)<TubeWidth2);
          if (xOld<TubeLength2)and(xNew<TubeLength2) then
          begin
            // В положения "до" и "после" координата X в пределах длины трубы
            if ((yOld<TubeHeight2In)and(zOld<TubeWidth2In) and
                ((yNew>TubeHeight2In)or(zNew>TubeWidth2In))) then
              begin
                r := Min(
                  (TubeHeight2In-yOld)/(yNew-yOld),
                  (TubeWidth2In-zOld)/(zNew-zOld)
                );
                // Смещаемся вдоль вектора скорости чуть дальше точки пересечения
                r := r + 0.5*(1-r);
                SetPoint(p, b.x + v.x*dt*r, b.y + v.y*dt*r, b.z + v.z*dt*r);
                // Находим проекцию точки на трубу
                if (abs(p.y)>TubeHeight2In) then
                  p.y := Sign(p.y)*TubeHeight2In*0.999;
                if (abs(p.z)>TubeWidth2In) then
                  p.z := Sign(p.z)*TubeWidth2In*0.999;
              end
            else
            if (((yOld>TubeHeight2Out)or(zOld>TubeWidth2Out)) and
                ((yNew<TubeHeight2Out)and(zNew<TubeWidth2Out))) then
              begin
                r := Min(
                  (yOld-TubeHeight2Out)/(yOld-yNew),
                  (zOld-TubeWidth2Out)/(zOld-zNew)
                ) * 0.999;
                SetPoint(p, b.x + v.x*dt*r, b.y + v.y*dt*r, b.z + v.z*dt*r);
                // По-хорошему, тут тоже надо делать смещение и проекцию
              end;
          end
          else
          begin
            // Только в одном положении ("до" или "после") координата X в пределах длины трубы
            if ((yOld<TubeHeight2In)and(zOld<TubeWidth2In) and
                ((yNew>TubeHeight2In)or(zNew>TubeWidth2In))) then
              begin
                r := Min(
                  ((TubeHeight2In-0.001)-yOld)/(yNew-yOld),
                  ((TubeWidth2In-0.001)-zOld)/(zNew-zOld)
                );
                SetPoint(p2, b.x + v.x*dt*r, b.y + v.y*dt*r, b.z + v.z*dt*r);
                if (p2.x<=TubeLength2) then
                begin
                  // Пересечение с трубой есть. Меняем точку p
                  p := p2;
                end;
              end
            else
            if (((yOld>TubeHeight2Out)or(zOld>TubeWidth2Out)) and
                ((yNew<TubeHeight2Out)and(zNew<TubeWidth2Out))) then
              begin
                r := Min(
                  (yOld-TubeHeight2Out)/(yOld-yNew),
                  (zOld-TubeWidth2Out)/(zOld-zNew)
                ) * 0.999;
                SetPoint(p2, b.x + v.x*dt*r, b.y + v.y*dt*r, b.z + v.z*dt*r);
                if (p2.x<=TubeLength2) then
                begin
                  // Пересечение с трубой есть. Меняем точку p
                  p := p2;
                end;
              end;
          end;
        end;

        // Если точка слишком близко к кромке трубы, то отодвигаем ее по окружности
        // Точка p могла измениться, обновим xNew, yNew, zNew
        xNew := abs(p.x);
        if (xNew>TubeLength2)and(xNew<TubeLength2Out) then
        begin
          yNew := abs(p.y);
          if (yNew>TubeHeight2In)and(yNew<TubeHeight2Out) then
          begin
            pr.x := TubeLength2;
            pr.y := p.y*TubeHeight2/yNew;
            pr.z := p.z;
            r := PointsDistance(p,pr);
            if r<DiscrStepTube then
            begin
              p.x := pr.x + (p.x-pr.x) * DiscrStepTube/r;
              p.y := pr.y + (p.y-pr.y) * DiscrStepTube/r;
              p.z := pr.z + (p.z-pr.z) * DiscrStepTube/r;
            end;
          end;
          zNew := abs(p.z);
          if (zNew>TubeWidth2In)and(zNew<TubeWidth2Out) then
          begin
            pr.x := TubeLength2;
            pr.y := p.y;
            pr.z := p.z*TubeWidth2/zNew;
            r := PointsDistance(p,pr);
            if r<DiscrStepTube then
            begin
              p.x := pr.x + (p.x-pr.x) * DiscrStepTube/r;
              p.y := pr.y + (p.y-pr.y) * DiscrStepTube/r;
              p.z := pr.z + (p.z-pr.z) * DiscrStepTube/r;
            end;
          end;
        end;

        TmpFrames[i].Ribs[j].b := p;
      end;
      k := (j + 1) mod rCount;
      TmpFrames[i].Ribs[k].a := TmpFrames[i].Ribs[j].b;
    end;
  end;

  // 2. Сход новой вихревой рамки (расчет положения)
  SetLength(NewFrame.Ribs,4);
  NewFrame.RibsCount := 4;
  NewFrame.Gamma := Gamma[RectCount-1];
  for i := 0 to 3 do
  begin
    with VortexFrames[RectCount-1].Ribs[i] do
    begin
      v := CountSpeed(a);
      SetPoint(p, a.x + v.x*dt, a.y + v.y*dt, a.z + v.z*dt);
    end;
    // Если точка слишком близко к трубе, то отодвигаем ее
    if (p.x<TubeLength2Out) then
    begin
      yNew := abs(p.y); zNew := abs(p.z);
      if (yNew>TubeHeight2In)and(yNew<TubeHeight2) and
         (zNew>TubeWidth2In)and(zNew<TubeWidth2) then
      begin
        // Точка находится в углу. Делаем отодвигание от угла
        if p.x<=TubeLength2 then
          begin
            p.y := TubeHeight2In * 0.999 * Sign(p.y);
            p.z := TubeWidth2In * 0.999 * Sign(p.z);
          end
        else
          begin
            r := Sqrt(DiscrStep2 - Sqr(TubeLength2-p.x));
            if TubeHeight2In-yNew < r then
              p.y := (TubeHeight2In - r) * 1.001 * Sign(p.y);
            if TubeWidth2In-zNew < r then
              p.z := (TubeWidth2In - r) * 1.001 * Sign(p.z);
          end;
      end
      else
      begin
        yNew := abs(p.y);
        if (yNew>TubeHeight2In)and(yNew<TubeHeight2Out) then
        begin
          pr.x := TubeLength2;
          pr.y := p.y*TubeHeight2/yNew;
          pr.z := p.z;
          r := PointsDistance(p,pr);
          if r<DiscrStepTube then
          begin
            p.x := pr.x + (p.x-pr.x) * DiscrStepTube/r;
            p.y := pr.y + (p.y-pr.y) * DiscrStepTube/r;
            p.z := pr.z + (p.z-pr.z) * DiscrStepTube/r;
          end;
          // Если точка сдвинулась внутрь трубы, то делаем проекцию точки на границы трубы
          if p.x<TubeLength2 then
          begin
            yNew := abs(p.y);
            if (yNew>TubeHeight2In)and(yNew<TubeHeight2Out) then
            begin
              if yNew<TubeHeight2 then
                scaler := TubeHeight2In/yNew
              else
                scaler := TubeHeight2Out/yNew;
              p.y := p.y * scaler;
              p.z := p.z * scaler;
            end;
          end;
        end;
        zNew := abs(p.z);
        if (zNew>TubeWidth2In)and(zNew<TubeWidth2Out) then
        begin
          pr.x := TubeLength2;
          pr.y := p.y*TubeHeight2/yNew;
          pr.z := p.z;
          r := PointsDistance(p,pr);
          if r<DiscrStepTube then
          begin
            p.x := pr.x + (p.x-pr.x) * DiscrStepTube/r;
            p.y := pr.y + (p.y-pr.y) * DiscrStepTube/r;
            p.z := pr.z + (p.z-pr.z) * DiscrStepTube/r;
          end;
          // Если точка сдвинулась внутрь трубы, то делаем проекцию точки на границы трубы
          if p.x<TubeLength2 then
          begin
            zNew := abs(p.z);
            if (zNew>TubeWidth2In)and(zNew<TubeWidth2Out) then
            begin
              if zNew<TubeWidth2 then
                scaler := TubeWidth2In/zNew
              else
                scaler := TubeWidth2Out/zNew;
              p.y := p.y * scaler;
              p.z := p.z * scaler;
            end;
          end;
        end;
      end;
    end;
    NewFrame.Ribs[i].a := p;

    // Возможно, имеет смысл тут делать какие-то проверки для пересечения с трубой
    // Но таких ситуаций быть не должно (при нормальном шаге по времени и
    // при отсутствии странных эффектов в ходе моделирования)
    k := i - 1;
    if (k<0) then k := 3;
    NewFrame.Ribs[k].b := NewFrame.Ribs[i].a;
  end;

  // 3. Обновление положений существующих свободных вихр. рамок
  //    и удаление рамок, попавших во всас. отверстие
  k := 0;
  for i := 0 to High(TmpFrames) do
  begin
    DisappearFlag := True;
    for j := 0 to High(TmpFrames[i].Ribs) do
      if TmpFrames[i].Ribs[j].a.x>0 then
      begin
        DisappearFlag := False;
        break;
      end;
    if DisappearFlag then
    begin
      // У всех точек отрицат. абсцисса. Проверим положение первой точки
      // (для остальных можно не проверять, т.к. вся рамка либо внутри трубы, либо снаружи)
      if (abs(TmpFrames[i].Ribs[0].a.y)>TubeHeight2)or(abs(TmpFrames[i].Ribs[0].a.z)>TubeWidth2) then
        DisappearFlag := False;
    end;
    if not DisappearFlag then
    begin
      for j := 0 to High(TmpFrames[i].Ribs) do
        FreeVortexFrames[k].Ribs[j] := TmpFrames[i].Ribs[j];
      Inc(k);
    end;
  end;
  SetLength(FreeVortexFrames,k);

  // 4. Обновление положения новой вихревой рамки
  k := High(FreeVortexFrames) + 1;
  SetLength(FreeVortexFrames, k + 1);
  FreeVortexFrames[k] := NewFrame;

  // Отображение свободных вихревых рамок
  FreeVortexesRoot.DeleteChildren;
  for i := 0 to High(FreeVortexFrames) do
  begin
    VizualizeVortexFrame(FreeVortexFrames[i],FreeVortexesRoot,clrNavy);
  end;

  // Отображение времени моделирования
  Inc(ModelStep);
  ModelTime := ModelTime + dt;
  lbModelStep.Caption := 'Шаг: ' + IntToStr(ModelStep);
  lbModelTime.Caption := 'Время: ' + FloatToStr(ModelTime);

  //DumpVortexFrames;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  frmFlatProjection.ShowModal;
end;

procedure TForm1.btnFlowLineClick(Sender: TObject);
var
  p: T3dPoint;
begin
  try
    SetPoint(p,StrToFloat(edFlowLineX.Text),StrToFloat(edFlowLineY.Text),StrToFloat(edFlowLineZ.Text));
    DrawFlowLine(p,StrToFloat(edFlowLineLength.Text),StrToFloat(edFlowLineStep.Text));
  except
    ShowMessage('Введите корректные параметры для построения линии тока!');
  end;
end;

procedure TForm1.btnFlowLineCoordsClick(Sender: TObject);
begin
  fFlowLineCoords.ShowModal;
end;

procedure TForm1.BuildSystem;
begin
  BuildSystem1;
end;

// Система для случая, когда приточное отверстие представлено вихревыми рамками
procedure TForm1.BuildSystem1;
var
  p, i, k, n: Integer;
  v: T3dVector;
begin
  n := High(CalcPoints) + 1;
  SetLength(Matr,n,n+1);
  for p := 0 to n-1 do
  begin
    for k := 0 to n-1 do
    begin
      v.x := 0; v.y := 0; v.z := 0;
      for i := 0 to High(VortexFrames[k].Ribs) do
        v := VectorsAdd(v,funcG(VortexFrames[k].Ribs[i].a,VortexFrames[k].Ribs[i].b,CalcPoints[p].p));
      Matr[p,k] := ScalarProduct(v,CalcPoints[p].n);
    end;
    if p<RectCount then
      Matr[p,n] := 0
    else
      Matr[p,n] := -Speed;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i,k: Integer;
  r1,r2: Extended;
  str: String;
begin
  str := '';
  for i := 0 to High(FreeVortexFrames) do
  begin
    r1:= VectorModulus(RibToVector(FreeVortexFrames[i].Ribs[0]));
    for k := 1 to High(FreeVortexFrames[i].Ribs) do
    begin
      r2:= VectorModulus(RibToVector(FreeVortexFrames[i].Ribs[k]));
      if abs(r2-r1)>0.001 then
      begin
        str := str + IntToStr(i) + ',';
        break;
      end;
    end;
  end;
  if length(str)>0 then
    ShowMessage('Симметрия нарушена в след. рамках: ' + str);
end;

procedure TForm1.SolveSystem;
var
  n: Integer;
begin
  n := High(CalcPoints) + 1;
  SetLength(Gamma,n);
  SolveLinearSystem(n,Matr,Gamma);
end;

procedure TForm1.btnViewLeftClick(Sender: TObject);
begin
  GLCamera1.Position.X := GLCamera1.Position.X + 0.1;
  GLDummyCube1.Position.X := GLDummyCube1.Position.X + 0.1;
end;

procedure TForm1.btnViewRightClick(Sender: TObject);
begin
  GLCamera1.Position.X := GLCamera1.Position.X - 0.1;
  GLDummyCube1.Position.X := GLDummyCube1.Position.X - 0.1;
end;

procedure TForm1.btnViewUpClick(Sender: TObject);
begin
  GLCamera1.Position.Y := GLCamera1.Position.Y - 0.1;
  GLDummyCube1.Position.Y := GLDummyCube1.Position.Y - 0.1;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  GLCamera1.Position.Y := GLCamera1.Position.Y + 0.1;
  GLDummyCube1.Position.Y := GLDummyCube1.Position.Y + 0.1;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  GLCamera1.SceneScale := GLCamera1.SceneScale / 1.1;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  GLCamera1.SceneScale := GLCamera1.SceneScale * 1.1;
end;

procedure TForm1.UpdateSystem;
begin
  UpdateSystem1;
end;

// Обновление системы для случая, когда приточное отверстие представлено вихревыми рамками
procedure TForm1.UpdateSystem1;
var
  p, i, k, n: Integer;
  v: T3dVector;
begin
  n := High(CalcPoints) + 1;
  //SetLength(Matr,n,n+1);
  for p := 0 to n-1 do
  begin
    for k := 0 to n-1 do
    begin
      v.x := 0; v.y := 0; v.z := 0;
      for i := 0 to High(VortexFrames[k].Ribs) do
        v := VectorsAdd(v,funcG(VortexFrames[k].Ribs[i].a,VortexFrames[k].Ribs[i].b,CalcPoints[p].p));
      Matr[p,k] := ScalarProduct(v,CalcPoints[p].n);
    end;
    if p<RectCount then
      Matr[p,n] := 0
    else
      Matr[p,n] := -Speed;
    for k := 0 to High(FreeVortexFrames) do
    begin
      v.x := 0; v.y := 0; v.z := 0;
      for i := 0 to High(FreeVortexFrames[k].Ribs) do
        v := VectorsAdd(v,funcG(FreeVortexFrames[k].Ribs[i].a,FreeVortexFrames[k].Ribs[i].b,CalcPoints[p].p));
      Matr[p,n] := Matr[p,n] - ScalarProduct(v,CalcPoints[p].n)*FreeVortexFrames[k].Gamma;
    end;
  end;
end;

procedure TForm1.VizualizeVortexFrame(f: TVortexFrame; glContainer: TGLBaseControl; color: TColorVector);
var
  j: Integer;
  lns: TGLLines;
begin
  lns := TGLLines.Create(self);
  for j := 0 to High(f.Ribs) do
  begin
//    lns.AddNode(f.Ribs[j].a.x, f.Ribs[j].a.y, f.Ribs[j].a.z);
    lns.AddNode(f.Ribs[j].b.x, f.Ribs[j].b.y, f.Ribs[j].b.z);
  end;
//  lns.AddNode(f.Ribs[0].a.x, f.Ribs[0].a.y, f.Ribs[0].a.z);
  lns.AddNode(f.Ribs[0].b.x, f.Ribs[0].b.y, f.Ribs[0].b.z);
  lns.NodesAspect := lnaCube;
  lns.NodeSize := 0.008;
  lns.LineColor.Initialize(color);
  lns.LineWidth := 3;
  // GLScene1.Objects.AddChild(lns);
  glContainer.AddChild(lns);
end;

procedure TForm1.btnSaveParamsClick(Sender: TObject);
var
  l, ht, w, s, h: Extended;
  c, ch, cw: Integer;
  fs: TFormatSettings;
begin
  l := 0;
  try
    l := StrToFloat(edTubeLength.Text);
  except
  end;
  if l <= 0 then
  begin
    ShowMessage('Длина трубы должна быть положительным числом!');
    Exit;
  end;
  ht := 0;
  try
    ht := StrToFloat(edTubeHeight.Text);
  except
  end;
  if ht <= 0 then
  begin
    ShowMessage('Высота трубы должна быть положительным числом!');
    Exit;
  end;
  w := 0;
  try
    w := StrToFloat(edTubeWidth.Text);
  except
  end;
  if w <= 0 then
  begin
    ShowMessage('Ширина трубы должна быть положительным числом!');
    Exit;
  end;
  s := 0;
  try
    s := StrToFloat(edSpeed.Text);
  except
  end;
//  if s <= 0 then
//  begin
//    ShowMessage('Скорость приточного воздуха должна быть положительным числом!');
//    Exit;
//  end;
  c := 0;
  try
    c := StrToInt(edRectCount.Text);
  except
  end;
  if (c <= 0) or (c mod 2 <> 0) then
  begin
    ShowMessage('Кол-во прямоугольных рамок должно быть положительным четным числом!');
    Exit;
  end;
  ch := 0;
  try
    ch := StrToInt(edHeightRibsCount.Text);
  except
  end;
  if (ch <= 0) then
  begin
    ShowMessage('Кол-во рамок по высоте приточ. отверстия должно быть положительным числом!');
    Exit;
  end;
  cw := 0;
  try
    cw := StrToInt(edWidthRibsCount.Text);
  except
  end;
  if (cw <= 0) then
  begin
    ShowMessage('Кол-во рамок по ширине приточ. отверстия должно быть положительным числом!');
    Exit;
  end;
  h := 0;
  try
    h := StrToFloat(edH.Text);
  except
  end;
  if h <= 0 then
  begin
    ShowMessage('Шаг дискретности должен быть положительным числом!');
    Exit;
  end;
  // Применяем параметры
  TubeLength := l;
  TubeHeight := ht;
  TubeWidth := w;
  Speed := s;
  RectCount := c;
  HeightNumPoints := ch;
  WidthNumPoints := cw;
  DiscrStep := h;
  DiscrStep2 := Sqr(h);
  // Инициализируем дискретизацию и решаем систему уравнений
  InitVortexes;
  BuildSystem;
  SolveSystem;
  //MoveVortexFrames;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  ModelStep := 0;
  ModelTime := 0.0;
  StopFlag := False;
  btnStop.Enabled := True;
  btnStart.Enabled := False;
  btnStep.Enabled := False;
  SetLength(FreeVortexFrames,0);
  FreeVortexesRoot.DeleteChildren;
  while not StopFlag do
  begin
    Application.ProcessMessages;
    MoveVortexFrames;
    UpdateSystem;
    SolveSystem;
  end;
end;

procedure TForm1.btnStepClick(Sender: TObject);
begin
  MoveVortexFrames;
  UpdateSystem;
  SolveSystem;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  StopFlag := True;
  btnStop.Enabled := False;
  btnStart.Enabled := True;
  btnStep.Enabled := True;
end;

procedure TForm1.btnInflowPointsInfoClick(Sender: TObject);
var
  i, k: Integer;
  v: T3dVector;
  q: Extended;
begin
  Form2.Memo1.Lines.Clear;
    Form2.Memo1.Lines.Add('N  | Координаты                | Скорость в                |');
    Form2.Memo1.Lines.Add('   | расчетной точки           | расчетной точке           |');
    Form2.Memo1.Lines.Add('---+---------------------------+---------------------------+');
    k := 1;
    for i := 0{CircleCount} to High(CalcPoints) do
    begin
      v := CountSpeed(CalcPoints[i].p);
      Form2.Memo1.Lines.Add(
        Format('%2d |(%7.4f, %7.4f, %7.4f)|(%7.4f, %7.4f, %7.4f)|',
          [k,CalcPoints[i].p.x,CalcPoints[i].p.y,CalcPoints[i].p.z,v.x,v.y,v.z])
      );
      Inc(k);
    end;
    Form2.Memo1.Lines.Add('---+---------------------------+---------------------------+');

    Form2.Memo1.Lines.Add('');
    Form2.Memo1.Lines.Add('Номер рамки  | Интенсивность  |');
    Form2.Memo1.Lines.Add('-------------+----------------+');
    for i := 0 to High(VortexFrames) do
    begin
      Form2.Memo1.Lines.Add(
        Format('%2d           | %7.4f        |',
          [i,Gamma[i]])
      );
    end;
    Form2.Memo1.Lines.Add('-------------+----------------+');
  Form2.ShowModal;
end;

procedure TForm1.btnCountSpeedClick(Sender: TObject);
var
  v: T3dVector;
  p: T3dPoint;
begin
  try
    SetPoint(p,StrToFloat(edSpeedX.Text),StrToFloat(edSpeedY.Text),StrToFloat(edSpeedZ.Text));
//
//    showCountSpeedMsg := True;
//
    v := CountSpeed(p);
//
//    showCountSpeedMsg := False;
//
    ShowMessage('Скорость: Vx = ' + FloatToStrF(v.x,ffFixed,7,4) + ', Vy = ' +
      FloatToStrF(v.y,ffFixed,7,4) + ', Vz = ' + FloatToStrF(v.z,ffFixed,7,4));
  except
    ShowMessage('Введите корректные координаты точки!');
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  DiscreteRoot.Visible:= CheckBox1.Checked;
end;

procedure TForm1.cbShowFreeFramesClick(Sender: TObject);
begin
  FreeVortexesRoot.Visible:= cbShowFreeFrames.Checked;
end;

procedure TForm1.cbShowTubeClick(Sender: TObject);
begin
  TubeRoot.Visible := cbShowTube.Checked;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i: Integer;
begin
  FormatSettings.DecimalSeparator := '.';
  InitVortexes;
  BuildSystem;
  SolveSystem;
  //MoveVortexFrames;
end;

procedure TForm1.GLSceneViewer1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  RotateFlag := True;
  RotatePrevX := X;
  RotatePrevY := Y;
end;

procedure TForm1.GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (RotateFlag) then
  begin
    if (RotatePrevX <> X) then
    begin
      GLBaseControl1.Turn((RotatePrevX-X)/4);
      RotatePrevX := X;
    end;
    RotatePrevY := Y;
  end;
end;

procedure TForm1.GLSceneViewer1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  RotateFlag := False;
end;

procedure TForm1.imChooseDiscrStepClick(Sender: TObject);
var i,j: Integer;
begin
  frmDiscrStepInfo.edCircleRibLength.Text :=
    FloatToStrF(VectorModulus(RibToVector(VortexFrames[0].Ribs[0])),ffFixed,8,5);
  frmDiscrStepInfo.edCircleDistance.Text :=
    FloatToStrF(Abs(VortexFrames[0].Ribs[0].a.x-VortexFrames[1].Ribs[0].a.x),ffFixed,8,5);
  frmDiscrStepInfo.edMinCalcPointRibDistance.Text :=
    FloatToStrF(MinCalcPointRibDistance,ffFixed,8,5);
  frmDiscrStepInfo.ShowModal;
end;

end.
