unit uSingleton;

interface
uses
Generics.collections, Winapi.Windows, FMX.Forms;
type
TSingleton<T: class, constructor> = class
  strict private
    class var FInstance : T;
  public
    procedure LimpaMemoria;
    class function GetInstance(): T;
    class procedure ReleaseInstance();
  end;

implementation

{ TSingleton<T> }

class function TSingleton<T>.GetInstance: T;
begin
  if not Assigned(Self.FInstance) then
    Self.FInstance := T.Create();
  Result := Self.FInstance;
end;

procedure TSingleton<T>.LimpaMemoria;
var
  MainHandle: THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
  except
  end;
  Application.ProcessMessages;

end;

class procedure TSingleton<T>.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
    Self.FInstance.Free;
end;

end.

