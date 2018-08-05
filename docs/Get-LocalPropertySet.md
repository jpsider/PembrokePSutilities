---
external help file: PembrokePSutilities-help.xml
Module Name: PembrokePSutilities
online version:
schema: 2.0.0
---

# Get-LocalPropertySet

## SYNOPSIS

## SYNTAX

```
Get-LocalPropertySet [-PropertyFilePath] <String> [[-LOG_FILE] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function will gather Key value pairs from a properties file.

## EXAMPLES

### EXAMPLE 1
```
Get-LocalPropertySet -PropertyFilePath c:\pps\qman\pembrokeps.properties
```

## PARAMETERS

### -PropertyFilePath
A path is Required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LOG_FILE
A LOG_FILE is optional.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: C:\temp\nolog.log
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Object[]

## NOTES
This file is generated during the deployment or Registration of tha Pembroke PS component.

## RELATED LINKS
