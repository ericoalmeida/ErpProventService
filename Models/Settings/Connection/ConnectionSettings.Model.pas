unit ConnectionSettings.Model;

interface

uses ConnectionSettings.Model.interf, IniFiles, System.SysUtils;

type
   TConnectionSettingsModel = class(TInterfacedObject, iConnectionSettingsModel)
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
   Result := FFileIni.ReadString('Settings', 'database', '');
end;

function TConnectionSettingsModel.lib: string;
begin
   Result := FFileIni.ReadString('Settings', 'library', '');
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
   Result := FFileIni.ReadString('Settings', 'driver', 'FB');
end;

procedure TConnectionSettingsModel.saveParametersDefaultConnection;
begin
   FFileIni.WriteInteger('Settings', 'typeDatabase', 0);

   FFileIni.WriteString('Settings', 'database', 'c:\ergsis\dados\ergdados.fdb');
   FFileIni.WriteString('Settings', 'driver', 'FB');
   FFileIni.WriteString('Settings', 'port', '3050');
   FFileIni.WriteString('Settings', 'server', 'localhost');
   FFileIni.WriteString('Settings', 'user', 'SYSDBA');
   FFileIni.WriteString('Settings', 'password', 'masterkey');
   FFileIni.WriteString('Settings', 'library', 'fbclient.dll');
end;

class function TConnectionSettingsModel.new: iConnectionSettingsModel;
begin
   Result := Self.Create;
end;

function TConnectionSettingsModel.port: string;
begin
   Result := FFileIni.ReadString('Settings', 'port', '');
end;

function TConnectionSettingsModel.password: string;
begin
   Result := FFileIni.ReadString('Settings', 'password', 'masterkey');
end;

function TConnectionSettingsModel.server: string;
begin
   Result := FFileIni.ReadString('Settings', 'server', '');
end;

function TConnectionSettingsModel.typeDatabase: integer;
begin
   Result := FFileIni.ReadInteger('Settings', 'typeDatabase', 0);
end;

function TConnectionSettingsModel.user: string;
begin
   Result := FFileIni.ReadString('Settings', 'user', 'sysdba');
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
