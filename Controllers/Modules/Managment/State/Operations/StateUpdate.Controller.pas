unit StateUpdate.Controller;

interface

uses State.Controller.Interf, State.Model.Interf, TGERESTADO.Entity.Model;

type
  TStateUpdateController = class(TInterfacedObject, iStateUpdateController)
  private
   FStateModel: IStateModel;
   FSelectedRecord: TTGERESTADO;

   FDescription : string;
   FCountryId: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStateUpdateController;

    function stateModel(AValue: IStateModel): iStateUpdateController;
    function selectedRecord(AValue: TTGERESTADO): iStateUpdateController;

    function description(AValue: string): iStateUpdateController;
    function countryId(AValue: string): iStateUpdateController;

    procedure save;
  end;

implementation

{ TStateUpdateController }

function TStateUpdateController.stateModel(AValue: IStateModel): iStateUpdateController;
begin
  Result := Self;
  FStateModel := AValue;
end;

function TStateUpdateController.countryId(AValue: string): iStateUpdateController;
begin
 Result := Self;
 FCountryId := AValue;
end;

constructor TStateUpdateController.Create;
begin

end;

function TStateUpdateController.description(AValue: string): iStateUpdateController;
begin
 Result := Self;
 FDescription := AValue;
end;

destructor TStateUpdateController.Destroy;
begin

  inherited;
end;

class function TStateUpdateController.New: iStateUpdateController;
begin
  Result := Self.Create;
end;

procedure TStateUpdateController.save;
begin
  FStateModel.DAO.Modify(FSelectedRecord);

  FSelectedRecord.DESCRICAO := FDescription;
  FSelectedRecord.PAISID := FCountryId;

  FStateModel.DAO.Update(FSelectedRecord);
end;

function TStateUpdateController.selectedRecord(AValue: TTGERESTADO): iStateUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.
