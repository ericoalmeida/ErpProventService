unit StateInsert.Controller;

interface

uses State.Controller.Interf, State.Model.Interf, TGERESTADO.Entity.Model, System.SysUtils;

type
  TStateInsertController = class(TInterfacedObject, iStateInsertController)
  private
    FStateModel: IStateModel;
    FName: string;
    FInitials: string;
    FCountryId: string;

    function getStateId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStateInsertController;

    function stateModel(AValue: IStateModel): iStateInsertController;

    function name(AValue: string): iStateInsertController;
    function initials(AValue: string): iStateInsertController;
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

function TStateInsertController.name(AValue: string): iStateInsertController;
begin
  Result := Self;
  FName := AValue;
end;

destructor TStateInsertController.Destroy;
begin

  inherited;
end;

function TStateInsertController.getStateId: Integer;
begin
  if FStateModel.DAO.Find.Count <> 0 then begin
    Result := FStateModel.DAO.FindWhere('', 'STATEID desc').Last.STATEID + 1;
  end else begin
    Result := 1;
  end;
end;

class function TStateInsertController.New: iStateInsertController;
begin
  Result := Self.Create;
end;

procedure TStateInsertController.save;
begin
  FStateModel.Entity(TTMNGSTATE.Create);

  FStateModel.Entity.STATEID    := getStateId;
  FStateModel.Entity.NAME       := FName;
  FStateModel.Entity.COUNTRYID  := FCountryId;
  FStateModel.Entity.INITIALS   := FInitials;
  FStateModel.Entity.CREATEDAT  := Now;
  FStateModel.Entity.UPDATEDAT  := Now;

  FStateModel.DAO.Insert(FStateModel.Entity);
end;

function TStateInsertController.initials(AValue: string): iStateInsertController;
begin
  Result := Self;
  FInitials := AValue;
end;

function TStateInsertController.stateModel(AValue: IStateModel): iStateInsertController;
begin
  Result := Self;
  FStateModel := AValue;
end;

end.
