unit ConnectionSettings.Model;

interface

uses ConnectionSettings.Model.interf, IniFiles, System.SysUtils;

type
  TConnectionSettingsModel = class(TInterfacedObject,
    iConnectionSettingsModel)
  private
    FFileName: string;
    FFileIni: TIniFile;

    procedure verifyParametersConnection;
    procedure saveParametersDefaultConnection;
  public
    constructor Create;
    destructor Destroy; override;

    class function new: iConnectionSettingsModel;

    function typeDatabase: integer;
    function driver: string;
    function database: string;
    function server: string;
    function port: string;
    function user: string;
    function password: string;
    function lib: string;
  end;

implementation

{ TConnectionSettingsModel }

function TConnectionSettingsModel.database: string;
begin
  Result := FFileIni.ReadString('Settings', 'Database', '');
end;

function TConnectionSettingsModel.lib: string;
begin
  Result := FFileIni.ReadString('Settings', 'Library', '');
end;

constructor TConnectionSettingsModel.Create;
begin
  FFileName := ChangeFileExt(ParamStr(0), '.ini');
  FFileIni := TIniFile.Create(FFileName);

  verifyParametersConnection;
end;

destructor TConnectionSettingsModel.Destroy;
begin
  FFileName := '';
  FFileIni.Free;
  inherited;
end;

function TConnectionSettingsModel.driver: string;
begin
  Result := FFileIni.ReadString('Settings', 'Driver', 'FB');
end;

procedure TConnectionSettingsModel.saveParametersDefaultConnection;
begin
  FFileIni.WriteInteger('Settings', 'TypeDatabase', 0);

  FFileIni.WriteString('Settings', 'Database', 'c:\ergsis\dados\ergdados.fdb');
  FFileIni.WriteString('Settings', 'Driver',   'FB');
  FFileIni.WriteString('Settings', 'Port',     '3050');
  FFileIni.WriteString('Settings', 'Server',   'localhost');
  FFileIni.WriteString('Settings', 'User',     'SYSDBA');
  FFileIni.WriteString('Settings', 'Pasword',  'masterkey');
  FFileIni.WriteString('Settings', 'Library',  'fbclient.dll');
end;

class function TConnectionSettingsModel.new: iConnectionSettingsModel;
begin
  Result := Self.Create;
end;

function TConnectionSettingsModel.port: string;
begin
  Result := FFileIni.ReadString('Settings', 'Port', '');
end;

function TConnectionSettingsModel.password: string;
begin
  Result := FFileIni.ReadString('Settings', 'Password', '');
end;

function TConnectionSettingsModel.server: string;
begin
  Result := FFileIni.ReadString('Settings', 'Server', '');
end;

function TConnectionSettingsModel.typeDatabase: integer;
begin
  Result := FFileIni.ReadInteger('Settings', 'TypeDatabase', 0);
end;

function TConnectionSettingsModel.user: string;
begin
  Result := FFileIni.ReadString('Settings', 'User', '');
end;

procedure TConnectionSettingsModel.verifyParametersConnection;
begin
  if not(FileExists(FFileName)) then
    saveParametersDefaultConnection;

  if FileExists(FFileName) then
    if (FFileIni.ReadString('Settings', 'database', '') = EmptyStr) then
      saveParametersDefaultConnection;
end;

end.
