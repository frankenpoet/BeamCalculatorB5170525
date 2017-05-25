using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using System.IO;

namespace BeamCalculatorB5
{
    public partial class BeamCalculatorBeta5 : System.Web.UI.Page
    {


        protected void unitSystem_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (unitSystem.SelectedItem.Text == "Metric")
            {
                mainLbl.Text = "Main span (m):";
                cantLbl.Text = "Cantilever span (m):";
                aLoad.Text = "Area load (kPa):";
                pLoad.Text = "Point load (kN):";
                tribLbl.Text = "Tributary width (m):";
                locationLbl.Text = "Location (m):";
                spacingLbl.Text = "Spacing (mm):";
                MetricDead.Visible = true;
                ImperialDead.Visible = false;
                //ImperialDead.ClearSelection();
                MetricLive.Visible = true;
                ImperialLive.Visible = false;
                //ImperialLive.ClearSelection();
                MetricSnow.Visible = true;
                ImperialSnow.Visible = false;
                //ImperialSnow.ClearSelection();
                areaWind.Text = "";

            }
            else
            {
                mainLbl.Text = "Main span (ft.): ";
                cantLbl.Text = "Cantilever span (ft.):";
                aLoad.Text = "Area load (psf):";
                pLoad.Text = "Point load (lbs):";
                tribLbl.Text = "Tributary width (ft.):";
                locationLbl.Text = "Location (ft.)";
                spacingLbl.Text = "Spacing (in.):";
                MetricDead.Visible = false;
                //MetricDead.ClearSelection();
                ImperialDead.Visible = true;
                MetricLive.Visible = false;
                //MetricLive.ClearSelection();
                ImperialLive.Visible = true;
                MetricSnow.Visible = false;
                //MetricSnow.ClearSelection();
                ImperialSnow.Visible = true;
                areaWind.Text = "";
                RegularExpressionValidator10.Enabled = true;
                RegularExpressionValidator2.Enabled = false;
            }
        }


