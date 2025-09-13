program cmdd;

uses
  Vcl.Forms,
  AdminCmdLauncher in 'AdminCmdLauncher.pas';

{$R *.res}

begin
  Application.Initialize;
  TAdminCmdLauncher.Launch;
  //Application.MainFormOnTaskbar := True;
  //Application.Run;
end.
