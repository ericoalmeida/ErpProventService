unit Base.View.interf;

interface

type
  iBaseMessageView = interface
    ['{0FDD5214-2AF9-436E-A091-19C63770AB29}']
    function messages(AValue: string): iBaseMessageView;
    function &end: Boolean;
  end;

implementation

end.
