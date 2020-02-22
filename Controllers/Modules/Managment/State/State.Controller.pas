unit State.Controller;

interface

uses State.Controller.Interf, State.Model.Interf, TMNGSTATE.Entity.Model,
  System.SysUtils;

type
  TStateController = class(TInterfacedObject, iStateController)
  private
    FStateModel: IStateModel;
    FRecordFound: TTMNGSTATE;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStateController;

    function find(AValue: string): iStateController;
    function findById(AValue: string): iStateController;

    function insert: iStateInsertController;
    function update: iStateUpdateController;
    function delete: iStateDeleteController;
    function duplicate: iStateDuplicateController;

    function code: string;
    function stateId: string;
    function name: string;
    function initials: string;
    function countryId: string;
    function countryName: string;
    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TStateController }

uses Facade.Model, StateInsert.Controller, StateUpdate.Controller,
  StateDelete.Controller, StateDuplicate.Controller;

function TStateController.code: string;
begin
 Result := FRecordFound.CODE;
end;

function TStateController.countryName: string;
begin
  Result := FRecordFound.TMNGCOUNTRY.NAME;
end;

function TStateController.countryId: string;
begin
  Result := FRecordFound.TMNGCOUNTRY.COUNTRYID.ToString;
end;

constructor TStateController.Create;
begin
  FStateModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.
    stateModel;
end;

function TStateController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.CREATEDAT);
end;

function TStateController.delete: iStateDeleteController;
begin
  Result := TStateDeleteController.New.stateModel(FStateModel)
    .selectedRecord(FRecordFound);
end;

function TStateController.name: string;
begin
  Result := FRecordFound.NAME;
end;

destructor TStateController.Destroy;
begin

  inherited;
end;

function TStateController.duplicate: iStateDuplicateController;
begin
  Result := TStateDuplicateController.New.stateModel(FStateModel);
end;

function TStateController.initials: string;
begin
  Result := FRecordFound.INITIALS;
end;

function TStateController.insert: iStateInsertController;
begin
  Result := TStateInsertController.New.stateModel(FStateModel);
end;

class function TStateController.New: iStateController;
begin
  Result := Self.Create;
end;

function TStateController.stateId: string;
begin
  Result := FRecordFound.STATEID.ToString;
end;

function TStateController.find(AValue: string): iStateController;
begin
  Result := Self;

  FRecordFound := FStateModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TStateController.findById(AValue: string): iStateController;
begin
  Result := Self;

  FRecordFound := FStateModel.DAO.FindWhere
    (Format('STATEID = %s', [QuotedStr(AValue)])).Items[0];
end;

function TStateController.update: iStateUpdateController;
begin
  Result := TStateUpdateController.New.stateModel(FStateModel)
    .selectedRecord(FRecordFound);
end;

function TStateController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.UPDATEDAT);
end;

end.
