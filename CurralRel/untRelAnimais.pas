unit untRelAnimais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, UCrpeClasses, UCrpe32;

type
  TfrmRelAnimais = class(TForm)
    pnlClient: TPanel;
    rgTipos: TRadioGroup;
    grpFiltro: TGroupBox;
    edtDescricao: TEdit;
    btnPesquisa: TBitBtn;
    edtCodigo: TEdit;
    pnlBotton: TPanel;
    btnImprimir: TBitBtn;
    btnFechar: TBitBtn;
    crpe1: TCrpe;
    edtProprietario: TEdit;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure rgTiposClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PesquisaAnimais(vStatus : Boolean);
  end;

var
  frmRelAnimais: TfrmRelAnimais;

implementation

uses untDM, untPesquisa;

{$R *.dfm}

procedure TfrmRelAnimais.btnImprimirClick(Sender: TObject);
begin
  Crpe1.DiscardSavedData;
  Crpe1.ReportName := 'Relatorios\CadAnimais.rpt';

  if rgTipos.ItemIndex = 0 then
  begin
    Crpe1.ParamByName('SEXO', '').CurrentValue := 'A';
    Crpe1.ParamByName('CODIGO', '').CurrentValue := edtCodigo.Text;
  end
  else if rgTipos.ItemIndex = 1 then
  begin
    Crpe1.ParamByName('SEXO', '').CurrentValue := 'F';
    Crpe1.ParamByName('CODIGO', '').CurrentValue := edtCodigo.Text;
  end
  else if rgTipos.ItemIndex = 2 then
  begin
    Crpe1.ParamByName('SEXO', '').CurrentValue := 'M';
    Crpe1.ParamByName('CODIGO', '').CurrentValue := edtCodigo.Text;
  end;

  Crpe1.Execute;
  Crpe1.SetFocus;
end;

procedure TfrmRelAnimais.PesquisaAnimais(vStatus: Boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      DM.clntdtstAnimal.Close;
      DM.sqldtstAnimal.CommandText := 'Select * from ANIMAL where ID = ' + QuotedStr(edtCodigo.Text);
      DM.clntdtstAnimal.open;

      if DM.clntdtstAnimal.RecordCount > 0 then
      begin
        edtDescricao.Text := DM.clntdtstAnimal.FieldByName('nome').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodigo.SetFocus;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'REL_ANIMAL';
      IF rgTipos.ItemIndex = 0 then
        frmPesquisa.vComando := 'Select A.ID, A.NOME, A.IDENTIFICACAO, P.NOME AS PROPRIETARIO from ANIMAL A JOIN PRODUTOR P ON (P.ID = A.PROPRIETARIO)'
      else IF rgTipos.ItemIndex = 1 then
        frmPesquisa.vComando := 'Select A.ID, A.NOME, A.IDENTIFICACAO, P.NOME AS PROPRIETARIO from ANIMAL A JOIN PRODUTOR P ON (P.ID = A.PROPRIETARIO) Where A.SEXO = ' + QuotedStr('F')
      else
        frmPesquisa.vComando := 'Select A.ID, A.NOME, A.IDENTIFICACAO, P.NOME AS PROPRIETARIO from ANIMAL A JOIN PRODUTOR P ON (P.ID = A.PROPRIETARIO) Where A.SEXO = ' + QuotedStr('M');
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmRelAnimais.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmRelAnimais.btnPesquisaClick(Sender: TObject);
begin
  PesquisaAnimais(False);
end;

procedure TfrmRelAnimais.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelAnimais.rgTiposClick(Sender: TObject);
begin
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtProprietario.Clear;
end;

procedure TfrmRelAnimais.edtCodigoChange(Sender: TObject);
begin
  if edtCodigo.Text = '' then
  begin
    edtDescricao.Clear;
    edtProprietario.Clear;
  end;
end;

procedure TfrmRelAnimais.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

end.
