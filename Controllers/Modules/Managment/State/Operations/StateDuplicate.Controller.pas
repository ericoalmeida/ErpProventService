unit StateDuplicate.Controller;

interface

uses State.Controller.Interf, State.Model.Interf, TGERESTADO.Entity.Model;

type
  TStateDuplicateController = class(TInterfacedObject, iStateDuplicateController)
  private
    FStateModel: IStateModel;

    FDescription: string;
    FCountryId: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStateDuplicateController;

    function stateModel(AValue: IStateModel): iStateDuplicateController;

    function description(AValue: string): iStateDuplicateController;
    function countryId(AValue: string): iStateDuplicateController;

    procedure save;
  end;

implementation

{ TStateDuplicateController }

function TStateDuplicateController.countryId(AValue: string): iStateDuplicateController;
begin
 Result := Self;
 FCountryId := AValue;
end;

constructor TStateDuplicateController.Create;
begin

end;

function TStateDuplicateController.description(AValue: string): iStateDuplicateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TStateDuplicateController.Destroy;
begin

  inherited;
end;

class function TStateDuplicateController.New: iStateDuplicateController;
begin
  Result := Self.Create;
end;

procedure TStateDuplicateController.save;
begin
  FStateModel.Entity(TTGERESTADO.Create);

  FStateModel.Entity.DESCRICAO := FDescription;
  FStateModel.Entity.PAISID    := FCountryId;

  FStateModel.DAO.Insert(FStateModel.Entity);
end;

function TStateDuplicateController.stateModel(AValue: IStateModel): iStateDuplicateController;
begin
  Result := Self;
  FStateModel := AValue;
end;

end.
