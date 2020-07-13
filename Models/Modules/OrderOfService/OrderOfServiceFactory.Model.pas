unit OrderOfServiceFactory.Model;

interface

uses OrderOfServiceFactory.Model.Interf, Service.Model.Interf,
  Operators.Model.Interf, ServiceProvided.Model.Interf, Budget.Model.Interf;

type
  TOrderOfServiceFactoryModel = class(TInterfacedObject,
    IOrderOfServiceFactoryModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: IOrderOfServiceFactoryModel;

    function serviceModel: IServiceModel;
    function operatorModel: IOperatorModel;
    function serviceProvidedModel: IServiceProvidedModel;
    function budgetModel: IBudgetModel;

  end;

implementation

{ TOrderOfServiceFactoryModel }

uses Service.Model, Operators.Model, ServiceProvided.Model, Budget.Model;

function TOrderOfServiceFactoryModel.budgetModel: IBudgetModel;
begin
  Result := TBudgetModel.New;
end;

constructor TOrderOfServiceFactoryModel.Create;
begin

end;

destructor TOrderOfServiceFactoryModel.Destroy;
begin

  inherited;
end;

class function TOrderOfServiceFactoryModel.New: IOrderOfServiceFactoryModel;
begin
  Result := Self.Create;
end;

function TOrderOfServiceFactoryModel.operatorModel: IOperatorModel;
begin
  Result := TOperatorModel.New;
end;

function TOrderOfServiceFactoryModel.serviceModel: IServiceModel;
begin
  Result := TServiceModel.New;
end;

function TOrderOfServiceFactoryModel.serviceProvidedModel
  : IServiceProvidedModel;
begin
  Result := TServiceProvidedModel.New;
end;

end.
