unit untCadastroServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmCadastroServico = class(TForm)
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    pnlCentro: TPanel;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    lblCodigo: TLabel;
    btnPesquisar: TBitBtn;
    edtDescricao: TDBEdit;
    edtCodigo: TEdit;
    edtValorUnit: TDBEdit;
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroServico: TfrmCadastroServico;

implementation

{$R *.dfm}

procedure TfrmCadastroServico.btnFecharClick(Sender: TObject);
begin
  close;
end;

end.
