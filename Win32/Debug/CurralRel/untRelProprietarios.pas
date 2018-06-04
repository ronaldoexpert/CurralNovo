unit untRelProprietarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmRelProprietario = class(TForm)
    pnlPrincipal: TPanel;
    btnImprimir: TBitBtn;
    btnFechar: TBitBtn;
    edtCodProprietario: TEdit;
    edtDescrProprietario: TEdit;
    btnPesquisa: TBitBtn;
    lblProprietario: TLabel;
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelProprietario: TfrmRelProprietario;

implementation

{$R *.dfm}

procedure TfrmRelProprietario.btnFecharClick(Sender: TObject);
begin
  close;
end;

end.
