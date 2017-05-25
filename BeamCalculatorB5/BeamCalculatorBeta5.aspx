 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeamCalculatorBeta5.aspx.cs" Inherits="BeamCalculatorB5.BeamCalculatorBeta5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Beam Calculator Beta 5.5</title>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
    <link href="Content/Site.css" rel="stylesheet" type="text/css" />
</head>

<body>

    <%--DISCLAIMER--%>

    <div><h2 class="disclaimTitle">Disclaimer</h2></div>
    <div id="disclaimerText" class="lowerClass">The Canadian Wood Council’s Beam Calculator has been developed for the purpose of information only.  Although all possible efforts have been made to ensure that the information from this tool is accurate, the CWC cannot guarantee the completeness, accuracy or exactness of the information.  Reference should always be made to the appropriate building code and/or standard. The Calculator should not be relied upon as a substitute for legal or design advice, and its user is responsible for how it is used or applied.</div>

    <%--BEGINNING OF FORM--%>

    <form id="BeamCalc" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div>

            <fieldset style="width: 330px; background-color: #919195; box-shadow: inset 0 -1px 8px rgba(0,0,0,0.5),
            inset 0 1px 4px rgba(245,245,245,1);">

                <legend id="beamTitle" style="background-color: #919195"></legend>

                <%--SIZER LOGO--%>

                <asp:Image ID="sizerLogo" runat="server" AlternateText="Sizer logo"
                            ImageUrl="~/Images/SizerLogo.png" ImageAlign="Left" Height="55" Width="31" CssClass="logo" />
                
                <%--BEAM CALCULATOR TITLE--%>

                <h2 id="calcTitle">Beam Calculator Beta 5.5</h2>

                <%--POWERED BY WOODWORKS--%>
         
                <p id="powered"><i>Powered by WoodWorks</i><sup>&reg;</sup> <i>Sizer</i></p>

                    <table id="table1" style="align-content: center;">

                    <tr>

                        <td><%--UNIT BUTTONS FOR METRIC/IMPERIAL--%>
                            <div id="unitBtns">
                                <asp:RadioButtonList ID="unitSystem" runat="server" OnSelectedIndexChanged="unitSystem_SelectedIndexChanged" AutoPostBack="True" CssClass="unitClass" onchange="impMetric()" RepeatDirection="Horizontal" CellPadding="-1">
                                    <asp:ListItem Selected="True" Text="Metric" Value="Metric"></asp:ListItem>
                                    <asp:ListItem Text="Imperial" Value="Imperial"></asp:ListItem>
                                </asp:RadioButtonList>

                            </div>
                        </td>

                        <td> <%--TRAINING VIDEO LINK--%>
                            <div>
                                <label style="font-size: .75em; margin-top: -25px; margin-left: 33px;">Training video</label>
                            </div>
                        </td>
                    </tr>

                    <tr> <%--MEMBER TYPE DROPDOWN--%>
                        <td>
                            <div id="left" style="margin-left: 20px; margin-top: -5px;">
                                <div>
                                    <label style="font-size: .75em;">Member type:</label><br />

                                    <asp:DropDownList ID="memberTypeDDL" runat="server" Width="135px" CssClass="fontSize" onblur="getValue()" Style="height: 25px" AutoPostBack="True" OnSelectedIndexChanged="memberTypeDDL_SelectedIndexChanged">
                                        <asp:ListItem Enabled="true" Text="select" Value="-1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Built-up roof beam" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Built-up floor beam" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Roof joist" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Floor joist" Value="3"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="memberValidate" runat="server" ControlToValidate="memberTypeDDL"
                                        ErrorMessage="Member type required" InitialValue="-1" Display="None"></asp:RequiredFieldValidator>

                                </div>

                                <div> <%--SPECIES TYPE DROPDOWN--%>
                                    <label style="font-size: .75em;">Species:</label><br />

                                    <asp:DropDownList ID="SpeciesDDL" runat="server" Width="135px" CssClass="fontSize" onblur="speciesSwitch()" Style="height: 25px">
                                        <asp:ListItem Enabled="true" Text="select" Value="-1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="D.Fir-L" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Hem-Fir" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="S-P-F" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Northern" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="speciesValidator" runat="server" ControlToValidate="SpeciesDDL"
                                        ErrorMessage="Species required" InitialValue="-1" Display="None"></asp:RequiredFieldValidator>
                                </div>

                                <div>
                                    <label style="font-size: .75em;">Grade:</label><br />
                                    <%--DropDown List for Grade--%>
                                    <asp:DropDownList ID="GradeDDL" runat="server" Width="135px" CssClass="fontSize" onblur="gradeSwitch()" Style="height: 25px">
                                        <asp:ListItem Enabled="true" Text="select" Value="-1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Select Structural" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="No. 1/No. 2" Value="1"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="gradeValidator" runat="server" ControlToValidate="GradeDDL"
                                        ErrorMessage="Grade required" InitialValue="-1" Display="None"></asp:RequiredFieldValidator>
                                    </div>
                            </div>
                        </td>
                        <td>
                            <div id="right" style="margin-top: -5px;">
                                <div>
                                    <label style="font-size: .75em;">Importance category:</label><br />
                                    <%--DropDown List for Importance Category--%>
                                    <asp:DropDownList ID="impCategoryDDL" runat="server" Width="120px" CssClass="fontSize" Style="height: 25px">
                                        <asp:ListItem Text="Low" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Normal" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="High" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Post-disaster" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Part 9 Snow" Value="4"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <asp:Label ID="mainLbl" runat="server" Text="Main span (m):" CssClass="fontSize"></asp:Label>
                                <div>
                                    <asp:TextBox ID="mainSpan" Columns="9" runat="server" onblur="isNan(id)" OnTextChanged="mainSpan_TextChanged" AutoPostBack="True" CssClass="boxDim" Width="120px" />
                                    <%--Number Validator--%>
                                    <asp:RegularExpressionValidator runat="server" ID="rexNumber" ControlToValidate="mainSpan" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d*)?\s*$" ErrorMessage="Main span is not a positive number" Display="None" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="mainSpan" ErrorMessage="Main span required" Display="None" />
                                    </div>

                                <div id="cantDiv">
                                    <asp:Label ID="cantLbl" runat="server" Text="Cantilever span: (m):" CssClass="fontSize"></asp:Label>

                                    <asp:TextBox ID="cantSpan" Columns="9" onblur="isNan(id)" runat="server" ReadOnly="true" CssClass="boxDim" Width="120px" />
                                    <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="cantSpan" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d*)?\s*$" ErrorMessage="Cantilever span is not a positive number" Display="None" />
                                    </div>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:Table ID="mainTable"
                    runat="server"
                    Width="300"
                    Font-Names="Helvetica"
                    Font-Size="Medium" BorderColor="#999999" HorizontalAlign="Center">
                    <asp:TableRow Height="8px"></asp:TableRow>
                    <asp:TableHeaderRow
                        runat="server"
                        Font-Bold="true"
                        HorizontalAlign="Left" VerticalAlign="Bottom" Height="8px">
                        <asp:TableHeaderCell></asp:TableHeaderCell>
                        <asp:TableHeaderCell HorizontalAlign="Left" VerticalAlign="Bottom">
                            <asp:Label ID="aLoad" runat="server" Text="Area load (kPa):" CssClass="fontBold"></asp:Label></asp:TableHeaderCell>
                        <asp:TableHeaderCell HorizontalAlign="Left" VerticalAlign="Bottom">
                            <asp:Label ID="pLoad" runat="server" Text="Point load (kN):" CssClass="fontBold"></asp:Label></asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                    <asp:TableRow
                        ID="TableRow1"
                        runat="server" Height="10" HorizontalAlign="Left">
                        <asp:TableCell Height="10" VerticalAlign="Bottom" HorizontalAlign="Left">
                            <label style="font-size: .75em; font-weight: bold;">Dead:&nbsp;</label></asp:TableCell>
                        <asp:TableCell Height="10">
                            <ajaxToolkit:ComboBox ID="ImperialDead"
                                runat="server"
                                Width="70"
                                Visible="False"
                                AutoPostBack="True"
                                VerticalAlign="Bottom"
                                Height="15"
                                DataSourceID="XmlDataSource2"
                                DataTextField="text"
                                DataValueField="value">
                            </ajaxToolkit:ComboBox>

                            <asp:XmlDataSource ID="XmlDataSource2" runat="server" DataFile="~/App_Data/XMLFile2.xml"></asp:XmlDataSource>

                            <asp:RegularExpressionValidator ID="impDeadVal" runat="server" ErrorMessage="Dead area load is not a number" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ControlToValidate="ImperialDead" Display="None"></asp:RegularExpressionValidator>

                            <asp:HiddenField ID="MetricDeadHF" runat="server" Visible="True" />

                            <ajaxToolkit:ComboBox ID="MetricDead"
                                runat="server"
                                Width="70"
                                <%--OnSelectedIndexChanged='isNan("<%=MetricDead.ClientID %>")'--%>
                                Height="15"
                                AppendDataBoundItems="True"
                                DropDownStyle="DropDown"
                                DataSourceID="XmlDataSource1"
                                DataTextField="text"
                                DataValueField="value"
                                AutoPostBack="False">
                            </ajaxToolkit:ComboBox>

                            <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/XMLFile1.xml"></asp:XmlDataSource>

                            <asp:RegularExpressionValidator ID="metDeadVal" runat="server" ErrorMessage="Dead area load is not a number" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ControlToValidate="MetricDead" Display="None"></asp:RegularExpressionValidator></asp:TableCell>
                        <asp:TableCell VerticalAlign="Bottom" HorizontalAlign="Left" Height="15">
                            <asp:TextBox ID="cantDead" Columns="9" runat="server" onblur="isNan(id)" Height="15" />
                            <%--Point Dead Load--%>
                            <%--Number Validator--%>
                            <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator3" ControlToValidate="cantDead" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ErrorMessage="Dead point load is not a number" Display="None" />
                        </asp:TableCell></asp:TableRow><asp:TableRow
                        ID="TableRow2"
                        runat="server" Height="15">
                        <asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom"><label style="font-size: .75em; font-weight: bold;">Live:&nbsp;</label></asp:TableCell><asp:TableCell HorizontalAlign="Left" VerticalAlign="Bottom" Height="15">
                            <ajaxToolkit:ComboBox ID="ImperialLive" runat="server" Width="70" Visible="False" OnSelectedIndexChanged="isNan(id)" Height="15" DataSourceID="XmlDataSource4" DataTextField="text" DataValueField="value">
                            </ajaxToolkit:ComboBox>

                            <asp:XmlDataSource ID="XmlDataSource4" runat="server" DataFile="~/App_Data/XMLFile4.xml"></asp:XmlDataSource>

                            <asp:RegularExpressionValidator ID="impLiveVal" runat="server" ErrorMessage="Live area load is not a number" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ControlToValidate="ImperialLive" Display="None"></asp:RegularExpressionValidator>

                            <ajaxToolkit:ComboBox ID="MetricLive" runat="server" Width="70" OnSelectedIndexChanged="isNan(id)" DataSourceID="XmlDataSource3" DataTextField="text" DataValueField="value">
                            </ajaxToolkit:ComboBox>

                            <asp:XmlDataSource ID="XmlDataSource3" runat="server" DataFile="~/App_Data/XMLFile3.xml"></asp:XmlDataSource>

                            <asp:RegularExpressionValidator ID="metLiveVal" runat="server" ErrorMessage="Live area load is not a number." ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ControlToValidate="MetricLive" Display="None"></asp:RegularExpressionValidator>

                        </asp:TableCell><asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <asp:TextBox ID="cantLive" Columns="9" runat="server" onblur="isNan(id)" />
                            <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator5" ControlToValidate="cantLive" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ErrorMessage="Live point load is not a number" Display="None" /></asp:TableCell></asp:TableRow><asp:TableRow
                        ID="TableRow3"
                        runat="server" Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                        <asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <label style="font-size: .75em; font-weight: bold;">Snow:&nbsp;</label></asp:TableCell><asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <ajaxToolkit:ComboBox ID="ImperialSnow" runat="server" Width="70" Visible="False" OnSelectedIndexChanged="isNan(id)" Height="15" DataSourceID="XmlDataSource6" DataTextField="text" DataValueField="value">
                            </ajaxToolkit:ComboBox>

                                <asp:XmlDataSource ID="XmlDataSource6" runat="server" DataFile="~/App_Data/XMLFile6.xml"></asp:XmlDataSource>

                            <asp:RegularExpressionValidator ID="impSnowVal" runat="server" ErrorMessage="Snow area load is not a number" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ControlToValidate="ImperialSnow" Display="None"></asp:RegularExpressionValidator>


                            <ajaxToolkit:ComboBox ID="MetricSnow" runat="server" Width="70" OnSelectedIndexChanged="isNan(id)">
                                <asp:ListItem text="1.0" value="0"></asp:ListItem>
                                <asp:ListItem Text="1.5" Value="1"></asp:ListItem>
                                <asp:ListItem Text="2.0" Value="2"></asp:ListItem>
                                <asp:ListItem Text="2.5" Value="3"></asp:ListItem>
                                <asp:ListItem Text="3.0" Value="4"></asp:ListItem>
                                <asp:ListItem Text="3.5" Value="5"></asp:ListItem>
                                <asp:ListItem Text="4.0" Value="6"></asp:ListItem>
                                <asp:ListItem Text="4.5" Value="7"></asp:ListItem>
                            
                            </ajaxToolkit:ComboBox>

                                <%--<asp:XmlDataSource ID="XmlDataSource5" runat="server" DataFile="~/App_Data/XMLFile5.xml"></asp:XmlDataSource>--%>

                            <asp:RegularExpressionValidator ID="metSnowVal" runat="server" ErrorMessage="Snow area load is not a number" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ControlToValidate="MetricSnow" Display="None"></asp:RegularExpressionValidator>

                        </asp:TableCell><asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <asp:TextBox ID="cantSnow" Columns="9" runat="server" onblur="isNan(id)" Height="15" />
                            <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator7" ControlToValidate="cantSnow" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ErrorMessage="Snow point load is not a number" Display="None" />

                        </asp:TableCell></asp:TableRow><asp:TableRow
                        ID="TableRow4"
                        runat="server" Height="30" HorizontalAlign="Left" VerticalAlign="Bottom">
                        <asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <label style="font-size: .75em; font-weight: bold;">Wind uplift:&nbsp;</label>
                        </asp:TableCell><asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <asp:TextBox ID="areaWind" Columns="9" runat="server" onblur="isNan(id)" />
                            <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator8" ControlToValidate="areaWind" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ErrorMessage="Wind area load is not a number" Display="None" />
                        </asp:TableCell><asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <asp:TextBox ID="cantWind" Columns="9" runat="server" onblur="isNan(id)" Height="15" />
                            <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator9" ControlToValidate="cantWind" ValidationExpression="^([0-9]*[1-9][0-9]*(\.[0-9]+)?|[0]*\.[0-9]*[1-9][0-9]*)$" ErrorMessage="Wind point load is not a number" Display="None" />
                        </asp:TableCell></asp:TableRow><asp:TableRow
                        ID="TableRow5"
                        runat="server" Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                        <asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom"></asp:TableCell>
                            <asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <div id="showTribTitle" style="display: block">
                                <asp:Label ID="tribLbl" runat="server" Text="Tributary width (m):" Style="font-size: .75em;"></asp:Label>
                            </div>

                            <div>
                                <asp:Label ID="spacingLbl" runat="server" Text="Spacing (m):" Style="font-size: .75em;" Visible="False" Height="15"></asp:Label>
                            </div>
                        </asp:TableCell><asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <asp:Label ID="locationLbl" runat="server" Text="Location (m):" Style="font-size: .75em;" Height="15"></asp:Label>
                        </asp:TableCell></asp:TableRow><asp:TableRow
                        ID="TableRow6"
                        runat="server" Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                        <asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom"></asp:TableCell><asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                            <div id="showTribField">
                                <%--Tributary/Spacing textbox--%>
                                <asp:TextBox ID="tribSpace" Columns="9" onblur="isNan(id); negCheck(id)" runat="server" Height="15" />
                                <%--Number Validator--%>
                                <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator10" ControlToValidate="tribSpace" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d*)?\s*$" ErrorMessage="Tributary width is not a positive number."
                                    Display="None" />
                                <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator2" ControlToValidate="tribSpace" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d*)?\s*$" ErrorMessage="Joist spacing is not a positive number."
                                    Display="None" Enabled="False" />
                            </div>
                        </asp:TableCell><asp:TableCell Height="15" HorizontalAlign="Left" VerticalAlign="Bottom">
                        <asp:TextBox ID="locBox" Columns="9" onblur="isNan(id); negCheck(id)" runat="server" Height="15" />
                        <%--Number Validator--%>
                        <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator11" ControlToValidate="locBox" ValidationExpression="^\s*(?=.*[1-9])\d*(?:\.\d*)?\s*$" ErrorMessage="Point load location is not a positive number" Display="None" />
                        </asp:TableCell></asp:TableRow><asp:TableRow Height="15px"></asp:TableRow>

                </asp:Table>

                <div id="chckTbl">
                <asp:Table ID="checkTable" runat="server"
                    Font-Size="Medium"
                    Width="325"
                    Font-Names="Helvetica"
                    CellPadding="1"
                    CellSpacing="1">
                    <asp:TableRow
                        ID="TableRow7"
                        runat="server">
                        <asp:TableCell
                            ColumnSpan="3" HorizontalAlign="Center">
                            <asp:CheckBox ID="wetConditions" Text="Wet service conditions" CssClass="fontSize" TextAlign="Right" runat="server" />
                            <asp:CheckBox ID="presTreat" Text="Preservative treatment" CssClass="fontSize" TextAlign="Right" runat="server" />
                        </asp:TableCell>
                            </asp:TableRow>
                    <asp:TableRow> 
                        <asp:TableCell Height="2">&nbsp;</asp:TableCell>
                    </asp:TableRow>
                    </asp:Table>
                </div>

                <div id="cnnctTbl">
                    <div>