        protected void memberTypeDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (memberTypeDDL.SelectedItem.Text == "Roof joist")
            {
                spacingLbl.Visible = true;
                tribLbl.Visible = false;
                tribValidate.Enabled = false;
                spaceValidate.Enabled = true;
                RegularExpressionValidator10.Enabled = false;
                RegularExpressionValidator2.Enabled = true;
                topLoadBeam.Visible = false;
                topLoadJoist.Visible = true;
                LiveSnowLoads.Visible = true;
                lateralBeams.Visible = false;
                lateralJoist.Visible = true;
                sameSpeciesBeam.Visible = false;
                sameSpeciesJoist.Visible = true;
                deflectionLbl.Visible = false;
                roofDeflection.Visible = true;

            }
            else if (memberTypeDDL.SelectedItem.Text == "Floor joist")
            {
                spacingLbl.Visible = true;
                tribLbl.Visible = false;
                tribValidate.Enabled = false;
                spaceValidate.Enabled = true;
                RegularExpressionValidator10.Enabled = false;
                RegularExpressionValidator2.Enabled = true;
                topLoadBeam.Visible = false;
                topLoadJoist.Visible = true;
                LiveSnowLoads.Visible = false;
                lateralBeams.Visible = false;
                lateralJoist.Visible = true;
                sameSpeciesBeam.Visible = false;
                sameSpeciesJoist.Visible = true;
                roofDeflection.Visible = false;
            }
            else if (memberTypeDDL.SelectedItem.Text == "Built-up floor beam")
            {
                spacingLbl.Visible = false;
                tribLbl.Visible = true;
                tribValidate.Enabled = true;
                spaceValidate.Enabled = false;
                RegularExpressionValidator10.Enabled = true;
                RegularExpressionValidator2.Enabled = false;
                topLoadBeam.Visible = true;
                topLoadJoist.Visible = false;
                LiveSnowLoads.Visible = false;
                lateralBeams.Visible = true;
                lateralJoist.Visible = false;
                sameSpeciesBeam.Visible = true;
                sameSpeciesJoist.Visible = false;
                deflectionLbl.Visible = true;
                roofDeflection.Visible = false;
            }
            else
            {
                spacingLbl.Visible = false;
                tribLbl.Visible = true;
                tribValidate.Enabled = true;
                spaceValidate.Enabled = false;
                RegularExpressionValidator10.Enabled = true;
                RegularExpressionValidator2.Enabled = false;
                topLoadBeam.Visible = true;
                topLoadJoist.Visible = false;
                LiveSnowLoads.Visible = true;
                lateralBeams.Visible = true;
                lateralJoist.Visible = false;
                sameSpeciesBeam.Visible = true;
                sameSpeciesJoist.Visible = false;
                deflectionLbl.Visible = true;
                roofDeflection.Visible = false;
            }
        }


        protected void CalcBtn_Click1(object sender, EventArgs e)
        {
            if(MetricDead.Text != null)
            {
                MetricDeadHF.Value = MetricDead.Text;
            }

            MetricDead.AppendDataBoundItems = true;
            //MetricDead.SelectedIndex = -1;
            MetricLive.AppendDataBoundItems = true;
            //MetricLive.SelectedIndex = -1;
            MetricSnow.AppendDataBoundItems = true;
            //MetricSnow.SelectedIndex = -1;
            ImperialDead.AppendDataBoundItems = false;
            ImperialDead.SelectedIndex = -1;
            ImperialLive.AppendDataBoundItems = false;
            ImperialLive.SelectedIndex = -1;
            ImperialSnow.AppendDataBoundItems = false;
            ImperialSnow.SelectedIndex = -1;

            if (Page.IsValid)
            {
                labelMessage.Visible = true;
            }
            else
            {
                labelMessage.Visible = false;
            }
        }

        protected void mainSpan_TextChanged(object sender, EventArgs e)
        {
            string mainText = mainSpan.Text;
            if (mainText != "")
            {
                double num = (double.Parse(mainText));
                if (Double.IsNaN(num))
                {
                    mainSpan.Text = "";
                    cantSpan.Text = "";
                    cantSpan.ReadOnly = true;
                }
                else
                {
                    if (num < 0 || num > 0)
                    {
                        cantSpan.ReadOnly = false;
                    }
                    else
                    {
                        cantSpan.ReadOnly = true;
                    }
                }
            }
            else
            {
                mainSpan.Text = "";
                cantSpan.Text = "";
                cantSpan.ReadOnly = true;
            }

        }

        protected void loadValidate_ServerValidate(object source, ServerValidateEventArgs args)
        {

            int count = 0;
            decimal numVal;
            if (unitSystem.SelectedItem.Text == "Metric")
            {
                if (Decimal.TryParse(cantWind.Text, out numVal))
                {
                    decimal cw = numVal;
                    if (cw != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(cantDead.Text, out numVal))
                {
                    decimal cd = numVal;
                    if (cd != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(cantLive.Text, out numVal))
                {
                    decimal cl = numVal;
                    if (cl != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(areaWind.Text, out numVal))
                {
                    decimal aw = numVal;
                    if (aw != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(cantSnow.Text, out numVal))
                {
                    decimal cs = numVal;
                    if (cs != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(MetricLive.SelectedValue, out numVal))
                {
                    decimal ml = numVal;
                    if (ml != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(MetricSnow.SelectedValue, out numVal))
                {
                    decimal ms = numVal;
                    if (ms != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(MetricDead.SelectedValue, out numVal))
                {
                    decimal md = numVal;
                    if (md != 0)
                    {
                        count = count + 1;
                    }
                }
                else
                {

                    count = 0;
                }
            }
            else
            {
                if (Decimal.TryParse(areaWind.Text, out numVal))
                {
                    decimal aw = numVal;
                    if (aw != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(cantDead.Text, out numVal))
                {
                    decimal cd = numVal;
                    if (cd != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(cantLive.Text, out numVal))
                {
                    decimal cl = numVal;
                    if (cl != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(cantWind.Text, out numVal))
                {
                    decimal cw = numVal;
                    if (cw != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(cantSnow.Text, out numVal))
                {
                    decimal cs = numVal;
                    if (cs != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(ImperialLive.SelectedValue, out numVal))
                {
                    decimal impL = numVal;
                    if (impL != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(ImperialSnow.SelectedValue, out numVal))
                {
                    decimal impS = numVal;
                    if (impS != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(ImperialDead.SelectedValue, out numVal))
                {
                    decimal impD = numVal;
                    if (impD != 0)
                    {
                        count = count + 1;
                    }
                }
                else
                {

                    count = 0;
                }
            }

            args.IsValid = (count > 0);

        }

        protected void locationValidate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int count = 0;
            decimal number;


            if (Decimal.TryParse(cantDead.Text, out number))
            {
                decimal cd = number;
                if (cd != 0)
                {
                    count = count + 1;
                }
            }
            else if (Decimal.TryParse(cantLive.Text, out number))
            {
                decimal cl = number;
                if (cl != 0)
                {
                    count = count + 1;
                }
            }
            else if (Decimal.TryParse(cantWind.Text, out number))
            {
                decimal cw = number;
                if (cw != 0)
                {
                    count = count + 1;
                }
            }
            else if (Decimal.TryParse(cantSnow.Text, out number))
            {
                decimal cs = number;
                if (cs != 0)
                {
                    count = count + 1;
                }
            }
            else
            {
                count = 0;
            }

            if (count > 0)
            {
                if (Decimal.TryParse(locBox.Text, out number))
                {
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }

        }

        protected void tribSpaceValidate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int count = 0;
            decimal num;

            if (unitSystem.SelectedItem.Text == "Metric")
            {
                if (Decimal.TryParse(areaWind.Text, out num))
                {
                    decimal aw = num;
                    if (aw != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(MetricLive.SelectedValue, out num))
                {
                    decimal ml = num;
                    if (ml != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(MetricSnow.SelectedValue, out num))
                {
                    decimal ms = num;
                    if (ms != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(MetricDead.SelectedValue, out num))
                {
                    decimal md = num;
                    if (md != 0)
                    {
                        count = count + 1;
                    }
                }
                else
                {

                    count = 0;
                }

                if (count > 0)
                {
                    if (Decimal.TryParse(tribSpace.Text, out num))
                    {
                        args.IsValid = true;
                    }
                    else
                    {
                        args.IsValid = false;
                    }
                }

            }
            else
            {
                if (Decimal.TryParse(areaWind.Text, out num))
                {
                    decimal aw = num;
                    if (aw != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(ImperialLive.SelectedValue, out num))
                {
                    decimal impL = num;
                    if (impL != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(ImperialSnow.SelectedValue, out num))
                {
                    decimal impS = num;
                    if (impS != 0)
                    {
                        count = count + 1;
                    }
                }
                else if (Decimal.TryParse(ImperialDead.SelectedValue, out num))
                {
                    decimal impD = num;
                    if (impD != 0)
                    {
                        count = count + 1;
                    }
                }
                else
                {

                    count = 0;
                }

                if (count > 0)
                {
                    if (Decimal.TryParse(tribSpace.Text, out num))
                    {
                        args.IsValid = true;
                    }
                    else
                    {
                        args.IsValid = false;
                    }
                }

            }
        }

        protected void locSumValidate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            decimal locationNum;
            decimal mainNum;
            decimal cantNum;
            decimal sumNum;

            if (Decimal.TryParse(locBox.Text, out locationNum))
            {
                if (Decimal.TryParse(mainSpan.Text, out mainNum))
                {
                    if (Decimal.TryParse(cantSpan.Text, out cantNum))
                    {
                        sumNum = (mainNum + cantNum);
                    }
                    else
                    {
                        sumNum = mainNum;
                    }

                    if (locationNum < sumNum)
                    {
                        args.IsValid = true;
                    }
                    else
                    {
                        args.IsValid = false;
                    }
                }
            }
        }



    }
}
