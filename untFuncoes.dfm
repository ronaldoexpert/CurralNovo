object frmFuncoes: TfrmFuncoes
  Left = 0
  Top = 0
  Caption = 'frmFuncoes'
  ClientHeight = 170
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FDQueryAutoincre: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'select * from cliente')
    Left = 59
    Top = 16
  end
  object dtsAutoincre: TDataSource
    DataSet = FDQueryAutoincre
    Left = 99
    Top = 16
  end
end
