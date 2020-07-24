unit Company.Controller.Interf;

interface

uses Company.Model.Interf, TMNGCOMPANY.Entity.Model;

type
   iCompanyInsertController = interface;
   iCompanyUpdateController = interface;
   iCompanyDeleteController = interface;
   iCompanyDuplicateController = interface;

   iCompanyController = interface
      function find(AValue: string): iCompanyController;

      function insert: iCompanyInsertController;
      function update: iCompanyUpdateController;
      function delete: iCompanyDeleteController;
      function duplicate: iCompanyDuplicateController;

      function code: string;
      function companyId: string;
      function name: string;
      function fancyName: string;
      function cpfcnpj: string;
      function rgie: string;
      function address: string;
      function districtId: string;
      function districtName: string;
      function phoneNumber: string;
      function email: string;
      function createdAt: string;
      function updatedAt: string;
   end;

   iCompanyInsertController = interface
      function companyModel(AValue: ICompanyModel): iCompanyInsertController;

      function name(AValue: string): iCompanyInsertController;
      function fancyName(AValue: string): iCompanyInsertController;
      function cpfcnpj(AValue: string): iCompanyInsertController;
      function rgie(AValue: string): iCompanyInsertController;
      function address(AValue: string): iCompanyInsertController;
      function districtId(AValue: string): iCompanyInsertController;
      function phoneNumber(AValue: string): iCompanyInsertController;
      function email(AValue: string): iCompanyInsertController;

      procedure save;
   end;

   iCompanyUpdateController = interface
      function companyModel(AValue: ICompanyModel): iCompanyUpdateController;
      function selectedRecord(AValue: TTMNGCOMPANY): iCompanyUpdateController;

      function name(AValue: string): iCompanyUpdateController;
      function fancyName(AValue: string): iCompanyUpdateController;
      function cpfcnpj(AValue: string): iCompanyUpdateController;
      function rgie(AValue: string): iCompanyUpdateController;
      function address(AValue: string): iCompanyUpdateController;
      function districtId(AValue: string): iCompanyUpdateController;
      function phoneNumber(AValue: string): iCompanyUpdateController;
      function email(AValue: string): iCompanyUpdateController;

      procedure save;
   end;

   iCompanyDeleteController = interface
      function companyModel(AValue: ICompanyModel): iCompanyDeleteController;
      function selectedRecord(AValue: TTMNGCOMPANY): iCompanyDeleteController;

      procedure save;
   end;

   iCompanyDuplicateController = interface
      function companyModel(AValue: ICompanyModel): iCompanyDuplicateController;

      function name(AValue: string): iCompanyDuplicateController;
      function fancyName(AValue: string): iCompanyDuplicateController;
      function cpfcnpj(AValue: string): iCompanyDuplicateController;
      function rgie(AValue: string): iCompanyDuplicateController;
      function address(AValue: string): iCompanyDuplicateController;
      function districtId(AValue: string): iCompanyDuplicateController;
      function phoneNumber(AValue: string): iCompanyDuplicateController;
      function email(AValue: string): iCompanyDuplicateController;

      procedure save;
   end;

implementation

end.
