unit ConnectionFactory.Model.Interf;

interface

uses Connection.Model.Interf, Types.Models;

type
 iConnectionFactoryModel = interface
   ['{593EB348-CB71-44E3-A0B2-71FCD848E10A}']
   function connectionWithDatabase(AValue: TTypesConnection): iConnectionModel;
 end;

implementation

end.
