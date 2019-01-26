unit untConfiguracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls;

type
  TfrmConfiguracao = class(TForm)
    pnlRodape: TPanel;
    btnGravar: TBitBtn;
    btnFechar: TBitBtn;
    pnlPrincipal: TPanel;
    lblCaminhoFoto: TLabel;
    edtCaminhoFoto: TEdit;
    GroupBox1: TGroupBox;
    edtDescrProduto: TEdit;
    btnPesqProduto: TBitBtn;
    edtCodProduto: TEdit;
    lblProduto: TLabel;
    edtCodServico: TEdit;
    lblServico: TLabel;
    edtCodVet: TEdit;
    lblVeterinario: TLabel;
    btnPesqVet: TBitBtn;
    edtDescrVeterinario: TEdit;
    btnPesqServico: TBitBtn;
    edtDescrServico: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesqVetClick(Sender: TObject);
    procedure btnPesqServicoClick(Sender: TObject);
    procedure btnPesqProdutoClick(Sender: TObject);
    procedure edtCodVetExit(Sender: TObject);
    procedure edtCodServicoExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaConfiguracao;
  public
    { Public declarations }
    procedure PesquisaServico(vStatus : boolean);
    procedure PesquisaVeterinario(vStatus : boolean);
    procedure PesquisaProduto(vStatus : boolean);
  end;

var
  frmConfiguracao: TfrmConfiguracao;

implementation

{$R *.dfm}

uses untPesquisa, untFuncoes, untDM, untPrincipal;

procedure TfrmConfiguracao.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConfiguracao.btnGravarClick(Sender: TObject);
begin
  dm.qryConfiguracao.Edit;
  dm.qryConfiguracao.FieldByName('veterinario_padrao').AsString := edtCodVet.Text;
  dm.qryConfiguracao.FieldByName('produto_inseminacao').AsString := edtCodProduto.Text;
  dm.qryConfiguracao.FieldByName('servico_padrao').AsString := edtCodServico.Text;
  dm.qryConfiguracao.FieldByName('caminho_foto').AsString := edtCaminhoFoto.Text;
  dm.qryConfiguracao.FieldByName('usuario').AsInteger := StrToInt(frmFuncoes.LerArquivoUsuario);
  dm.qryConfiguracao.FieldByName('alteracao').AsDateTime := Date+Time;
  dm.qryConfiguracao.FieldByName('CODEMPRESA').AsInteger := frmPrincipal.vEmpresa;        //Versao 1.4 - 14/10/2018
  frmFuncoes.Botoes('Gravar', dm.qryConfiguracao);
end;

procedure TfrmConfiguracao.btnPesqProdutoClick(Sender: TObject);
begin
  PesquisaProduto(False);
end;

procedure TfrmConfiguracao.btnPesqServicoClick(Sender: TObject);
begin
  PesquisaServico(False);
end;

procedure TfrmConfiguracao.btnPesqVetClick(Sender: TObject);
begin
  PesquisaVeterinario(False);
end;

procedure TfrmConfiguracao.CarregaConfiguracao;
begin
  frmFuncoes.ExecutaSQL('Select * from CONFIGURACAO', 'Abrir', dm.qryConfiguracao);

  edtCodVet.Text := dm.qryConfiguracao.FieldByName('veterinario_padrao').AsString;
  PesquisaVeterinario(True);

  edtCodProduto.Text := dm.qryConfiguracao.FieldByName('produto_inseminacao').AsString;
  PesquisaProduto(True);

  edtCodServico.Text := dm.qryConfiguracao.FieldByName('servico_padrao').AsString;
  PesquisaServico(True);

  edtCaminhoFoto.Text := dm.qryConfiguracao.FieldByName('caminho_foto').AsString;
end;

procedure TfrmConfiguracao.edtCodProdutoExit(Sender: TObject);
begin
  if edtCodProduto.Text <> '' then
    PesquisaProduto(True);
end;

procedure TfrmConfiguracao.edtCodServicoExit(Sender: TObject);
begin
  if edtCodServico.Text <> '' then
    PesquisaServico(True);
end;

procedure TfrmConfiguracao.edtCodVetExit(Sender: TObject);
begin
  if edtCodVet.Text <> '' then
    PesquisaVeterinario(True);
end;

procedure TfrmConfiguracao.FormActivate(Sender: TObject);
begin
  CarregaConfiguracao;
end;

procedure TfrmConfiguracao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmConfiguracao.PesquisaProduto(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodProduto.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from PRODUTO where ID = ' + QuotedStr(edtCodProduto.Text), 'Abrir', dm.qryProduto);

      if dm.qryProduto.RecordCount > 0 then
      begin
        edtDescrProduto.Text := dm.qryProduto.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodProduto.SetFocus;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'PRODUTO';
      frmPesquisa.vComando := 'Select ID, DESCRICAO, UNIDADE, VALOR, ESTOQUE from PRODUTO';
      frmPesquisa.vTela := 'CONFIG';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmConfiguracao.PesquisaServico(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodServico.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from SERVICO where ID =  ' + QuotedStr(edtCodServico.Text), 'Abrir', DM.qryProprietario);

      if DM.qryProprietario.RecordCount > 0 then
      begin
        edtDescrServico.Text := DM.qryProprietario.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodServico.SetFocus;
        edtCodServico.Clear;
        edtDescrServico.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'SERVICO';
      frmPesquisa.vTela := 'CONFIG';
      frmPesquisa.vComando := 'Select ID, DESCRICAO, VALOR from SERVICO ORDER BY DESCRICAO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmConfiguracao.PesquisaVeterinario(vStatus: boolean);
begin
if vStatus = True then
  begin
    frmFuncoes.ExecutaSQL('Select * from VETERINARIO where ID = ' + QuotedStr(edtCodVet.Text), 'Abrir', DM.qryVeterinario);

    if DM.qryVeterinario.RecordCount > 0 then
    begin
      edtDescrVeterinario.Text := DM.qryVeterinario.FieldByName('nome').AsString;
    end
    else
    begin
      Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      edtCodVet.SetFocus;
      edtCodVet.Clear;
      edtDescrVeterinario.Clear;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'VETERINARIO';
      frmPesquisa.vTela := 'CONFIG';
      frmPesquisa.vComando := 'Select ID, NOME from VETERINARIO ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

end.
