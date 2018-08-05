---
external help file: PembrokePSutilities-help.xml
Module Name: PembrokePSutilities
online version:
schema: 2.0.0
---

# Invoke-InstallRequiredModuleSet

## SYNOPSIS

## SYNTAX

```
Invoke-InstallRequiredModuleSet [-RequiredModuleSet] <String> [<CommonParameters>]
```

## DESCRIPTION
This function will Install additional Modules for a PembrokePS component.

## EXAMPLES

### EXAMPLE 1
```
Invoke-InstallRequiredModuleSet -RequiredModuleSet "Powerlumber,PembrokePSrest"
```

## PARAMETERS

### -RequiredModuleSet
A RequiredModuleSet is Required.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean

## NOTES
This will Install additional Modules for a Workflow_Manager.

## RELATED LINKS
