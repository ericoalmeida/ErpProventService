unit DataMFirebird.Model;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  Data.DB, FireDAC.Comp.Client, Connection.Model.Interf, ormbr.Factory.Interfaces,
  ormbr.Factory.FireDAC,
  ormbr.dml.Generator.Firebird, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, ConnectionSettings.Model.interf;

type
  TFDataMFirebird = class(TDataModule, iConnectionModel)
    FDatabase: TFDConnection;
    DriverLink: TFDPhysFBDriverLink;
    WaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FSettings: iConnectionSettingsModel;
    FConnection: IDBConnection;

    procedure conectaNoBancoDeDados;
  public
    { Public declarations }

    class function New: iConnectionModel;

    function dbConnection: IDBConnection;
    function fdConnection: TFDConnection;
  end;

var
  FDataMFirebird: TFDataMFirebird;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Facade.Model;
{$R *.dfm}
{ TFDataMFirebird }

procedure TFDataMFirebird.conectaNoBancoDeDados;
begin
  FSettings := TFacadeModel.New.SettingsFactoryModel.connection;

  try
    FDatabase.Connected := false;
    FDatabase.LoginPrompt := false;
    FDatabase.DriverName := FSettings.driver;
    FDatabase.Params.Database := FSettings.database;
    FDatabase.Params.Add('server=' + FSettings.server);
    FDatabase.Params.Add('port=' + FSettings.port);
    FDatabase.Params.Add('username=' + FSettings.user);
    FDatabase.Params.Add('password=' + FSettings.password);
    FDatabase.Connected := true;

    DriverLink.VendorLib := FSettings.lib;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TFDataMFirebird.dbConnection: IDBConnection;
begin
  Result := FConnection;
end;

function TFDataMFirebird.fdConnection: TFDConnection;
begin
  Result := FDatabase;
end;

procedure TFDataMFirebird.DataModuleCreate(Sender: TObject);
begin
  conectaNoBancoDeDados;

  FConnection := TFactoryFireDAC.Create(FDatabase, dnFirebird);
end;

class function TFDataMFirebird.New: iConnectionModel;
begin
  Result := Self.Create(nil);
end;

end.
