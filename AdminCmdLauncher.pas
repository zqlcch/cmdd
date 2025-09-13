unit AdminCmdLauncher;

interface

uses
  Windows, ShellAPI, SysUtils;

type
  TAdminCmdLauncher = class
  public
    class procedure Launch; static;
  end;

implementation

// �ж�ϵͳ�Ƿ�Ϊ���Ļ���
function IsChineseLocale: Boolean;
begin
  // �������� LCID Ϊ $0804����������Ϊ $0404
  Result := (GetUserDefaultLCID = $0804) or (GetUserDefaultLCID = $0404);
end;

class procedure TAdminCmdLauncher.Launch;
var
  SEInfo: TShellExecuteInfo;
  CmdLine: string;
  CurrentDir: string;
  Title: string;
begin
  // ��ȡ��ǰĿ¼
  CurrentDir := GetCurrentDir;

  // �������Ի������ñ���
  if IsChineseLocale then
    Title := 'By ���ϳɳ��ļ���ROM'
  else
    Title := 'By AuroraROM';

  // ���������У����ñ��Ⲣ�л�����ǰĿ¼
  // ʹ��title�������ñ��⣬&�����������Ӷ������
  CmdLine := Format('/k title %s & cd /d "%s"', [Title, CurrentDir]);

  // ��ʼ��������Ϣ�ṹ��
  ZeroMemory(@SEInfo, SizeOf(SEInfo));
  SEInfo.cbSize := SizeOf(SEInfo);
  SEInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  SEInfo.Wnd := 0;
  SEInfo.lpVerb := 'runas';  // ����ԱȨ��
  SEInfo.lpFile := 'cmd.exe';
  SEInfo.lpParameters := PChar(CmdLine);
  SEInfo.lpDirectory := PChar(CurrentDir);
  SEInfo.nShow := SW_SHOWNORMAL;

  // ִ������
  if not ShellExecuteEx(@SEInfo) then
    RaiseLastOSError;
end;

end.

