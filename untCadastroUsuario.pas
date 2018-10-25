unit untCadastroUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCadastroUsuario = class(TForm)
    pnlRodape: TPanel;
    pnlCentro: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    lblCodigo: TLabel;
    btnPesquisar: TBitBtn;
    edtUsuario: TDBEdit;
    edtSenha: TDBEdit;
    qryUsuario: TFDQuery;
    dtsUsuario: TDataSource;
    edtCodigo: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    fNovo : Boolean;
  public
    { Public declarations }
    procedure CarregaCampos;
    procedure PesquisaUsuario(vStatus : Boolean);
  end;

var
  frmCadastroUsuario: TfrmCadastroUsuario;

implementation

{$R *.dfm}

uses untFuncoes, untDM, untPesquisa, untPrincipal;

procedure TfrmCadastroUsuario.btnExcluirClick(Sender: TObject);
begin
  if fNovo = False then
  begin
    if qryUsuario.RecordCount > 0 then
    begin
      frmFuncoes.Botoes('Excluir', qryUsuario);
    end;
  end;
end;

procedure TfrmCadastroUsuario.btnFecharClick(Sender: TObject);
begin
  qryUsuario.Close;
  qryUsuario.SQL.Clear;
  Close;
end;

procedure TfrmCadastroUsuario.btnGravarClick(Sender: TObject);
begin
  if fNovo = True then
  begin
    qryUsuario.FieldByName('id').AsString := edtCodigo.Text;
  end;

 qryUsuario.FieldByName('CODEMPRESA').AsInteger := frmPrincipal.vEmpresa;        //Versao 1.4 - 14/10/2018

  qryUsuario.ApplyUpdates(-1);
  btnNovo.Enabled := True;
  btnExcluir.Enabled := True;
  edtUsuario.Enabled := True;
  frmFuncoes.AutoIncre('USUARIO', 'Gravar');
  ShowMessage('Cadastro realizado com sucesso.');
end;

procedure TfrmCadastroUsuario.btnNovoClick(Sender: TObject);
begin
  fNovo := True;
  qryUsuario.Insert;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtUsuario.SetFocus;
  edtCodigo.Enabled := False;

  edtCodigo.Text := IntToStr(frmFuncoes.AutoIncre('USUARIO', 'Novo'));
end;

procedure TfrmCadastroUsuario.btnPesquisarClick(Sender: TObject);
begin
  PesquisaUsuario(False);
end;

procedure TfrmCadastroUsuario.CarregaCampos;
begin
  edtUsuario.DataField := 'NOME';
  edtSenha.DataField := 'SENHA';
end;

procedure TfrmCadastroUsuario.edtCodigoExit(Sender: TObject);
begin
  if (Trim(edtCodigo.Text) <> '') and (fNovo = False)  then
  begin
    PesquisaUsuario(True);
  end;
end;

procedure TfrmCadastroUsuario.FormActivate(Sender: TObject);
begin
  frmFuncoes.ExecutaSQL('Select * from USUARIO where ID is null', 'Abrir', qryUsuario);
  CarregaCampos;
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCadastroUsuario.PesquisaUsuario(vStatus: Boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      qryUsuario.Close;
      qryUsuario.SQL.Clear;
      qryUsuario.SQL.Add('Select * from USUARIO where ID = ' + QuotedStr(edtCodigo.Text));
      qryUsuario.Open;

      if qryUsuario.RecordCount > 0 then
      begin
        qryUsuario.Edit;

        CarregaCampos;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'USUARIO';
      frmPesquisa.vTela := 'CAD_USUARIO';
      frmPesquisa.vComando := 'Select id, nome from USUARIO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;

end;

end.
