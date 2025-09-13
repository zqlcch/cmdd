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

// 判断系统是否为中文环境
function IsChineseLocale: Boolean;
begin
  // 简体中文 LCID 为 $0804，繁体中文为 $0404
  Result := (GetUserDefaultLCID = $0804) or (GetUserDefaultLCID = $0404);
end;

class procedure TAdminCmdLauncher.Launch;
var
  SEInfo: TShellExecuteInfo;
  CmdLine: string;
  CurrentDir: string;
  Title: string;
begin
  // 获取当前目录
  CurrentDir := GetCurrentDir;

  // 根据语言环境设置标题
  if IsChineseLocale then
    Title := 'By 不断成长的极光ROM'
  else
    Title := 'By AuroraROM';

  // 构造命令行：设置标题并切换到当前目录
  // 使用title命令设置标题，&符号用于连接多个命令
  CmdLine := Format('/k title %s & cd /d "%s"', [Title, CurrentDir]);

  // 初始化启动信息结构体
  ZeroMemory(@SEInfo, SizeOf(SEInfo));
  SEInfo.cbSize := SizeOf(SEInfo);
  SEInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  SEInfo.Wnd := 0;
  SEInfo.lpVerb := 'runas';  // 管理员权限
  SEInfo.lpFile := 'cmd.exe';
  SEInfo.lpParameters := PChar(CmdLine);
  SEInfo.lpDirectory := PChar(CurrentDir);
  SEInfo.nShow := SW_SHOWNORMAL;

  // 执行启动
  if not ShellExecuteEx(@SEInfo) then
    RaiseLastOSError;
end;

end.

