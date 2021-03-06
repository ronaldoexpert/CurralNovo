unit untCadastroTipoProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmCadastroTipoProdutor = class(TForm)
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    pnlCentro: TPanel;
    lblDescricao: TLabel;
    lblCodigo: TLabel;
    btnPesquisar: TBitBtn;
    edtDescricao: TDBEdit;
    edtCodigo: TEdit;
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroTipoProdutor: TfrmCadastroTipoProdutor;

implementation

{$R *.dfm}

procedure TfrmCadastroTipoProdutor.btnFecharClick(Sender: TObject);
begin
  close;
end;

end.
