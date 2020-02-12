unit Districts.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TGERBAIRRO.Entity.Model;

type
  iDistrictModel = interface
    ['{1A795610-F28A-45B3-A5C0-1CD4F35E06F8}']
    function Entity: TTGERBAIRRO; overload;
    function Entity(AValue: TTGERBAIRRO): iDistrictModel; overload;
    function DAO: IContainerObjectSet<TTGERBAIRRO>;
  end;

implementation

end.
