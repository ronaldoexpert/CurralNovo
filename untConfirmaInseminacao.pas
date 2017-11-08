unit untConfirmaInseminacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TfrmConfirmaInseminacao = class(TForm)
    pnlCentro: TPanel;
    pnlTop: TPanel;
    lblProdutor: TLabel;
    btnPesquProprietario: TBitBtn;
    edtCodProprietario: TEdit;
    pnlRodape: TPanel;
    btnGravar: TBitBtn;
    btnFechar: TBitBtn;
    btnPesquisar: TBitBtn;
    dbgInsemacoes: TDBGrid;
    dbgConfirmadas: TDBGrid;
    btnAdd: TBitBtn;
    btnRemove: TBitBtn;
    lblDtConfirmacao: TLabel;
    edtProprietario: TEdit;
    edtCodVeterinario: TEdit;
    btnPesqVeterinario: TBitBtn;
    edtVeterinario: TEdit;
    Label1: TLabel;
    qryProdutor: TFDQuery;
    dtsProdutor: TDataSource;
    qryVeterinario: TFDQuery;
    dtsVeterinario: TDataSource;
    edtDtConfirmacao: TDateTimePicker;
    qryAuxiliar: TFDQuery;
    dtsAuxiliar: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquProprietarioClick(Sender: TObject);
    procedure edtCodProprietarioExit(Sender: TObject);
    procedure btnPesqVeterinarioClick(Sender: TObject);
    procedure edtCodVeterinarioExit(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PesquisaProdutor(vStatus : boolean);
    procedure PesquisaVeterinario(vStatus : boolean);
    function ValidaCampos : Boolean;
  end;

var
  frmConfirmaInseminacao: TfrmConfirmaInseminacao;

implementation

{$R *.dfm}

uses untDM, untFuncoes, untPesquisa, untPrincipal;

procedure TfrmConfirmaInseminacao.btnAddClick(Sender: TObject);
begin
  if DM.qryAConfirmar.IsEmpty = False then
  begin
    DM.qryConfirmados.Insert;
    DM.qryConfirmados.FieldByName('numero').AsString := DM.qryAConfirmar.FieldByName('numero').AsString;
    DM.qryConfirmados.FieldByName('data').AsString := DM.qryAConfirmar.FieldByName('data').AsString;
    DM.qryConfirmados.FieldByName('confirmada').AsString := 'S';

    DM.qryAConfirmar.Delete;
  end;
end;

procedure TfrmConfirmaInseminacao.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConfirmaInseminacao.btnGravarClick(Sender: TObject);
begin
  if dm.qryConfirmados.IsEmpty = False then
  begin
    dm.qryConfirmados.First;
    while not dm.qryConfirmados.Eof do
    begin
      frmFuncoes.ExecutaSQL('Select * from INSEMINACAO WHERE NUMERO = ' + DM.qryConfirmados.FieldByName('NUMERO').AsString, 'Abrir', qryAuxiliar);
      qryAuxiliar.Edit;

      qryAuxiliar.FieldByName('CONFIRMADA').AsString := DM.qryConfirmados.FieldByName('CONFIRMADA').AsString;
      qryAuxiliar.FieldByName('DATA_CONFIRMACAO').AsDateTime := edtDtConfirmacao.Date;
      qryAuxiliar.FieldByName('ALTERACAO').AsDateTime := Date+Time;
      qryAuxiliar.FieldByName('USUARIO').AsInteger := frmPrincipal.vUsuario;

      qryAuxiliar.Post;
      qryAuxiliar.ApplyUpdates(-1);
      dm.qryConfirmados.Next;
    end;
    ShowMessage('Gravação efetuada com sucesso');
    DM.qryConfirmados.Close;
    DM.qryAConfirmar.Close;
  end;
end;

procedure TfrmConfirmaInseminacao.btnPesquisarClick(Sender: TObject);
var
  vComando : string;
begin
  if ValidaCampos then
  begin
    vComando := 'Select I.numero, I.data, A.NOME, I.CONFIRMADA from INSEMINACAO I JOIN ANIMAL A ON (I.ID_ANIMAL = A.ID) WHERE confirmada = ' + QuotedStr('N');

    if edtCodProprietario.Text <> '' then
    begin
      vComando := vComando + ' and id_produtor = ' + QuotedStr(edtCodProprietario.Text);
    end;

    if edtCodVeterinario.Text <> '' then
    begin
      vComando := vComando + ' and ID_VETERINARIO = ' + QuotedStr(edtCodVeterinario.Text);
    end;

    frmFuncoes.ExecutaSQL(vComando, 'Abrir', DM.qryAConfirmar);

    frmFuncoes.ExecutaSQL('Select I.numero, I.data, I.CONFIRMADA from INSEMINACAO I JOIN ANIMAL A ON (I.ID_ANIMAL = A.ID) WHERE I.id is null', 'Abrir', DM.qryConfirmados);
  end;
end;

procedure TfrmConfirmaInseminacao.btnPesquProprietarioClick(Sender: TObject);
begin
  PesquisaProdutor(False);
end;

procedure TfrmConfirmaInseminacao.btnPesqVeterinarioClick(Sender: TObject);
begin
  PesquisaVeterinario(False);
end;

procedure TfrmConfirmaInseminacao.btnRemoveClick(Sender: TObject);
begin
  if DM.qryConfirmados.IsEmpty = False then
  begin
    DM.qryAConfirmar.Insert;
    DM.qryAConfirmar.FieldByName('numero').AsString := DM.qryConfirmados.FieldByName('numero').AsString;
    DM.qryAConfirmar.FieldByName('data').AsString := DM.qryConfirmados.FieldByName('data').AsString;
    DM.qryAConfirmar.FieldByName('confirmada').AsString := 'N';

    DM.qryConfirmados.Delete;
  end;
end;

procedure TfrmConfirmaInseminacao.edtCodProprietarioExit(Sender: TObject);
begin
  if Trim(edtProprietario.Text) <> '' then
    PesquisaProdutor(True);
end;

procedure TfrmConfirmaInseminacao.edtCodVeterinarioExit(Sender: TObject);
begin
  if Trim(edtProprietario.Text) <> '' then
    PesquisaVeterinario(True);
end;

procedure TfrmConfirmaInseminacao.FormActivate(Sender: TObject);
begin
  edtDtConfirmacao.DateTime := Date;
end;

procedure TfrmConfirmaInseminacao.PesquisaProdutor(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodProprietario.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from PRODUTOR where ID =  ' + QuotedStr(edtCodProprietario.Text), 'Abrir', qryProdutor);

      if qryProdutor.RecordCount > 0 then
      begin
        edtProprietario.Text := qryProdutor.FieldByName('NOME').AsString;
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
      frmPesquisa.vTabela := 'PRODUTOR';
      frmPesquisa.vTela := 'CONFIRMA_INS';
      frmPesquisa.vComando := 'Select ID, NOME, INSCEST_RURAL from PRODUTOR';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmConfirmaInseminacao.PesquisaVeterinario(vStatus: boolean);
begin
  if vStatus = True then
  begin
    frmFuncoes.ExecutaSQL('Select * from VETERINARIO where ID = ' + QuotedStr(edtCodVeterinario.Text), 'Abrir', qryVeterinario);

    if qryVeterinario.RecordCount > 0 then
    begin
      edtVeterinario.Text := qryVeterinario.FieldByName('nome').AsString;
    end
    else
    begin
      Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      edtCodVeterinario.SetFocus;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'VETERINARIO';
      frmPesquisa.vTela := 'CONFIRMA_INS';
      frmPesquisa.vComando := 'Select ID, NOME from VETERINARIO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

function TfrmConfirmaInseminacao.ValidaCampos: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;


  Result := vRetorno;
end;

end.
