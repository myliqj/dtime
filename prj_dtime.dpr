program prj_dtime;

uses
  Forms,
  u_dtime_main in 'u_dtime_main.pas' {frmDTime};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�Զ��嶨ʱ��';
  Application.CreateForm(TfrmDTime, frmDTime);
  Application.Run;
end.
