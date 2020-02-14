unit StateInsert.Controller;

interface

uses State.Controller.Interf, State.Model.Interf, TGERESTADO.Entity.Model;

type
  TStateInsertController = class(TInterfacedObject, iStateInsertController)
  private
    FStateModel: IStateModel;
    FDescription: string;
    FCountryId: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStateInsertController;

    function stateModel(AValue: IStateModel): iStateInsertController;

    function description(AValue: string): iStateInsertController;
    function countryId(AValue: string): iStateInsertController;

    procedure save;
  end;

implementation

{ TStateInsertController }

function TStateInsertController.countryId(AValue: string): iStateInsertController;
begin
 Result := Self;
 FCountryId := AValue;
end;

constructor TStateInsertController.Create;
begin

end;

function TStateInsertController.description(AValue: string): iStateInsertController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TStateInsertController.Destroy;
begin

  inherited;
end;

class function TStateInsertController.New: iStateInsertController;
begin
  Result := Self.Create;
end;

procedure TStateInsertController.save;
begin
  FStateModel.Entity(TTGERESTADO.Create);

  FStateModel.Entity.DESCRICAO := FDescription;
  FStateModel.Entity.PAISID    := FCountryId;

  FStateModel.DAO.Insert(FStateModel.Entity);
end;

function TStateInsertController.stateModel(AValue: IStateModel): iStateInsertController;
begin
  Result := Self;
  FStateModel := AValue;
end;

end.
