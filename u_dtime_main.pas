unit u_dtime_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmDTime = class(TForm)
    Timer1: TTimer;
    lblShow: TLabel;
    btnStart: TButton;
    btnStop: TButton;
    edtSJ: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    chkAutoStart: TCheckBox;
    mOutput: TMemo;
    Label3: TLabel;
    edtStopTime: TEdit;
    Label4: TLabel;
    chkAutoStartDS: TCheckBox;
    Panel1: TPanel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
    f_all_sj_s :integer;
    f_p_date:TDateTime;
    f_cnt :Integer;
    f_cur_ds :boolean; // 当前是定时还是休息
  public
    { Public declarations }
    procedure showInfo(const I_Msg:string);
    procedure showTo();
    function getTimeFmt(i_sj :integer):string;
    procedure output(i_msg :string);
    function getdsStr():string;
  end;

var
  frmDTime: TfrmDTime;

implementation

{$R *.dfm}

procedure TfrmDTime.showTo;
var OldPt,NewPt:TPoint;
begin
  //判断Application是否最小化，而不是主窗口的Handle, 使用Restore来还原
  if f_cur_ds then begin
    if (IsIconic(Application.Handle)) then  begin
        Application.Restore;
        Application.MainForm.WindowState := wsMaximized;
    end;

    SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
    SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
    //保存鼠标位置，模拟点击窗口，然后再还原鼠标位置
    GetCursorPos(OldPt);
    NewPt := Point(0, 0);
    Windows.ClientToScreen(Handle, NewPt);
    SetCursorPos(NewPt.X, NewPt.Y);
    mouse_event(MOUSEEVENTF_LEFTDOWN, NewPt.X, NewPt.Y, 0, 0);
    mouse_event(MOUSEEVENTF_LEFTUP, NewPt.X, NewPt.Y, 0, 0);
    SetCursorPos(OldPt.X, OldPt.Y);

    Position := poScreenCenter;
  end else begin
    Application.MainForm.WindowState := wsMinimized;
  end;
end;

procedure TfrmDTime.Timer1Timer(Sender: TObject);
begin
  f_cnt := f_cnt + 1;
  if f_cnt>=f_all_sj_s then begin
    btnStopClick(Sender);
    showInfo('');
    showTo();
    output(Format('完成 %s 开始时间:%s  结束时间:%s  共 %d 秒 %s'
      ,[ getdsStr(),FormatDateTime('yyyy-mm-dd hh:mm:ss',f_p_date)
      ,  FormatDateTime('yyyy-mm-dd hh:mm:ss',Now()), f_cnt, getTimeFmt(f_cnt) ]));
    //ShowMessage('指定的定时时间已到，请注意休息！');
    if f_cur_ds then
      output('指定的 定时 时间已到，请注意休息！')
    else
      output('指定的 休息 时间已到，请开始工作！');

    if (f_cur_ds and chkAutoStart.Checked)
      or (not f_cur_ds and chkAutoStartDS.Checked) then begin
      f_cur_ds := not f_cur_ds;
      btnStartClick(Sender);
    end;
  end;

  showInfo('');
end;

procedure TfrmDTime.FormCreate(Sender: TObject);
begin
  btnStopClick(Sender);
  Position := poScreenCenter;
  f_cur_ds := true; // 最开始时定时
end;

procedure TfrmDTime.showInfo(const I_Msg:string);
begin
  lblShow.Caption := Format('%s'#13#10'开始时间:%s'#13#10'当前时间:%s'#13#10'已过 %d 秒  剩余 %d 秒'#13#10'已过 %s 剩余 %s'+ I_Msg
    ,[getdsStr(), FormatDateTime('yyyy-mm-dd hh:mm:ss',f_p_date)
    ,  FormatDateTime('yyyy-mm-dd hh:mm:ss',Now()), f_cnt,f_all_sj_s-f_cnt, getTimeFmt(f_cnt), getTimeFmt(f_all_sj_s-f_cnt)]) ;
end;

function TfrmDTime.getTimeFmt(i_sj: integer): string;
var
  h,m  :integer;
begin
  Result := '';
  h := i_sj div 3600;
  if h>0 then i_sj := i_sj - h*3600;
  m := i_sj div 60;
  if m>0 then i_sj := i_sj - m*60;

  Result := format('%.2d:%.2d:%.2d',[h,m,i_sj]);
end;

procedure TfrmDTime.btnStartClick(Sender: TObject);
var
  s :string;
  sj :Extended;
begin
  btnStop.Click;

  if f_cur_ds then
    s := Trim(edtSJ.Text)
  else
    s := Trim(edtStopTime.Text);

  sj := StrToFloatDef(s,30);
  if sj<0.05 then sj :=0.05;
  if sj>10000 then sj := 10000;

  if f_cur_ds then
    edtSJ.Text := FloatToStr(sj)
  else
    edtStopTime.Text := FloatToStr(sj);

  f_p_date := Now();
  f_cnt := 0;
  f_all_sj_s := Trunc( sj*60 );
  btnStop.Enabled := true;
  btnStart.Enabled := False;
  Timer1.Enabled := true;
  output('开始'+getdsStr());
end;

procedure TfrmDTime.btnStopClick(Sender: TObject);
begin
  if not btnStop.Enabled then Exit;
  btnStop.Enabled := false;
  btnStart.Enabled := true;
  Timer1.Enabled := false;
  output('停止'+getdsStr());
end;

procedure TfrmDTime.output(i_msg: string);
begin
  mOutput.Lines.Insert(0,FormatDateTime('yyyy-mm-dd hh:mm:ss',now())
    + ' ' + i_msg);
  SendMessage(mOutput.Handle,WM_VSCROLL,SB_TOP,0); // 滚动到最上行
end;

function TfrmDTime.getdsStr: string;
begin
  if f_cur_ds then
    Result := '定时'
  else
    Result := '休息';
end;

end.
