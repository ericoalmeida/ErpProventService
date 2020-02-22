unit StateUpdate.Controller;

interface

uses State.Controller.Interf, State.Model.Interf, TMNGSTATE.Entity.Model, System.SysUtils;

type
  TStateUpdateController = class(TInterfacedObject, iStateUpdateController)
  private
   FStateModel: IStateModel;
   FSelectedRecord: TTMNGSTATE;

   FName     : string;
   FInitials    : string;
   FCountryId: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStateUpdateController;

    function stateModel(AValue: IStateModel): iStateUpdateController;
    function selectedRecord(AValue: TTMNGSTATE): iStateUpdateController;

    function name(AValue: string): iStateUpdateController;
    function initials(AValue: string): iStateUpdateController;

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

function TStateUpdateController.name(AValue: string): iStateUpdateController;
begin
 Result := Self;
 FName := AValue;
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

  FSelectedRecord.NAME      := FName;
  FSelectedRecord.COUNTRYID := FCountryId;
  FSelectedRecord.INITIALS  := FInitials;
  FSelectedRecord.UPDATEDAT := Now;

  FStateModel.DAO.Update(FSelectedRecord);
end;

function TStateUpdateController.selectedRecord(AValue: TTMNGSTATE): iStateUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

function TStateUpdateController.initials(AValue: string): iStateUpdateController;
begin
  Result := Self;
  FInitials := AValue;
end;

end.
