unit State.Controller;

interface

uses State.Controller.Interf, State.Model.Interf, TGERESTADO.Entity.Model,
  System.SysUtils;

type
  TStateController = class(TInterfacedObject, iStateController)
  private
    FStateModel: IStateModel;
    FRecordFound: TTGERESTADO;
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
    function description: string;
    function countryId: string;
    function countryDescription: string;
    function createdDate: string;
    function updatedDate: string;
  end;

implementation

{ TStateController }

uses Facade.Model, StateInsert.Controller, StateUpdate.Controller,
  StateDelete.Controller, StateDuplicate.Controller;

function TStateController.code: string;
begin
 Result := FRecordFound.CODIGO;
end;

function TStateController.countryDescription: string;
begin
  Result := FRecordFound.TGERPAIS.DESCRICAO;
end;

function TStateController.countryId: string;
begin
  Result := FRecordFound.TGERPAIS.PAISID.ToString;
end;

constructor TStateController.Create;
begin
  FStateModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.
    stateModel;
end;

function TStateController.createdDate: string;
begin
  Result := DateTimeToStr(FRecordFound.DATACADASTRO);
end;

function TStateController.delete: iStateDeleteController;
begin
  Result := TStateDeleteController.New.stateModel(FStateModel)
    .selectedRecord(FRecordFound);
end;

function TStateController.description: string;
begin
  Result := FRecordFound.DESCRICAO;
end;

destructor TStateController.Destroy;
begin

  inherited;
end;

function TStateController.duplicate: iStateDuplicateController;
begin
  Result := TStateDuplicateController.New.stateModel(FStateModel);
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
  Result := FRecordFound.ESTADOID.ToString;
end;

function TStateController.find(AValue: string): iStateController;
begin
  Result := Self;

  FRecordFound := FStateModel.DAO.FindWhere
    (Format('CODIGO = %s', [QuotedStr(AValue)])).Items[0];
end;

function TStateController.findById(AValue: string): iStateController;
begin
  Result := Self;

  FRecordFound := FStateModel.DAO.FindWhere
    (Format('ESTADOID = %s', [QuotedStr(AValue)])).Items[0];
end;

function TStateController.update: iStateUpdateController;
begin
  Result := TStateUpdateController.New.stateModel(FStateModel)
    .selectedRecord(FRecordFound);
end;

function TStateController.updatedDate: string;
begin
  Result := DateTimeToStr(FRecordFound.DATAATUALIZACAO);
end;

end.
