program prj_dtime;

uses
  Forms,
  u_dtime_main in 'u_dtime_main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