<asp:Label runat="server" Font-Size=".75em" Text="Connection<br/>Strength:" ID="connLbl"></asp:Label>
                    </div>
                    <div id="pliesRadioDiv">
                            <asp:RadioButtonList ID="pliesRadio" runat="server" RepeatDirection="Horizontal" Font-Size=".75em">
                                <asp:ListItem Selected="True" title="Plies are not fastened adequately to achieve full composite action in the effect of lateral stability on bending moment strength (O86 7.5.6.4).">Plies act individually</asp:ListItem>
                                <asp:ListItem title="Plies are fastened adequately to ensure full composite action in the effect of lateral stability on bending moment strength (O86 7.5.6.4).">Plies act as unit</asp:ListItem>
                            </asp:RadioButtonList>
                    </div>
                </div>

                <asp:Table ID="summaryTbl" runat="server"
                    Font-Size="Medium"
                    Width="325"
                    Font-Names="Helvetica"
                    CellPadding="1"
                    CellSpacing="1">

                    <asp:TableRow
                        ID="TableRow10"
                        runat="server">
                        <asp:TableCell
                            ColumnSpan="3">
                            <asp:ValidationSummary ID="valSummary" runat="server" CssClass="fontSize" BackColor="White" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow
                        ID="TableRow11"
                        runat="server">
                        <asp:TableCell
                            ColumnSpan="3">
                            <asp:TextBox ID="labelMessage" runat="server" ReadOnly="True" Visible="False" Rows="10" TextMode="MultiLine" Width="318" CssClass="labelCss"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow
                        ID="TableRow12"
                        runat="server">
                        <asp:TableCell>
                            <asp:Button ID="CalcBtn" runat="server" Text="Calculate" Style="font-family: 'Calibri', 'Trebuchet MS', sans-serif" OnClick="CalcBtn_Click1" />
                            <asp:CustomValidator ID="loadValidate" runat="server" ErrorMessage="At least one load is required" OnServerValidate="loadValidate_ServerValidate" Display="None"></asp:CustomValidator><asp:CustomValidator ID="locationValidate" runat="server" ErrorMessage="Point load location required." OnServerValidate="locationValidate_ServerValidate" Display="None"></asp:CustomValidator><asp:CustomValidator ID="tribValidate" runat="server" ErrorMessage="Area load tributary width required."
                                Display="None" OnServerValidate="tribSpaceValidate_ServerValidate"></asp:CustomValidator><asp:CustomValidator ID="spaceValidate" runat="server" ErrorMessage="Joist spacing required."
                                    Display="None" OnServerValidate="tribSpaceValidate_ServerValidate" Enabled="False"></asp:CustomValidator><asp:CustomValidator ID="locSumValidate" runat="server" ErrorMessage="Point load location must be within extent of beam" Display="None" OnServerValidate="locSumValidate_ServerValidate"></asp:CustomValidator>
                        </asp:TableCell>
                        <asp:TableCell
                            ColumnSpan="2">
                            <asp:CheckBox ID="showEngDetails" runat="server" Text="Show detailed results" Font-Size=".75em" TextAlign="Right" CssClass="showDetails" />
                        </asp:TableCell>
                    </asp:TableRow>

                </asp:Table>
            </fieldset>
            <p style="font-size: .8em">Notes:</p>
     <p style="font-size: .8em">Designed using WoodWorks&reg; Sizer according to the National Building Code Part 4 and the CSA O86-14 Standard - Engineering design in wood. Design must be verified by a qualified engineer.<br />
    </p>
    <asp:Table id="belowForm" runat="server">

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell>
                <asp:Label ID="snowWindLoads" runat="server" Text="Label" Visible="True" CssClass="lowerLabels">Snow and wind loads should not include the Importance factor (O86 4.2.3.2), which is calculated using the selected Importance Category.</asp:Label></asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell><asp:Label ID="topLoadBeam" runat="server" Text="Label" Visible="False" CssClass="lowerLabels">Beam is top-loaded over its full width and uniformly over its entire length.</asp:Label></asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell><asp:Label ID="topLoadJoist" runat="server" Text="Label" Visible="False" CssClass="lowerLabels">Joist is top-loaded over its full width and uniformly over its entire length.</asp:Label></asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell>
                <asp:Label ID="LiveSnowLoads" runat="server" Text="Label" Visible="False" CssClass="lowerLabels">Live and snow loads are not simultaneously applied.</asp:Label></asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell>
                <asp:Label ID="lateralBeams" runat="server" Text="Label" Visible="False" CssClass="lowerLabels">Lumber plies are continuous between supports, and beam must be laterally restrained at support points.</asp:Label>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell>
                <asp:Label ID="lateralJoist" runat="server" Text="Label" Visible="False" CssClass="lowerLabels">Top of joist must be laterally restrained throughout it’s length; bottom must be restrained at support points.</asp:Label>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell>
                <asp:Label ID="sameSpeciesBeam" runat="server" Text="Label" Visible="False" CssClass="lowerLabels">Beam is supported through it’s entire width by a wood member of the same species and grade.</asp:Label>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell>
                <asp:Label ID="sameSpeciesJoist" runat="server" Text="Label" Visible="False" CssClass="lowerLabels">Joist is supported through it’s entire width by a wood member of the same species and grade.</asp:Label>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell>
                <asp:Label ID="deflectionLbl" runat="server" Text="Label" Visible="False" CssClass="lowerLabels">Deflection is limited to 1/180 of main span; deflection due to live and snow loads to 1/360. Cantilever deflection is not considered.</asp:Label>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow CssClass="lowerClass">
            <asp:TableCell>
                <asp:Label ID="roofDeflection" runat="server" Text="Label" Visible="False" CssClass="lowerLabels">Deflection is limited to 1/180 of main span; deflection due to live and snow loads to 1/240. Cantilever deflection is not considered</asp:Label>
            </asp:TableCell>
        </asp:TableRow>
                </asp:Table>
            <asp:Table id="designConsiderations" runat="server">
                <asp:TableRow CssClass="lowerClass">
                    <asp:TableCell>
                    <asp:Label ID="Label2" runat="server" Text="Label" CssClass="lowerLabels">For other design conditions, use <a href=" http://cwc.ca/woodworks-software/canadian-edition/products/">WoodWorks&reg; Sizer</a>. These include:</asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            <asp:TableRow CssClass="lowerClass">
                <asp:TableCell>
                <asp:BulletedList ID="BulletedList1" runat="server">
                    <asp:ListItem>Design of solid timber, glulam, SCL, and I-joists</asp:ListItem>
                    <asp:ListItem>Design of columns and walls</asp:ListItem>
                    <asp:ListItem>Sloped, rotated and/or notched beams</asp:ListItem>
                    <asp:ListItem>Partial and non-uniform loads or multiple point loads</asp:ListItem>
                    <asp:ListItem>Moving live, storage, controlled fluids, earthquake, dead soil and hydrostatic loads</asp:ListItem>
                    <asp:ListItem>Deflection limits according to your application, and cantilever deflections</asp:ListItem>
                    <asp:ListItem>Detailed lateral restraint conditions and lateral stability design options</asp:ListItem>
                    <asp:ListItem>Bearing design of supporting members</asp:ListItem>
                    <asp:ListItem>Fire design and floor vibration design</asp:ListItem>
                </asp:BulletedList>

                    </asp:TableCell>
            </asp:TableRow>
            </asp:Table>
        </div>
    </form>

    <%--SCRIPTS--%>

    <script type="text/javascript">    /* script to check if NaN and output '' if true */

        function isNan(id) { /* script to check if NaN and output '' if true */

                var a = document.getElementById(id).value;
                var n = Number(a);
                if (isNaN(n)) {
                    document.getElementById(id).value = '';
            }
    }

    </script>

    <script type="text/javascript">


    </script>

    <script type="text/javascript">    /* script to make negative textboxes positive */

        function negCheck(id) {

        var negValue = document.getElementById(id).value;
        if (negValue < 0) {
            document.getElementById(id).value = (negValue*-1);
        }
}
    

    </script>

</body>



</html>
