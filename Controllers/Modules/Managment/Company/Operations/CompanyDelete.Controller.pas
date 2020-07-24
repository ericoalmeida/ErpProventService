unit CompanyDelete.Controller;

interface

uses Company.Controller.Interf, TMNGCOMPANY.Entity.Model,
   Company.Model.Interf, Base.View.Interf;

type
   TCompanyDeleteController = class(TInterfacedObject, iCompanyDeleteController)
   private
      FMessageConfirm: iBaseMessageView;

      FCompanyModel: ICompanyModel;
      FSelectedRecord: TTMNGCOMPANY;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iCompanyDeleteController;

      function companyModel(AValue: ICompanyModel): iCompanyDeleteController;
      function selectedRecord(AValue: TTMNGCOMPANY): iCompanyDeleteController;

      procedure save;
   end;

implementation

{ TCompanyDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TCompanyDeleteController.Create;
begin
   FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
     (tmConfirmation);
end;

destructor TCompanyDeleteController.Destroy;
begin

   inherited;
end;

function TCompanyDeleteController.companyModel(AValue: ICompanyModel)
  : iCompanyDeleteController;
begin
   Result := Self;
   FCompanyModel := AValue;
end;

class function TCompanyDeleteController.New: iCompanyDeleteController;
begin
   Result := Self.Create;
end;

procedure TCompanyDeleteController.save;
begin
   if FMessageConfirm.messages(Format('Deseja excluir a empresa %s ?',
     [FSelectedRecord.FANCYNAME])).&end then
   begin

      try
         FCompanyModel.DAO.Delete(FSelectedRecord);

      except
         on E: Exception do
            raise Exception.Create(Format('A empresa %s não pode ser excluído!',
              [FSelectedRecord.FANCYNAME]));
      end;

   end;
end;

function TCompanyDeleteController.selectedRecord(AValue: TTMNGCOMPANY)
  : iCompanyDeleteController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

end.
