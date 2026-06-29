# Documentation for module Fortytwo.IAM.Education.StudentPasswordAgent

Student password agent for Fortytwo Education.

| Metadata | Information |
| --- | --- |
| Version | 0.1.0 |
| Required modules | EntraIDAccessToken |
| Author | Marius Solbakken Mellum |
| Company name | Fortytwo Technologies AS |
| PowerShell version | 7.6 |

## Complete-StudentPasswordAgentPendingRequest

### SYNOPSIS
{{ Fill in the Synopsis }}

### SYNTAX

```
Complete-StudentPasswordAgentPendingRequest [-Request] <Object> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### DESCRIPTION


### EXAMPLES

#### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

### PARAMETERS

#### -Request


```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

#### System.Object
### OUTPUTS

#### System.Object
### NOTES

### RELATED LINKS
## Connect-StudentPasswordAgent

### SYNOPSIS
Establishes connection to the Fortytwo Education student password service.

### SYNTAX

#### Default (Default)
```
Connect-StudentPasswordAgent [-AccessTokenProfile <Object>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

#### Development
```
Connect-StudentPasswordAgent [-AccessTokenProfile <Object>] [-Development] [-ApiRoot <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION
Establishes connection to the Fortytwo Education student password service.

### EXAMPLES

#### EXAMPLE 1
```
Connect-StudentPasswordAgent -AccessTokenProfile "Profile1"
```

### PARAMETERS

#### -AccessTokenProfile
The name of the Entra ID access token profile to use for authentication.
Defaults to "default".

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

#### -Development
Indicates whether to use the development API endpoint.
If specified, the ApiRoot parameter can be used to specify a custom API root URL.

```yaml
Type: SwitchParameter
Parameter Sets: Development
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ApiRoot
(Development parameter set) A custom API root URL for local development.
Must end with '/education/beta/'.

```yaml
Type: String
Parameter Sets: Development
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

### OUTPUTS

### NOTES

### RELATED LINKS
## Get-StudentPasswordAgentPendingRequest

### SYNOPSIS
{{ Fill in the Synopsis }}

### SYNTAX

```
Get-StudentPasswordAgentPendingRequest [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION


### EXAMPLES

#### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

### PARAMETERS

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

#### None
### OUTPUTS

#### System.Object
### NOTES

### RELATED LINKS
## Invoke-StudentPasswordAgent

### SYNOPSIS
{{ Fill in the Synopsis }}

### SYNTAX

```
Invoke-StudentPasswordAgent [[-IdentityAttribute] <String>] [[-PollingInterval] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION


### EXAMPLES

#### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

### PARAMETERS

#### -IdentityAttribute


```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -PollingInterval


```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

#### None
### OUTPUTS

#### System.Object
### NOTES

### RELATED LINKS
