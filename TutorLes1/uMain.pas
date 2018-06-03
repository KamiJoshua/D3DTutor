unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Direct3D9;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FDevice: IDirect3DDevice9;
    FD3D: IDirect3D9;

    procedure InitD3D(AHandle: THandle);
    procedure RenderFrame;
    procedure CleanD3D;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  InitD3D(Self.Handle);
  RenderFrame;
end;

procedure TForm1.CleanD3D;
begin
  FD3D := nil;
  FDevice := nil;
end;

procedure TForm1.InitD3D(AHandle: THandle);
var
  parms : D3DPRESENT_PARAMETERS ;
  hr : HRESULT ;
begin
  //memo1.Clear;
  FD3D := Direct3DCreate9 ( D3D_SDK_VERSION ) ;

  ZeroMemory(@parms, SizeOf(parms));
  parms.BackBufferWidth := 640 ;
  parms.BackBufferHeight := 480 ;
  parms.BackBufferFormat := D3DFMT_A8R8G8B8 ;
  parms.BackBufferCount := 1 ;
  parms.MultiSampleType := D3DMULTISAMPLE_NONE ;
  parms.SwapEffect := D3DSWAPEFFECT_DISCARD ;
  parms.Windowed := TRUE ;
  parms.hDeviceWindow := AHandle;
  parms.EnableAutoDepthStencil := FALSE ;
  parms.AutoDepthStencilFormat := D3DFMT_UNKNOWN ;
  parms.Flags := 0 ;
  parms.FullScreen_RefreshRateInHz := 0 ;
  //parms.FullScreen_PresentationInterval := D3DPRESENT_INTERVAL_DEFAULT ;

  hr := FD3D.CreateDevice(D3DADAPTER_DEFAULT,
    D3DDEVTYPE_HAL,
    Self.Handle,
    D3DCREATE_SOFTWARE_VERTEXPROCESSING,
    @parms,
    FDevice) ;
end;

procedure TForm1.RenderFrame;
begin
  FDevice.Clear(0, nil, D3DCLEAR_TARGET, D3DCOLOR_XRGB(0, 40, 100), 1.0, 0);
  FDevice.BeginScene;

  FDevice.EndScene;
  FDevice.Present(nil, nil, 0, nil);
end;

end.
