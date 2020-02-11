unit ConnectionFactory.Model;

interface

uses ConnectionFactory.Model.Interf, Connection.Model.Interf, Types.Models;

type
  TConnectionFactoryModel = class(TInterfacedObject, iConnectionFactoryModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iConnectionFactoryModel;

    function connectionWithDatabase(AValue: TTypesConnection): iConnectionModel;

  end;

implementation

{ TConnectionFactoryModel }

uses DataMFirebird.Model;

function TConnectionFactoryModel.connectionWithDatabase(AValue: TTypesConnection): iConnectionModel;
begin
  case AValue of
    dbFirebird    : Result := TFDataMFirebird.New;
    // dbSQLite   :  ;
    // dbMongoDB  :  ;
    // dbMySQL    :  ;
    // dbPostgres :  ;
  end;
end;

constructor TConnectionFactoryModel.Create;
begin

end;

destructor TConnectionFactoryModel.Destroy;
begin

  inherited;
end;

class function TConnectionFactoryModel.New: iConnectionFactoryModel;
begin
  Result := Self.Create
end;

end.
