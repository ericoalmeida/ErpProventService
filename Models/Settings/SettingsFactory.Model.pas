unit SettingsFactory.Model;

interface

uses SettingsFactory.Model.interf, ConnectionSettings.Model.interf;


type
  TSettingsFactoryModel = class(TInterfacedObject,
    iSettingsFactoryModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iSettingsFactoryModel;

    function connection: iConnectionSettingsModel;
  end;

implementation

{ TSettingsFactoryModel }

uses ConnectionSettings.Model;


function TSettingsFactoryModel.connection: iConnectionSettingsModel;
begin
  Result := TConnectionSettingsModel.new;
end;

constructor TSettingsFactoryModel.Create;
begin

end;

destructor TSettingsFactoryModel.Destroy;
begin

  inherited;
end;

class function TSettingsFactoryModel.New: iSettingsFactoryModel;
begin
  Result := Self.Create;
end;

end.
