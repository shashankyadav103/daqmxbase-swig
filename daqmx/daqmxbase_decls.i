// Note that TaskHandle is typedef'd as uInt32*
%inline{
  typedef struct Task { uInt32 *handle; } Task;
};
%{
# include <string.h>
# include <stdlib.h>
# include "ruby.h"

  int32 handle_DAQmx_error(const char *funcName, int32 errCode)
  {
    static const char errorSeparator[] = ": ERROR : ";
    static const char warningSeparator[] = ": WARNING : ";
    static const char *separator;
    size_t errorBufferSize;
    size_t prefixLength;
    char *errorBuffer;

    if (errCode == 0)
      return 0;

    separator = errCode < 0 ? errorSeparator : warningSeparator;
    errorBufferSize = (size_t)DAQmxBaseGetExtendedErrorInfo(NULL, 0);
    prefixLength = strlen(funcName) + strlen(separator);
    errorBuffer = malloc(prefixLength + errorBufferSize);
    strcpy(errorBuffer, funcName);
    strcat(errorBuffer, separator);
    int32 status = DAQmxBaseGetExtendedErrorInfo(errorBuffer + prefixLength,
      (uInt32)errorBufferSize);

    if (errCode < 0)
      rb_raise(rb_eRuntimeError, errorBuffer);
    else if (errCode > 0)
      rb_raise(rb_eException, errorBuffer);

    return errCode;
  }
%};

// pass string and size to C function
%typemap(in) (char *str, int len) {
  $1 = STR2CSTR($input);
  $2 = (int) RSTRING($input)->len;
};

// pass array and size to C function
%typemap(in) (float64 readArray[], uInt32 arraySizeInSamps) {
  $1 = (float64 *) RARRAY($input)->ptr;
  $2 = (uInt32) RARRAY($input)->len;
};

%rename("SELF_CAL_SUPPORTED") DAQmx_SelfCal_Supported;
%rename("SELF_CAL_LAST_TEMP") DAQmx_SelfCal_LastTemp;
%rename("EXT_CAL_RECOMMENDED_INTERVAL") DAQmx_ExtCal_RecommendedInterval;
%rename("EXT_CAL_LAST_TEMP") DAQmx_ExtCal_LastTemp;
%rename("CAL_USER_DEFINED_INFO") DAQmx_Cal_UserDefinedInfo;
%rename("CAL_USER_DEFINED_INFO_MAX_SIZE") DAQmx_Cal_UserDefinedInfo_MaxSize;
%rename("CHAN_TYPE") DAQmx_ChanType;
%rename("PHYSICAL_CHAN_NAME") DAQmx_PhysicalChanName;
%rename("CHAN_DESCR") DAQmx_ChanDescr;
%rename("AI_MAX") DAQmx_AI_Max;
%rename("AI_MIN") DAQmx_AI_Min;
%rename("AI_CUSTOM_SCALE_NAME") DAQmx_AI_CustomScaleName;
%rename("AI_MEAS_TYPE") DAQmx_AI_MeasType;
%rename("AI_VOLTAGE_UNITS") DAQmx_AI_Voltage_Units;
%rename("AI_TEMP_UNITS") DAQmx_AI_Temp_Units;
%rename("AI_THRMCPL_TYPE") DAQmx_AI_Thrmcpl_Type;
%rename("AI_THRMCPL_CJCSRC") DAQmx_AI_Thrmcpl_CJCSrc;
%rename("AI_THRMCPL_CJCVAL") DAQmx_AI_Thrmcpl_CJCVal;
%rename("AI_THRMCPL_CJCCHAN") DAQmx_AI_Thrmcpl_CJCChan;
%rename("AI_RTD_TYPE") DAQmx_AI_RTD_Type;
%rename("AI_RTD_R0") DAQmx_AI_RTD_R0;
%rename("AI_RTD_A") DAQmx_AI_RTD_A;
%rename("AI_RTD_B") DAQmx_AI_RTD_B;
%rename("AI_RTD_C") DAQmx_AI_RTD_C;
%rename("AI_THRMSTR_A") DAQmx_AI_Thrmstr_A;
%rename("AI_THRMSTR_B") DAQmx_AI_Thrmstr_B;
%rename("AI_THRMSTR_C") DAQmx_AI_Thrmstr_C;
%rename("AI_THRMSTR_R1") DAQmx_AI_Thrmstr_R1;
%rename("AI_FORCE_READ_FROM_CHAN") DAQmx_AI_ForceReadFromChan;
%rename("AI_CURRENT_UNITS") DAQmx_AI_Current_Units;
%rename("AI_STRAIN_UNITS") DAQmx_AI_Strain_Units;
%rename("AI_STRAIN_GAGE_GAGE_FACTOR") DAQmx_AI_StrainGage_GageFactor;
%rename("AI_STRAIN_GAGE_POISSON_RATIO") DAQmx_AI_StrainGage_PoissonRatio;
%rename("AI_STRAIN_GAGE_CFG") DAQmx_AI_StrainGage_Cfg;
%rename("AI_RESISTANCE_UNITS") DAQmx_AI_Resistance_Units;
%rename("AI_FREQ_UNITS") DAQmx_AI_Freq_Units;
%rename("AI_FREQ_THRESH_VOLTAGE") DAQmx_AI_Freq_ThreshVoltage;
%rename("AI_FREQ_HYST") DAQmx_AI_Freq_Hyst;
%rename("AI_LVDT_UNITS") DAQmx_AI_LVDT_Units;
%rename("AI_LVDT_SENSITIVITY") DAQmx_AI_LVDT_Sensitivity;
%rename("AI_LVDT_SENSITIVITY_UNITS") DAQmx_AI_LVDT_SensitivityUnits;
%rename("AI_RVDT_UNITS") DAQmx_AI_RVDT_Units;
%rename("AI_RVDT_SENSITIVITY") DAQmx_AI_RVDT_Sensitivity;
%rename("AI_RVDT_SENSITIVITY_UNITS") DAQmx_AI_RVDT_SensitivityUnits;
%rename("AI_ACCEL_UNITS") DAQmx_AI_Accel_Units;
%rename("AI_ACCEL_SENSITIVITY") DAQmx_AI_Accel_Sensitivity;
%rename("AI_ACCEL_SENSITIVITY_UNITS") DAQmx_AI_Accel_SensitivityUnits;
%rename("AI_COUPLING") DAQmx_AI_Coupling;
%rename("AI_IMPEDANCE") DAQmx_AI_Impedance;
%rename("AI_TERM_CFG") DAQmx_AI_TermCfg;
%rename("AI_RESISTANCE_CFG") DAQmx_AI_ResistanceCfg;
%rename("AI_LEAD_WIRE_RESISTANCE") DAQmx_AI_LeadWireResistance;
%rename("AI_BRIDGE_CFG") DAQmx_AI_Bridge_Cfg;
%rename("AI_BRIDGE_NOM_RESISTANCE") DAQmx_AI_Bridge_NomResistance;
%rename("AI_BRIDGE_INITIAL_VOLTAGE") DAQmx_AI_Bridge_InitialVoltage;
%rename("AI_BRIDGE_SHUNT_CAL_ENABLE") DAQmx_AI_Bridge_ShuntCal_Enable;
%rename("AI_BRIDGE_SHUNT_CAL_SELECT") DAQmx_AI_Bridge_ShuntCal_Select;
%rename("AI_BRIDGE_SHUNT_CAL_GAIN_ADJUST") DAQmx_AI_Bridge_ShuntCal_GainAdjust;
%rename("AI_BRIDGE_BALANCE_COARSE_POT") DAQmx_AI_Bridge_Balance_CoarsePot;
%rename("AI_BRIDGE_BALANCE_FINE_POT") DAQmx_AI_Bridge_Balance_FinePot;
%rename("AI_CURRENT_SHUNT_LOC") DAQmx_AI_CurrentShunt_Loc;
%rename("AI_CURRENT_SHUNT_RESISTANCE") DAQmx_AI_CurrentShunt_Resistance;
%rename("AI_EXCIT_SRC") DAQmx_AI_Excit_Src;
%rename("AI_EXCIT_VAL") DAQmx_AI_Excit_Val;
%rename("AI_EXCIT_USE_FOR_SCALING") DAQmx_AI_Excit_UseForScaling;
%rename("AI_EXCIT_USE_MULTIPLEXED") DAQmx_AI_Excit_UseMultiplexed;
%rename("AI_EXCIT_ACTUAL_VAL") DAQmx_AI_Excit_ActualVal;
%rename("AI_EXCIT_DCOR_AC") DAQmx_AI_Excit_DCorAC;
%rename("AI_EXCIT_VOLTAGE_OR_CURRENT") DAQmx_AI_Excit_VoltageOrCurrent;
%rename("AI_ACEXCIT_FREQ") DAQmx_AI_ACExcit_Freq;
%rename("AI_ACEXCIT_SYNC_ENABLE") DAQmx_AI_ACExcit_SyncEnable;
%rename("AI_ACEXCIT_WIRE_MODE") DAQmx_AI_ACExcit_WireMode;
%rename("AI_ATTEN") DAQmx_AI_Atten;
%rename("AI_LOWPASS_ENABLE") DAQmx_AI_Lowpass_Enable;
%rename("AI_LOWPASS_CUTOFF_FREQ") DAQmx_AI_Lowpass_CutoffFreq;
%rename("AI_LOWPASS_SWITCH_CAP_CLK_SRC") DAQmx_AI_Lowpass_SwitchCap_ClkSrc;
%rename("AI_LOWPASS_SWITCH_CAP_EXT_CLK_FREQ") DAQmx_AI_Lowpass_SwitchCap_ExtClkFreq;
%rename("AI_LOWPASS_SWITCH_CAP_EXT_CLK_DIV") DAQmx_AI_Lowpass_SwitchCap_ExtClkDiv;
%rename("AI_LOWPASS_SWITCH_CAP_OUT_CLK_DIV") DAQmx_AI_Lowpass_SwitchCap_OutClkDiv;
%rename("AI_RESOLUTION_UNITS") DAQmx_AI_ResolutionUnits;
%rename("AI_RESOLUTION") DAQmx_AI_Resolution;
%rename("AI_DITHER_ENABLE") DAQmx_AI_Dither_Enable;
%rename("AI_RNG_HIGH") DAQmx_AI_Rng_High;
%rename("AI_RNG_LOW") DAQmx_AI_Rng_Low;
%rename("AI_GAIN") DAQmx_AI_Gain;
%rename("AI_SAMP_AND_HOLD_ENABLE") DAQmx_AI_SampAndHold_Enable;
%rename("AI_AUTO_ZERO_MODE") DAQmx_AI_AutoZeroMode;
%rename("AI_DATA_XFER_MECH") DAQmx_AI_DataXferMech;
%rename("AI_DATA_XFER_REQ_COND") DAQmx_AI_DataXferReqCond;
%rename("AI_MEM_MAP_ENABLE") DAQmx_AI_MemMapEnable;
%rename("AI_DEV_SCALING_COEFF") DAQmx_AI_DevScalingCoeff;
%rename("AO_MAX") DAQmx_AO_Max;
%rename("AO_MIN") DAQmx_AO_Min;
%rename("AO_CUSTOM_SCALE_NAME") DAQmx_AO_CustomScaleName;
%rename("AO_OUTPUT_TYPE") DAQmx_AO_OutputType;
%rename("AO_VOLTAGE_UNITS") DAQmx_AO_Voltage_Units;
%rename("AO_CURRENT_UNITS") DAQmx_AO_Current_Units;
%rename("AO_OUTPUT_IMPEDANCE") DAQmx_AO_OutputImpedance;
%rename("AO_LOAD_IMPEDANCE") DAQmx_AO_LoadImpedance;
%rename("AO_RESOLUTION_UNITS") DAQmx_AO_ResolutionUnits;
%rename("AO_RESOLUTION") DAQmx_AO_Resolution;
%rename("AO_DAC_RNG_HIGH") DAQmx_AO_DAC_Rng_High;
%rename("AO_DAC_RNG_LOW") DAQmx_AO_DAC_Rng_Low;
%rename("AO_DAC_REF_CONN_TO_GND") DAQmx_AO_DAC_Ref_ConnToGnd;
%rename("AO_DAC_REF_ALLOW_CONN_TO_GND") DAQmx_AO_DAC_Ref_AllowConnToGnd;
%rename("AO_DAC_REF_SRC") DAQmx_AO_DAC_Ref_Src;
%rename("AO_DAC_REF_VAL") DAQmx_AO_DAC_Ref_Val;
%rename("AO_REGLITCH_ENABLE") DAQmx_AO_ReglitchEnable;
%rename("AO_USE_ONLY_ON_BRD_MEM") DAQmx_AO_UseOnlyOnBrdMem;
%rename("AO_DATA_XFER_MECH") DAQmx_AO_DataXferMech;
%rename("AO_DATA_XFER_REQ_COND") DAQmx_AO_DataXferReqCond;
%rename("AO_MEM_MAP_ENABLE") DAQmx_AO_MemMapEnable;
%rename("AO_DEV_SCALING_COEFF") DAQmx_AO_DevScalingCoeff;
%rename("DI_INVERT_LINES") DAQmx_DI_InvertLines;
%rename("DI_NUM_LINES") DAQmx_DI_NumLines;
%rename("DI_DIG_FLTR_ENABLE") DAQmx_DI_DigFltr_Enable;
%rename("DI_DIG_FLTR_MIN_PULSE_WIDTH") DAQmx_DI_DigFltr_MinPulseWidth;
%rename("DO_INVERT_LINES") DAQmx_DO_InvertLines;
%rename("DO_NUM_LINES") DAQmx_DO_NumLines;
%rename("DO_TRISTATE") DAQmx_DO_Tristate;
%rename("CI_MAX") DAQmx_CI_Max;
%rename("CI_MIN") DAQmx_CI_Min;
%rename("CI_CUSTOM_SCALE_NAME") DAQmx_CI_CustomScaleName;
%rename("CI_MEAS_TYPE") DAQmx_CI_MeasType;
%rename("CI_FREQ_UNITS") DAQmx_CI_Freq_Units;
%rename("CI_FREQ_TERM") DAQmx_CI_Freq_Term;
%rename("CI_FREQ_STARTING_EDGE") DAQmx_CI_Freq_StartingEdge;
%rename("CI_FREQ_MEAS_METH") DAQmx_CI_Freq_MeasMeth;
%rename("CI_FREQ_MEAS_TIME") DAQmx_CI_Freq_MeasTime;
%rename("CI_FREQ_DIV") DAQmx_CI_Freq_Div;
%rename("CI_PERIOD_UNITS") DAQmx_CI_Period_Units;
%rename("CI_PERIOD_TERM") DAQmx_CI_Period_Term;
%rename("CI_PERIOD_STARTING_EDGE") DAQmx_CI_Period_StartingEdge;
%rename("CI_PERIOD_MEAS_METH") DAQmx_CI_Period_MeasMeth;
%rename("CI_PERIOD_MEAS_TIME") DAQmx_CI_Period_MeasTime;
%rename("CI_PERIOD_DIV") DAQmx_CI_Period_Div;
%rename("CI_COUNT_EDGES_TERM") DAQmx_CI_CountEdges_Term;
%rename("CI_COUNT_EDGES_DIR") DAQmx_CI_CountEdges_Dir;
%rename("CI_COUNT_EDGES_DIR_TERM") DAQmx_CI_CountEdges_DirTerm;
%rename("CI_COUNT_EDGES_INITIAL_CNT") DAQmx_CI_CountEdges_InitialCnt;
%rename("CI_COUNT_EDGES_ACTIVE_EDGE") DAQmx_CI_CountEdges_ActiveEdge;
%rename("CI_ANG_ENCODER_UNITS") DAQmx_CI_AngEncoder_Units;
%rename("CI_ANG_ENCODER_PULSES_PER_REV") DAQmx_CI_AngEncoder_PulsesPerRev;
%rename("CI_ANG_ENCODER_INITIAL_ANGLE") DAQmx_CI_AngEncoder_InitialAngle;
%rename("CI_LIN_ENCODER_UNITS") DAQmx_CI_LinEncoder_Units;
%rename("CI_LIN_ENCODER_DIST_PER_PULSE") DAQmx_CI_LinEncoder_DistPerPulse;
%rename("CI_LIN_ENCODER_INITIAL_POS") DAQmx_CI_LinEncoder_InitialPos;
%rename("CI_ENCODER_DECODING_TYPE") DAQmx_CI_Encoder_DecodingType;
%rename("CI_ENCODER_AINPUT_TERM") DAQmx_CI_Encoder_AInputTerm;
%rename("CI_ENCODER_BINPUT_TERM") DAQmx_CI_Encoder_BInputTerm;
%rename("CI_ENCODER_ZINPUT_TERM") DAQmx_CI_Encoder_ZInputTerm;
%rename("CI_ENCODER_ZINDEX_ENABLE") DAQmx_CI_Encoder_ZIndexEnable;
%rename("CI_ENCODER_ZINDEX_VAL") DAQmx_CI_Encoder_ZIndexVal;
%rename("CI_ENCODER_ZINDEX_PHASE") DAQmx_CI_Encoder_ZIndexPhase;
%rename("CI_PULSE_WIDTH_UNITS") DAQmx_CI_PulseWidth_Units;
%rename("CI_PULSE_WIDTH_TERM") DAQmx_CI_PulseWidth_Term;
%rename("CI_PULSE_WIDTH_STARTING_EDGE") DAQmx_CI_PulseWidth_StartingEdge;
%rename("CI_TWO_EDGE_SEP_UNITS") DAQmx_CI_TwoEdgeSep_Units;
%rename("CI_TWO_EDGE_SEP_FIRST_TERM") DAQmx_CI_TwoEdgeSep_FirstTerm;
%rename("CI_TWO_EDGE_SEP_FIRST_EDGE") DAQmx_CI_TwoEdgeSep_FirstEdge;
%rename("CI_TWO_EDGE_SEP_SECOND_TERM") DAQmx_CI_TwoEdgeSep_SecondTerm;
%rename("CI_TWO_EDGE_SEP_SECOND_EDGE") DAQmx_CI_TwoEdgeSep_SecondEdge;
%rename("CI_SEMI_PERIOD_UNITS") DAQmx_CI_SemiPeriod_Units;
%rename("CI_SEMI_PERIOD_TERM") DAQmx_CI_SemiPeriod_Term;
%rename("CI_CTR_TIMEBASE_SRC") DAQmx_CI_CtrTimebaseSrc;
%rename("CI_CTR_TIMEBASE_RATE") DAQmx_CI_CtrTimebaseRate;
%rename("CI_CTR_TIMEBASE_ACTIVE_EDGE") DAQmx_CI_CtrTimebaseActiveEdge;
%rename("CI_COUNT") DAQmx_CI_Count;
%rename("CI_OUTPUT_STATE") DAQmx_CI_OutputState;
%rename("CI_TCREACHED") DAQmx_CI_TCReached;
%rename("CI_CTR_TIMEBASE_MASTER_TIMEBASE_DIV") DAQmx_CI_CtrTimebaseMasterTimebaseDiv;
%rename("CI_DATA_XFER_MECH") DAQmx_CI_DataXferMech;
%rename("CI_NUM_POSSIBLY_INVALID_SAMPS") DAQmx_CI_NumPossiblyInvalidSamps;
%rename("CI_DUP_COUNT_PREVENT") DAQmx_CI_DupCountPrevent;
%rename("CO_OUTPUT_TYPE") DAQmx_CO_OutputType;
%rename("CO_PULSE_IDLE_STATE") DAQmx_CO_Pulse_IdleState;
%rename("CO_PULSE_TERM") DAQmx_CO_Pulse_Term;
%rename("CO_PULSE_TIME_UNITS") DAQmx_CO_Pulse_Time_Units;
%rename("CO_PULSE_HIGH_TIME") DAQmx_CO_Pulse_HighTime;
%rename("CO_PULSE_LOW_TIME") DAQmx_CO_Pulse_LowTime;
%rename("CO_PULSE_TIME_INITIAL_DELAY") DAQmx_CO_Pulse_Time_InitialDelay;
%rename("CO_PULSE_DUTY_CYC") DAQmx_CO_Pulse_DutyCyc;
%rename("CO_PULSE_FREQ_UNITS") DAQmx_CO_Pulse_Freq_Units;
%rename("CO_PULSE_FREQ") DAQmx_CO_Pulse_Freq;
%rename("CO_PULSE_FREQ_INITIAL_DELAY") DAQmx_CO_Pulse_Freq_InitialDelay;
%rename("CO_PULSE_HIGH_TICKS") DAQmx_CO_Pulse_HighTicks;
%rename("CO_PULSE_LOW_TICKS") DAQmx_CO_Pulse_LowTicks;
%rename("CO_PULSE_TICKS_INITIAL_DELAY") DAQmx_CO_Pulse_Ticks_InitialDelay;
%rename("CO_CTR_TIMEBASE_SRC") DAQmx_CO_CtrTimebaseSrc;
%rename("CO_CTR_TIMEBASE_RATE") DAQmx_CO_CtrTimebaseRate;
%rename("CO_CTR_TIMEBASE_ACTIVE_EDGE") DAQmx_CO_CtrTimebaseActiveEdge;
%rename("CO_COUNT") DAQmx_CO_Count;
%rename("CO_OUTPUT_STATE") DAQmx_CO_OutputState;
%rename("CO_AUTO_INCR_CNT") DAQmx_CO_AutoIncrCnt;
%rename("CO_CTR_TIMEBASE_MASTER_TIMEBASE_DIV") DAQmx_CO_CtrTimebaseMasterTimebaseDiv;
%rename("CO_PULSE_DONE") DAQmx_CO_PulseDone;
%rename("EXPORTED_AICONV_CLK_OUTPUT_TERM") DAQmx_Exported_AIConvClk_OutputTerm;
%rename("EXPORTED_AICONV_CLK_PULSE_POLARITY") DAQmx_Exported_AIConvClk_Pulse_Polarity;
%rename("EXPORTED_20MHZ_TIMEBASE_OUTPUT_TERM") DAQmx_Exported_20MHzTimebase_OutputTerm;
%rename("EXPORTED_SAMP_CLK_OUTPUT_BEHAVIOR") DAQmx_Exported_SampClk_OutputBehavior;
%rename("EXPORTED_SAMP_CLK_OUTPUT_TERM") DAQmx_Exported_SampClk_OutputTerm;
%rename("EXPORTED_ADV_TRIG_OUTPUT_TERM") DAQmx_Exported_AdvTrig_OutputTerm;
%rename("EXPORTED_ADV_TRIG_PULSE_POLARITY") DAQmx_Exported_AdvTrig_Pulse_Polarity;
%rename("EXPORTED_ADV_TRIG_PULSE_WIDTH_UNITS") DAQmx_Exported_AdvTrig_Pulse_WidthUnits;
%rename("EXPORTED_ADV_TRIG_PULSE_WIDTH") DAQmx_Exported_AdvTrig_Pulse_Width;
%rename("EXPORTED_REF_TRIG_OUTPUT_TERM") DAQmx_Exported_RefTrig_OutputTerm;
%rename("EXPORTED_START_TRIG_OUTPUT_TERM") DAQmx_Exported_StartTrig_OutputTerm;
%rename("EXPORTED_ADV_CMPLT_EVENT_OUTPUT_TERM") DAQmx_Exported_AdvCmpltEvent_OutputTerm;
%rename("EXPORTED_ADV_CMPLT_EVENT_DELAY") DAQmx_Exported_AdvCmpltEvent_Delay;
%rename("EXPORTED_ADV_CMPLT_EVENT_PULSE_POLARITY") DAQmx_Exported_AdvCmpltEvent_Pulse_Polarity;
%rename("EXPORTED_ADV_CMPLT_EVENT_PULSE_WIDTH") DAQmx_Exported_AdvCmpltEvent_Pulse_Width;
%rename("EXPORTED_AIHOLD_CMPLT_EVENT_OUTPUT_TERM") DAQmx_Exported_AIHoldCmpltEvent_OutputTerm;
%rename("EXPORTED_AIHOLD_CMPLT_EVENT_PULSE_POLARITY") DAQmx_Exported_AIHoldCmpltEvent_PulsePolarity;
%rename("EXPORTED_CHANGE_DETECT_EVENT_OUTPUT_TERM") DAQmx_Exported_ChangeDetectEvent_OutputTerm;
%rename("EXPORTED_CTR_OUT_EVENT_OUTPUT_TERM") DAQmx_Exported_CtrOutEvent_OutputTerm;
%rename("EXPORTED_CTR_OUT_EVENT_OUTPUT_BEHAVIOR") DAQmx_Exported_CtrOutEvent_OutputBehavior;
%rename("EXPORTED_CTR_OUT_EVENT_PULSE_POLARITY") DAQmx_Exported_CtrOutEvent_Pulse_Polarity;
%rename("EXPORTED_CTR_OUT_EVENT_TOGGLE_IDLE_STATE") DAQmx_Exported_CtrOutEvent_Toggle_IdleState;
%rename("EXPORTED_WATCHDOG_EXPIRED_EVENT_OUTPUT_TERM") DAQmx_Exported_WatchdogExpiredEvent_OutputTerm;
%rename("DEV_PRODUCT_TYPE") DAQmx_Dev_ProductType;
%rename("DEV_SERIAL_NUM") DAQmx_Dev_SerialNum;
%rename("READ_RELATIVE_TO") DAQmx_Read_RelativeTo;
%rename("READ_OFFSET") DAQmx_Read_Offset;
%rename("READ_CHANNELS_TO_READ") DAQmx_Read_ChannelsToRead;
%rename("READ_READ_ALL_AVAIL_SAMP") DAQmx_Read_ReadAllAvailSamp;
%rename("READ_AUTO_START") DAQmx_Read_AutoStart;
%rename("READ_OVER_WRITE") DAQmx_Read_OverWrite;
%rename("READ_CURR_READ_POS") DAQmx_Read_CurrReadPos;
%rename("READ_AVAIL_SAMP_PER_CHAN") DAQmx_Read_AvailSampPerChan;
%rename("READ_TOTAL_SAMP_PER_CHAN_ACQUIRED") DAQmx_Read_TotalSampPerChanAcquired;
%rename("READ_CHANGE_DETECT_HAS_OVERFLOWED") DAQmx_Read_ChangeDetect_HasOverflowed;
%rename("READ_RAW_DATA_WIDTH") DAQmx_Read_RawDataWidth;
%rename("READ_NUM_CHANS") DAQmx_Read_NumChans;
%rename("READ_DIGITAL_LINES_BYTES_PER_CHAN") DAQmx_Read_DigitalLines_BytesPerChan;
%rename("SWITCH_CHAN_USAGE") DAQmx_SwitchChan_Usage;
%rename("SWITCH_CHAN_MAX_ACCARRY_CURRENT") DAQmx_SwitchChan_MaxACCarryCurrent;
%rename("SWITCH_CHAN_MAX_ACSWITCH_CURRENT") DAQmx_SwitchChan_MaxACSwitchCurrent;
%rename("SWITCH_CHAN_MAX_ACCARRY_PWR") DAQmx_SwitchChan_MaxACCarryPwr;
%rename("SWITCH_CHAN_MAX_ACSWITCH_PWR") DAQmx_SwitchChan_MaxACSwitchPwr;
%rename("SWITCH_CHAN_MAX_DCCARRY_CURRENT") DAQmx_SwitchChan_MaxDCCarryCurrent;
%rename("SWITCH_CHAN_MAX_DCSWITCH_CURRENT") DAQmx_SwitchChan_MaxDCSwitchCurrent;
%rename("SWITCH_CHAN_MAX_DCCARRY_PWR") DAQmx_SwitchChan_MaxDCCarryPwr;
%rename("SWITCH_CHAN_MAX_DCSWITCH_PWR") DAQmx_SwitchChan_MaxDCSwitchPwr;
%rename("SWITCH_CHAN_MAX_ACVOLTAGE") DAQmx_SwitchChan_MaxACVoltage;
%rename("SWITCH_CHAN_MAX_DCVOLTAGE") DAQmx_SwitchChan_MaxDCVoltage;
%rename("SWITCH_CHAN_WIRE_MODE") DAQmx_SwitchChan_WireMode;
%rename("SWITCH_CHAN_BANDWIDTH") DAQmx_SwitchChan_Bandwidth;
%rename("SWITCH_CHAN_IMPEDANCE") DAQmx_SwitchChan_Impedance;
%rename("SWITCH_DEV_SETTLING_TIME") DAQmx_SwitchDev_SettlingTime;
%rename("SWITCH_DEV_AUTO_CONN_ANLG_BUS") DAQmx_SwitchDev_AutoConnAnlgBus;
%rename("SWITCH_DEV_SETTLED") DAQmx_SwitchDev_Settled;
%rename("SWITCH_DEV_RELAY_LIST") DAQmx_SwitchDev_RelayList;
%rename("SWITCH_DEV_NUM_RELAYS") DAQmx_SwitchDev_NumRelays;
%rename("SWITCH_DEV_SWITCH_CHAN_LIST") DAQmx_SwitchDev_SwitchChanList;
%rename("SWITCH_DEV_NUM_SWITCH_CHANS") DAQmx_SwitchDev_NumSwitchChans;
%rename("SWITCH_DEV_NUM_ROWS") DAQmx_SwitchDev_NumRows;
%rename("SWITCH_DEV_NUM_COLUMNS") DAQmx_SwitchDev_NumColumns;
%rename("SWITCH_DEV_TOPOLOGY") DAQmx_SwitchDev_Topology;
%rename("SWITCH_SCAN_BREAK_MODE") DAQmx_SwitchScan_BreakMode;
%rename("SWITCH_SCAN_REPEAT_MODE") DAQmx_SwitchScan_RepeatMode;
%rename("SWITCH_SCAN_WAITING_FOR_ADV") DAQmx_SwitchScan_WaitingForAdv;
%rename("SCALE_DESCR") DAQmx_Scale_Descr;
%rename("SCALE_SCALED_UNITS") DAQmx_Scale_ScaledUnits;
%rename("SCALE_PRE_SCALED_UNITS") DAQmx_Scale_PreScaledUnits;
%rename("SCALE_TYPE") DAQmx_Scale_Type;
%rename("SCALE_LIN_SLOPE") DAQmx_Scale_Lin_Slope;
%rename("SCALE_LIN_YINTERCEPT") DAQmx_Scale_Lin_YIntercept;
%rename("SCALE_MAP_SCALED_MAX") DAQmx_Scale_Map_ScaledMax;
%rename("SCALE_MAP_PRE_SCALED_MAX") DAQmx_Scale_Map_PreScaledMax;
%rename("SCALE_MAP_SCALED_MIN") DAQmx_Scale_Map_ScaledMin;
%rename("SCALE_MAP_PRE_SCALED_MIN") DAQmx_Scale_Map_PreScaledMin;
%rename("SCALE_POLY_FORWARD_COEFF") DAQmx_Scale_Poly_ForwardCoeff;
%rename("SCALE_POLY_REVERSE_COEFF") DAQmx_Scale_Poly_ReverseCoeff;
%rename("SCALE_TABLE_SCALED_VALS") DAQmx_Scale_Table_ScaledVals;
%rename("SCALE_TABLE_PRE_SCALED_VALS") DAQmx_Scale_Table_PreScaledVals;
%rename("SYS_GLOBAL_CHANS") DAQmx_Sys_GlobalChans;
%rename("SYS_SCALES") DAQmx_Sys_Scales;
%rename("SYS_TASKS") DAQmx_Sys_Tasks;
%rename("SYS_DEV_NAMES") DAQmx_Sys_DevNames;
%rename("SYS_NIDAQMAJOR_VERSION") DAQmx_Sys_NIDAQMajorVersion;
%rename("SYS_NIDAQMINOR_VERSION") DAQmx_Sys_NIDAQMinorVersion;
%rename("TASK_NAME") DAQmx_Task_Name;
%rename("TASK_CHANNELS") DAQmx_Task_Channels;
%rename("TASK_NUM_CHANS") DAQmx_Task_NumChans;
%rename("TASK_COMPLETE") DAQmx_Task_Complete;
%rename("SAMP_QUANT_SAMP_MODE") DAQmx_SampQuant_SampMode;
%rename("SAMP_QUANT_SAMP_PER_CHAN") DAQmx_SampQuant_SampPerChan;
%rename("SAMP_TIMING_TYPE") DAQmx_SampTimingType;
%rename("SAMP_CLK_RATE") DAQmx_SampClk_Rate;
%rename("SAMP_CLK_SRC") DAQmx_SampClk_Src;
%rename("SAMP_CLK_ACTIVE_EDGE") DAQmx_SampClk_ActiveEdge;
%rename("SAMP_CLK_TIMEBASE_DIV") DAQmx_SampClk_TimebaseDiv;
%rename("SAMP_CLK_TIMEBASE_RATE") DAQmx_SampClk_Timebase_Rate;
%rename("SAMP_CLK_TIMEBASE_SRC") DAQmx_SampClk_Timebase_Src;
%rename("SAMP_CLK_TIMEBASE_ACTIVE_EDGE") DAQmx_SampClk_Timebase_ActiveEdge;
%rename("SAMP_CLK_TIMEBASE_MASTER_TIMEBASE_DIV") DAQmx_SampClk_Timebase_MasterTimebaseDiv;
%rename("CHANGE_DETECT_DI_RISING_EDGE_PHYSICAL_CHANS") DAQmx_ChangeDetect_DI_RisingEdgePhysicalChans;
%rename("CHANGE_DETECT_DI_FALLING_EDGE_PHYSICAL_CHANS") DAQmx_ChangeDetect_DI_FallingEdgePhysicalChans;
%rename("ON_DEMAND_SIMULTANEOUS_AOENABLE") DAQmx_OnDemand_SimultaneousAOEnable;
%rename("AICONV_RATE") DAQmx_AIConv_Rate;
%rename("AICONV_SRC") DAQmx_AIConv_Src;
%rename("AICONV_ACTIVE_EDGE") DAQmx_AIConv_ActiveEdge;
%rename("AICONV_TIMEBASE_DIV") DAQmx_AIConv_TimebaseDiv;
%rename("AICONV_TIMEBASE_SRC") DAQmx_AIConv_Timebase_Src;
%rename("MASTER_TIMEBASE_RATE") DAQmx_MasterTimebase_Rate;
%rename("MASTER_TIMEBASE_SRC") DAQmx_MasterTimebase_Src;
%rename("DELAY_FROM_SAMP_CLK_DELAY_UNITS") DAQmx_DelayFromSampClk_DelayUnits;
%rename("DELAY_FROM_SAMP_CLK_DELAY") DAQmx_DelayFromSampClk_Delay;
%rename("START_TRIG_TYPE") DAQmx_StartTrig_Type;
%rename("DIG_EDGE_START_TRIG_SRC") DAQmx_DigEdge_StartTrig_Src;
%rename("DIG_EDGE_START_TRIG_EDGE") DAQmx_DigEdge_StartTrig_Edge;
%rename("ANLG_EDGE_START_TRIG_SRC") DAQmx_AnlgEdge_StartTrig_Src;
%rename("ANLG_EDGE_START_TRIG_SLOPE") DAQmx_AnlgEdge_StartTrig_Slope;
%rename("ANLG_EDGE_START_TRIG_LVL") DAQmx_AnlgEdge_StartTrig_Lvl;
%rename("ANLG_EDGE_START_TRIG_HYST") DAQmx_AnlgEdge_StartTrig_Hyst;
%rename("ANLG_WIN_START_TRIG_SRC") DAQmx_AnlgWin_StartTrig_Src;
%rename("ANLG_WIN_START_TRIG_WHEN") DAQmx_AnlgWin_StartTrig_When;
%rename("ANLG_WIN_START_TRIG_TOP") DAQmx_AnlgWin_StartTrig_Top;
%rename("ANLG_WIN_START_TRIG_BTM") DAQmx_AnlgWin_StartTrig_Btm;
%rename("START_TRIG_DELAY") DAQmx_StartTrig_Delay;
%rename("START_TRIG_DELAY_UNITS") DAQmx_StartTrig_DelayUnits;
%rename("START_TRIG_RETRIGGERABLE") DAQmx_StartTrig_Retriggerable;
%rename("REF_TRIG_TYPE") DAQmx_RefTrig_Type;
%rename("REF_TRIG_PRETRIG_SAMPLES") DAQmx_RefTrig_PretrigSamples;
%rename("DIG_EDGE_REF_TRIG_SRC") DAQmx_DigEdge_RefTrig_Src;
%rename("DIG_EDGE_REF_TRIG_EDGE") DAQmx_DigEdge_RefTrig_Edge;
%rename("ANLG_EDGE_REF_TRIG_SRC") DAQmx_AnlgEdge_RefTrig_Src;
%rename("ANLG_EDGE_REF_TRIG_SLOPE") DAQmx_AnlgEdge_RefTrig_Slope;
%rename("ANLG_EDGE_REF_TRIG_LVL") DAQmx_AnlgEdge_RefTrig_Lvl;
%rename("ANLG_EDGE_REF_TRIG_HYST") DAQmx_AnlgEdge_RefTrig_Hyst;
%rename("ANLG_WIN_REF_TRIG_SRC") DAQmx_AnlgWin_RefTrig_Src;
%rename("ANLG_WIN_REF_TRIG_WHEN") DAQmx_AnlgWin_RefTrig_When;
%rename("ANLG_WIN_REF_TRIG_TOP") DAQmx_AnlgWin_RefTrig_Top;
%rename("ANLG_WIN_REF_TRIG_BTM") DAQmx_AnlgWin_RefTrig_Btm;
%rename("ADV_TRIG_TYPE") DAQmx_AdvTrig_Type;
%rename("DIG_EDGE_ADV_TRIG_SRC") DAQmx_DigEdge_AdvTrig_Src;
%rename("DIG_EDGE_ADV_TRIG_EDGE") DAQmx_DigEdge_AdvTrig_Edge;
%rename("PAUSE_TRIG_TYPE") DAQmx_PauseTrig_Type;
%rename("ANLG_LVL_PAUSE_TRIG_SRC") DAQmx_AnlgLvl_PauseTrig_Src;
%rename("ANLG_LVL_PAUSE_TRIG_WHEN") DAQmx_AnlgLvl_PauseTrig_When;
%rename("ANLG_LVL_PAUSE_TRIG_LVL") DAQmx_AnlgLvl_PauseTrig_Lvl;
%rename("ANLG_LVL_PAUSE_TRIG_HYST") DAQmx_AnlgLvl_PauseTrig_Hyst;
%rename("ANLG_WIN_PAUSE_TRIG_SRC") DAQmx_AnlgWin_PauseTrig_Src;
%rename("ANLG_WIN_PAUSE_TRIG_WHEN") DAQmx_AnlgWin_PauseTrig_When;
%rename("ANLG_WIN_PAUSE_TRIG_TOP") DAQmx_AnlgWin_PauseTrig_Top;
%rename("ANLG_WIN_PAUSE_TRIG_BTM") DAQmx_AnlgWin_PauseTrig_Btm;
%rename("DIG_LVL_PAUSE_TRIG_SRC") DAQmx_DigLvl_PauseTrig_Src;
%rename("DIG_LVL_PAUSE_TRIG_WHEN") DAQmx_DigLvl_PauseTrig_When;
%rename("ARM_START_TRIG_TYPE") DAQmx_ArmStartTrig_Type;
%rename("DIG_EDGE_ARM_START_TRIG_SRC") DAQmx_DigEdge_ArmStartTrig_Src;
%rename("DIG_EDGE_ARM_START_TRIG_EDGE") DAQmx_DigEdge_ArmStartTrig_Edge;
%rename("WATCHDOG_TIMEOUT") DAQmx_Watchdog_Timeout;
%rename("WATCHDOG_EXPIR_TRIG_TYPE") DAQmx_WatchdogExpirTrig_Type;
%rename("DIG_EDGE_WATCHDOG_EXPIR_TRIG_SRC") DAQmx_DigEdge_WatchdogExpirTrig_Src;
%rename("DIG_EDGE_WATCHDOG_EXPIR_TRIG_EDGE") DAQmx_DigEdge_WatchdogExpirTrig_Edge;
%rename("WATCHDOG_DO_EXPIR_STATE") DAQmx_Watchdog_DO_ExpirState;
%rename("WATCHDOG_HAS_EXPIRED") DAQmx_Watchdog_HasExpired;
%rename("WRITE_RELATIVE_TO") DAQmx_Write_RelativeTo;
%rename("WRITE_OFFSET") DAQmx_Write_Offset;
%rename("WRITE_REGEN_MODE") DAQmx_Write_RegenMode;
%rename("WRITE_CURR_WRITE_POS") DAQmx_Write_CurrWritePos;
%rename("WRITE_SPACE_AVAIL") DAQmx_Write_SpaceAvail;
%rename("WRITE_TOTAL_SAMP_PER_CHAN_GENERATED") DAQmx_Write_TotalSampPerChanGenerated;
%rename("WRITE_RAW_DATA_WIDTH") DAQmx_Write_RawDataWidth;
%rename("WRITE_NUM_CHANS") DAQmx_Write_NumChans;
%rename("WRITE_DIGITAL_LINES_BYTES_PER_CHAN") DAQmx_Write_DigitalLines_BytesPerChan;
%rename("VAL_TASK_START") DAQmx_Val_Task_Start;
%rename("VAL_TASK_STOP") DAQmx_Val_Task_Stop;
%rename("VAL_TASK_VERIFY") DAQmx_Val_Task_Verify;
%rename("VAL_TASK_COMMIT") DAQmx_Val_Task_Commit;
%rename("VAL_TASK_RESERVE") DAQmx_Val_Task_Reserve;
%rename("VAL_TASK_UNRESERVE") DAQmx_Val_Task_Unreserve;
%rename("VAL_TASK_ABORT") DAQmx_Val_Task_Abort;
%rename("VAL_RESET_TIMER") DAQmx_Val_ResetTimer;
%rename("VAL_CLEAR_EXPIRATION") DAQmx_Val_ClearExpiration;
%rename("VAL_CHAN_PER_LINE") DAQmx_Val_ChanPerLine;
%rename("VAL_CHAN_FOR_ALL_LINES") DAQmx_Val_ChanForAllLines;
%rename("VAL_GROUP_BY_CHANNEL") DAQmx_Val_GroupByChannel;
%rename("VAL_GROUP_BY_SCAN_NUMBER") DAQmx_Val_GroupByScanNumber;
%rename("VAL_DO_NOT_INVERT_POLARITY") DAQmx_Val_DoNotInvertPolarity;
%rename("VAL_INVERT_POLARITY") DAQmx_Val_InvertPolarity;
%rename("VAL_ACTION_COMMIT") DAQmx_Val_Action_Commit;
%rename("VAL_ACTION_CANCEL") DAQmx_Val_Action_Cancel;
%rename("VAL_ADVANCE_TRIGGER") DAQmx_Val_AdvanceTrigger;
%rename("VAL_AICONVERT_CLOCK") DAQmx_Val_AIConvertClock;
%rename("VAL_20MHZ_TIMEBASE_CLOCK") DAQmx_Val_20MHzTimebaseClock;
%rename("VAL_SAMPLE_CLOCK") DAQmx_Val_SampleClock;
%rename("VAL_ADVANCE_TRIGGER") DAQmx_Val_AdvanceTrigger;
%rename("VAL_REFERENCE_TRIGGER") DAQmx_Val_ReferenceTrigger;
%rename("VAL_START_TRIGGER") DAQmx_Val_StartTrigger;
%rename("VAL_ADV_CMPLT_EVENT") DAQmx_Val_AdvCmpltEvent;
%rename("VAL_AIHOLD_CMPLT_EVENT") DAQmx_Val_AIHoldCmpltEvent;
%rename("VAL_COUNTER_OUTPUT_EVENT") DAQmx_Val_CounterOutputEvent;
%rename("VAL_CHANGE_DETECTION_EVENT") DAQmx_Val_ChangeDetectionEvent;
%rename("VAL_WDTEXPIRED_EVENT") DAQmx_Val_WDTExpiredEvent;
%rename("VAL_RISING") DAQmx_Val_Rising;
%rename("VAL_FALLING") DAQmx_Val_Falling;
%rename("VAL_PATH_STATUS_AVAILABLE") DAQmx_Val_PathStatus_Available;
%rename("VAL_PATH_STATUS_ALREADY_EXISTS") DAQmx_Val_PathStatus_AlreadyExists;
%rename("VAL_PATH_STATUS_UNSUPPORTED") DAQmx_Val_PathStatus_Unsupported;
%rename("VAL_PATH_STATUS_CHANNEL_IN_USE") DAQmx_Val_PathStatus_ChannelInUse;
%rename("VAL_PATH_STATUS_SOURCE_CHANNEL_CONFLICT") DAQmx_Val_PathStatus_SourceChannelConflict;
%rename("VAL_PATH_STATUS_CHANNEL_RESERVED_FOR_ROUTING") DAQmx_Val_PathStatus_ChannelReservedForRouting;
%rename("VAL_DEG_C") DAQmx_Val_DegC;
%rename("VAL_DEG_F") DAQmx_Val_DegF;
%rename("VAL_KELVINS") DAQmx_Val_Kelvins;
%rename("VAL_DEG_R") DAQmx_Val_DegR;
%rename("VAL_HIGH") DAQmx_Val_High;
%rename("VAL_LOW") DAQmx_Val_Low;
%rename("VAL_TRISTATE") DAQmx_Val_Tristate;
%rename("VAL_OPEN") DAQmx_Val_Open;
%rename("VAL_CLOSED") DAQmx_Val_Closed;
%rename("VAL_CFG_DEFAULT") DAQmx_Val_Cfg_Default;
%rename("VAL_WAIT_INFINITELY") DAQmx_Val_WaitInfinitely;
%rename("VAL_AUTO") DAQmx_Val_Auto;
%rename("VAL_4WIRE") DAQmx_Val_4Wire;
%rename("VAL_5WIRE") DAQmx_Val_5Wire;
%rename("VAL_VOLTAGE") DAQmx_Val_Voltage;
%rename("VAL_CURRENT") DAQmx_Val_Current;
%rename("VAL_VOLTAGE_CUSTOM_WITH_EXCITATION") DAQmx_Val_Voltage_CustomWithExcitation;
%rename("VAL_FREQ_VOLTAGE") DAQmx_Val_Freq_Voltage;
%rename("VAL_RESISTANCE") DAQmx_Val_Resistance;
%rename("VAL_TEMP_TC") DAQmx_Val_Temp_TC;
%rename("VAL_TEMP_THRMSTR") DAQmx_Val_Temp_Thrmstr;
%rename("VAL_TEMP_RTD") DAQmx_Val_Temp_RTD;
%rename("VAL_TEMP_BUILT_IN_SENSOR") DAQmx_Val_Temp_BuiltInSensor;
%rename("VAL_STRAIN_GAGE") DAQmx_Val_Strain_Gage;
%rename("VAL_POSITION_LVDT") DAQmx_Val_Position_LVDT;
%rename("VAL_POSITION_RVDT") DAQmx_Val_Position_RVDT;
%rename("VAL_ACCELEROMETER") DAQmx_Val_Accelerometer;
%rename("VAL_VOLTAGE") DAQmx_Val_Voltage;
%rename("VAL_CURRENT") DAQmx_Val_Current;
%rename("VAL_M_VOLTS_PER_G") DAQmx_Val_mVoltsPerG;
%rename("VAL_VOLTS_PER_G") DAQmx_Val_VoltsPerG;
%rename("VAL_ACCEL_UNIT_G") DAQmx_Val_AccelUnit_g;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_FINITE_SAMPS") DAQmx_Val_FiniteSamps;
%rename("VAL_CONT_SAMPS") DAQmx_Val_ContSamps;
%rename("VAL_ABOVE_LVL") DAQmx_Val_AboveLvl;
%rename("VAL_BELOW_LVL") DAQmx_Val_BelowLvl;
%rename("VAL_DEGREES") DAQmx_Val_Degrees;
%rename("VAL_RADIANS") DAQmx_Val_Radians;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_DEGREES") DAQmx_Val_Degrees;
%rename("VAL_RADIANS") DAQmx_Val_Radians;
%rename("VAL_TICKS") DAQmx_Val_Ticks;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_NONE") DAQmx_Val_None;
%rename("VAL_ONCE") DAQmx_Val_Once;
%rename("VAL_NO_ACTION") DAQmx_Val_NoAction;
%rename("VAL_BREAK_BEFORE_MAKE") DAQmx_Val_BreakBeforeMake;
%rename("VAL_FULL_BRIDGE") DAQmx_Val_FullBridge;
%rename("VAL_HALF_BRIDGE") DAQmx_Val_HalfBridge;
%rename("VAL_QUARTER_BRIDGE") DAQmx_Val_QuarterBridge;
%rename("VAL_NO_BRIDGE") DAQmx_Val_NoBridge;
%rename("VAL_COUNT_EDGES") DAQmx_Val_CountEdges;
%rename("VAL_FREQ") DAQmx_Val_Freq;
%rename("VAL_PERIOD") DAQmx_Val_Period;
%rename("VAL_PULSE_WIDTH") DAQmx_Val_PulseWidth;
%rename("VAL_SEMI_PERIOD") DAQmx_Val_SemiPeriod;
%rename("VAL_POSITION_ANG_ENCODER") DAQmx_Val_Position_AngEncoder;
%rename("VAL_POSITION_LIN_ENCODER") DAQmx_Val_Position_LinEncoder;
%rename("VAL_TWO_EDGE_SEP") DAQmx_Val_TwoEdgeSep;
%rename("VAL_BUILT_IN") DAQmx_Val_BuiltIn;
%rename("VAL_CONST_VAL") DAQmx_Val_ConstVal;
%rename("VAL_CHAN") DAQmx_Val_Chan;
%rename("VAL_PULSE_TIME") DAQmx_Val_Pulse_Time;
%rename("VAL_PULSE_FREQ") DAQmx_Val_Pulse_Freq;
%rename("VAL_PULSE_TICKS") DAQmx_Val_Pulse_Ticks;
%rename("VAL_AI") DAQmx_Val_AI;
%rename("VAL_AO") DAQmx_Val_AO;
%rename("VAL_DI") DAQmx_Val_DI;
%rename("VAL_DO") DAQmx_Val_DO;
%rename("VAL_CI") DAQmx_Val_CI;
%rename("VAL_CO") DAQmx_Val_CO;
%rename("VAL_COUNT_UP") DAQmx_Val_CountUp;
%rename("VAL_COUNT_DOWN") DAQmx_Val_CountDown;
%rename("VAL_EXT_CONTROLLED") DAQmx_Val_ExtControlled;
%rename("VAL_LOW_FREQ1CTR") DAQmx_Val_LowFreq1Ctr;
%rename("VAL_HIGH_FREQ2CTR") DAQmx_Val_HighFreq2Ctr;
%rename("VAL_LARGE_RNG2CTR") DAQmx_Val_LargeRng2Ctr;
%rename("VAL_AC") DAQmx_Val_AC;
%rename("VAL_DC") DAQmx_Val_DC;
%rename("VAL_GND") DAQmx_Val_GND;
%rename("VAL_INTERNAL") DAQmx_Val_Internal;
%rename("VAL_EXTERNAL") DAQmx_Val_External;
%rename("VAL_AMPS") DAQmx_Val_Amps;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_DMA") DAQmx_Val_DMA;
%rename("VAL_INTERRUPTS") DAQmx_Val_Interrupts;
%rename("VAL_PROGRAMMED_IO") DAQmx_Val_ProgrammedIO;
%rename("VAL_HIGH") DAQmx_Val_High;
%rename("VAL_LOW") DAQmx_Val_Low;
%rename("VAL_TRISTATE") DAQmx_Val_Tristate;
%rename("VAL_NO_CHANGE") DAQmx_Val_NoChange;
%rename("VAL_SAMP_CLK_PERIODS") DAQmx_Val_SampClkPeriods;
%rename("VAL_SECONDS") DAQmx_Val_Seconds;
%rename("VAL_TICKS") DAQmx_Val_Ticks;
%rename("VAL_SECONDS") DAQmx_Val_Seconds;
%rename("VAL_TICKS") DAQmx_Val_Ticks;
%rename("VAL_SECONDS") DAQmx_Val_Seconds;
%rename("VAL_RISING") DAQmx_Val_Rising;
%rename("VAL_FALLING") DAQmx_Val_Falling;
%rename("VAL_X1") DAQmx_Val_X1;
%rename("VAL_X2") DAQmx_Val_X2;
%rename("VAL_X4") DAQmx_Val_X4;
%rename("VAL_TWO_PULSE_COUNTING") DAQmx_Val_TwoPulseCounting;
%rename("VAL_AHIGH_BHIGH") DAQmx_Val_AHighBHigh;
%rename("VAL_AHIGH_BLOW") DAQmx_Val_AHighBLow;
%rename("VAL_ALOW_BHIGH") DAQmx_Val_ALowBHigh;
%rename("VAL_ALOW_BLOW") DAQmx_Val_ALowBLow;
%rename("VAL_DC") DAQmx_Val_DC;
%rename("VAL_AC") DAQmx_Val_AC;
%rename("VAL_INTERNAL") DAQmx_Val_Internal;
%rename("VAL_EXTERNAL") DAQmx_Val_External;
%rename("VAL_NONE") DAQmx_Val_None;
%rename("VAL_VOLTAGE") DAQmx_Val_Voltage;
%rename("VAL_CURRENT") DAQmx_Val_Current;
%rename("VAL_PULSE") DAQmx_Val_Pulse;
%rename("VAL_TOGGLE") DAQmx_Val_Toggle;
%rename("VAL_PULSE") DAQmx_Val_Pulse;
%rename("VAL_LVL") DAQmx_Val_Lvl;
%rename("VAL_HZ") DAQmx_Val_Hz;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_HZ") DAQmx_Val_Hz;
%rename("VAL_HZ") DAQmx_Val_Hz;
%rename("VAL_TICKS") DAQmx_Val_Ticks;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_ON_BRD_MEM_MORE_THAN_HALF_FULL") DAQmx_Val_OnBrdMemMoreThanHalfFull;
%rename("VAL_ON_BRD_MEM_NOT_EMPTY") DAQmx_Val_OnBrdMemNotEmpty;
%rename("VAL_RSE") DAQmx_Val_RSE;
%rename("VAL_NRSE") DAQmx_Val_NRSE;
%rename("VAL_DIFF") DAQmx_Val_Diff;
%rename("VAL_M_VOLTS_PER_VOLT_PER_MILLIMETER") DAQmx_Val_mVoltsPerVoltPerMillimeter;
%rename("VAL_M_VOLTS_PER_VOLT_PER_MILLI_INCH") DAQmx_Val_mVoltsPerVoltPerMilliInch;
%rename("VAL_METERS") DAQmx_Val_Meters;
%rename("VAL_INCHES") DAQmx_Val_Inches;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_METERS") DAQmx_Val_Meters;
%rename("VAL_INCHES") DAQmx_Val_Inches;
%rename("VAL_TICKS") DAQmx_Val_Ticks;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_HIGH") DAQmx_Val_High;
%rename("VAL_LOW") DAQmx_Val_Low;
%rename("VAL_SAME_AS_SAMP_TIMEBASE") DAQmx_Val_SameAsSampTimebase;
%rename("VAL_SAME_AS_MASTER_TIMEBASE") DAQmx_Val_SameAsMasterTimebase;
%rename("VAL_ON_BRD_MEM_EMPTY") DAQmx_Val_OnBrdMemEmpty;
%rename("VAL_ON_BRD_MEM_HALF_FULL_OR_LESS") DAQmx_Val_OnBrdMemHalfFullOrLess;
%rename("VAL_ON_BRD_MEM_NOT_FULL") DAQmx_Val_OnBrdMemNotFull;
%rename("VAL_OVERWRITE_UNREAD_SAMPS") DAQmx_Val_OverwriteUnreadSamps;
%rename("VAL_DO_NOT_OVERWRITE_UNREAD_SAMPS") DAQmx_Val_DoNotOverwriteUnreadSamps;
%rename("VAL_ACTIVE_HIGH") DAQmx_Val_ActiveHigh;
%rename("VAL_ACTIVE_LOW") DAQmx_Val_ActiveLow;
%rename("VAL_PT3750") DAQmx_Val_Pt3750;
%rename("VAL_PT3851") DAQmx_Val_Pt3851;
%rename("VAL_PT3911") DAQmx_Val_Pt3911;
%rename("VAL_PT3916") DAQmx_Val_Pt3916;
%rename("VAL_PT3920") DAQmx_Val_Pt3920;
%rename("VAL_PT3928") DAQmx_Val_Pt3928;
%rename("VAL_CUSTOM") DAQmx_Val_Custom;
%rename("VAL_M_VOLTS_PER_VOLT_PER_DEGREE") DAQmx_Val_mVoltsPerVoltPerDegree;
%rename("VAL_M_VOLTS_PER_VOLT_PER_RADIAN") DAQmx_Val_mVoltsPerVoltPerRadian;
%rename("VAL_FIRST_SAMPLE") DAQmx_Val_FirstSample;
%rename("VAL_CURR_READ_POS") DAQmx_Val_CurrReadPos;
%rename("VAL_REF_TRIG") DAQmx_Val_RefTrig;
%rename("VAL_FIRST_PRETRIG_SAMP") DAQmx_Val_FirstPretrigSamp;
%rename("VAL_MOST_RECENT_SAMP") DAQmx_Val_MostRecentSamp;
%rename("VAL_ALLOW_REGEN") DAQmx_Val_AllowRegen;
%rename("VAL_DO_NOT_ALLOW_REGEN") DAQmx_Val_DoNotAllowRegen;
%rename("VAL_2WIRE") DAQmx_Val_2Wire;
%rename("VAL_3WIRE") DAQmx_Val_3Wire;
%rename("VAL_4WIRE") DAQmx_Val_4Wire;
%rename("VAL_OHMS") DAQmx_Val_Ohms;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_BITS") DAQmx_Val_Bits;
%rename("VAL_SAMP_CLK") DAQmx_Val_SampClk;
%rename("VAL_HANDSHAKE") DAQmx_Val_Handshake;
%rename("VAL_IMPLICIT") DAQmx_Val_Implicit;
%rename("VAL_ON_DEMAND") DAQmx_Val_OnDemand;
%rename("VAL_CHANGE_DETECTION") DAQmx_Val_ChangeDetection;
%rename("VAL_LINEAR") DAQmx_Val_Linear;
%rename("VAL_MAP_RANGES") DAQmx_Val_MapRanges;
%rename("VAL_POLYNOMIAL") DAQmx_Val_Polynomial;
%rename("VAL_TABLE") DAQmx_Val_Table;
%rename("VAL_A") DAQmx_Val_A;
%rename("VAL_B") DAQmx_Val_B;
%rename("VAL_AAND_B") DAQmx_Val_AandB;
%rename("VAL_RISING_SLOPE") DAQmx_Val_RisingSlope;
%rename("VAL_FALLING_SLOPE") DAQmx_Val_FallingSlope;
%rename("VAL_INTERNAL") DAQmx_Val_Internal;
%rename("VAL_EXTERNAL") DAQmx_Val_External;
%rename("VAL_FULL_BRIDGE_I") DAQmx_Val_FullBridgeI;
%rename("VAL_FULL_BRIDGE_II") DAQmx_Val_FullBridgeII;
%rename("VAL_FULL_BRIDGE_III") DAQmx_Val_FullBridgeIII;
%rename("VAL_HALF_BRIDGE_I") DAQmx_Val_HalfBridgeI;
%rename("VAL_HALF_BRIDGE_II") DAQmx_Val_HalfBridgeII;
%rename("VAL_QUARTER_BRIDGE_I") DAQmx_Val_QuarterBridgeI;
%rename("VAL_QUARTER_BRIDGE_II") DAQmx_Val_QuarterBridgeII;
%rename("VAL_STRAIN") DAQmx_Val_Strain;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_FINITE") DAQmx_Val_Finite;
%rename("VAL_CONT") DAQmx_Val_Cont;
%rename("VAL_SOURCE") DAQmx_Val_Source;
%rename("VAL_LOAD") DAQmx_Val_Load;
%rename("VAL_RESERVED_FOR_ROUTING") DAQmx_Val_ReservedForRouting;
%rename("VAL_DEG_C") DAQmx_Val_DegC;
%rename("VAL_DEG_F") DAQmx_Val_DegF;
%rename("VAL_KELVINS") DAQmx_Val_Kelvins;
%rename("VAL_DEG_R") DAQmx_Val_DegR;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_J_TYPE_TC") DAQmx_Val_J_Type_TC;
%rename("VAL_K_TYPE_TC") DAQmx_Val_K_Type_TC;
%rename("VAL_N_TYPE_TC") DAQmx_Val_N_Type_TC;
%rename("VAL_R_TYPE_TC") DAQmx_Val_R_Type_TC;
%rename("VAL_S_TYPE_TC") DAQmx_Val_S_Type_TC;
%rename("VAL_T_TYPE_TC") DAQmx_Val_T_Type_TC;
%rename("VAL_B_TYPE_TC") DAQmx_Val_B_Type_TC;
%rename("VAL_E_TYPE_TC") DAQmx_Val_E_Type_TC;
%rename("VAL_SECONDS") DAQmx_Val_Seconds;
%rename("VAL_SECONDS") DAQmx_Val_Seconds;
%rename("VAL_TICKS") DAQmx_Val_Ticks;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_ANLG_EDGE") DAQmx_Val_AnlgEdge;
%rename("VAL_DIG_EDGE") DAQmx_Val_DigEdge;
%rename("VAL_ANLG_WIN") DAQmx_Val_AnlgWin;
%rename("VAL_NONE") DAQmx_Val_None;
%rename("VAL_DIG_EDGE") DAQmx_Val_DigEdge;
%rename("VAL_NONE") DAQmx_Val_None;
%rename("VAL_DIG_EDGE") DAQmx_Val_DigEdge;
%rename("VAL_SOFTWARE") DAQmx_Val_Software;
%rename("VAL_NONE") DAQmx_Val_None;
%rename("VAL_ANLG_LVL") DAQmx_Val_AnlgLvl;
%rename("VAL_ANLG_WIN") DAQmx_Val_AnlgWin;
%rename("VAL_DIG_LVL") DAQmx_Val_DigLvl;
%rename("VAL_NONE") DAQmx_Val_None;
%rename("VAL_ANLG_EDGE") DAQmx_Val_AnlgEdge;
%rename("VAL_DIG_EDGE") DAQmx_Val_DigEdge;
%rename("VAL_ANLG_WIN") DAQmx_Val_AnlgWin;
%rename("VAL_NONE") DAQmx_Val_None;
%rename("VAL_VOLTS") DAQmx_Val_Volts;
%rename("VAL_AMPS") DAQmx_Val_Amps;
%rename("VAL_DEG_F") DAQmx_Val_DegF;
%rename("VAL_DEG_C") DAQmx_Val_DegC;
%rename("VAL_DEG_R") DAQmx_Val_DegR;
%rename("VAL_KELVINS") DAQmx_Val_Kelvins;
%rename("VAL_STRAIN") DAQmx_Val_Strain;
%rename("VAL_OHMS") DAQmx_Val_Ohms;
%rename("VAL_HZ") DAQmx_Val_Hz;
%rename("VAL_SECONDS") DAQmx_Val_Seconds;
%rename("VAL_METERS") DAQmx_Val_Meters;
%rename("VAL_INCHES") DAQmx_Val_Inches;
%rename("VAL_DEGREES") DAQmx_Val_Degrees;
%rename("VAL_RADIANS") DAQmx_Val_Radians;
%rename("VAL_G") DAQmx_Val_g;
%rename("VAL_VOLTS") DAQmx_Val_Volts;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_VOLTS") DAQmx_Val_Volts;
%rename("VAL_FROM_CUSTOM_SCALE") DAQmx_Val_FromCustomScale;
%rename("VAL_ENTERING_WIN") DAQmx_Val_EnteringWin;
%rename("VAL_LEAVING_WIN") DAQmx_Val_LeavingWin;
%rename("VAL_INSIDE_WIN") DAQmx_Val_InsideWin;
%rename("VAL_OUTSIDE_WIN") DAQmx_Val_OutsideWin;
%rename("VAL_FIRST_SAMPLE") DAQmx_Val_FirstSample;
%rename("VAL_CURR_WRITE_POS") DAQmx_Val_CurrWritePos;
// DAQmxBaseLoadTask(const char taskName[], TaskHandle *taskHandle)
%ignore DAQmxBaseLoadTask;
    %inline {
      int32 load_task(const char taskName[], TaskHandle *taskHandle) {
        int32 result = DAQmxBaseLoadTask(taskName, taskHandle);
        if (result) handle_DAQmx_error("load_task", result);
        return result;
      }
    };
// DAQmxBaseCreateTask(const char taskName[], TaskHandle *taskHandle)
%ignore DAQmxBaseCreateTask;
    %inline {
      int32 create_task(const char taskName[], Task *taskHandle) {
        int32 result = DAQmxBaseCreateTask(taskName, (TaskHandle *)taskHandle);
        if (result) handle_DAQmx_error("create_task", result);
        return result;
      }
    };
// DAQmxBaseStartTask(TaskHandle taskHandle)
%ignore DAQmxBaseStartTask;
    %extend Task {
      int32 start_task() {
        int32 result = DAQmxBaseStartTask((TaskHandle)$self);
        if (result) handle_DAQmx_error("start_task", result);
        return result;
      }
    };
// DAQmxBaseStopTask(TaskHandle taskHandle)
%ignore DAQmxBaseStopTask;
    %extend Task {
      int32 stop_task() {
        int32 result = DAQmxBaseStopTask((TaskHandle)$self);
        if (result) handle_DAQmx_error("stop_task", result);
        return result;
      }
    };
// DAQmxBaseClearTask(TaskHandle taskHandle)
%ignore DAQmxBaseClearTask;
    %extend Task {
      int32 clear_task() {
        int32 result = DAQmxBaseClearTask((TaskHandle)$self);
        if (result) handle_DAQmx_error("clear_task", result);
        return result;
      }
    };
// DAQmxBaseIsTaskDone(TaskHandle taskHandle, bool32 *isTaskDone)
%ignore DAQmxBaseIsTaskDone;
    %extend Task {
      int32 is_task_done(bool32 *isTaskDone) {
        int32 result = DAQmxBaseIsTaskDone((TaskHandle)$self, isTaskDone);
        if (result) handle_DAQmx_error("is_task_done", result);
        return result;
      }
    };
// DAQmxBaseCreateAIVoltageChan(TaskHandle taskHandle, const char physicalChannel[], const char nameToAssignToChannel[], int32 terminalConfig, float64 minVal, float64 maxVal, int32 units, const char customScaleName[])
%ignore DAQmxBaseCreateAIVoltageChan;
    %extend Task {
      int32 create_aivoltage_chan(const char physicalChannel[], const char nameToAssignToChannel[], int32 terminalConfig, float64 minVal, float64 maxVal, int32 units, const char customScaleName[]) {
        int32 result = DAQmxBaseCreateAIVoltageChan((TaskHandle)$self, physicalChannel, nameToAssignToChannel, terminalConfig, minVal, maxVal, units, customScaleName);
        if (result) handle_DAQmx_error("create_aivoltage_chan", result);
        return result;
      }
    };
// DAQmxBaseCreateAIThrmcplChan(TaskHandle taskHandle, const char physicalChannel[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, int32 thermocoupleType, int32 cjcSource, float64 cjcVal, const char cjcChannel[])
%ignore DAQmxBaseCreateAIThrmcplChan;
    %extend Task {
      int32 create_aithrmcpl_chan(const char physicalChannel[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, int32 thermocoupleType, int32 cjcSource, float64 cjcVal, const char cjcChannel[]) {
        int32 result = DAQmxBaseCreateAIThrmcplChan((TaskHandle)$self, physicalChannel, nameToAssignToChannel, minVal, maxVal, units, thermocoupleType, cjcSource, cjcVal, cjcChannel);
        if (result) handle_DAQmx_error("create_aithrmcpl_chan", result);
        return result;
      }
    };
// DAQmxBaseCreateAOVoltageChan(TaskHandle taskHandle, const char physicalChannel[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, const char customScaleName[])
%ignore DAQmxBaseCreateAOVoltageChan;
    %extend Task {
      int32 create_aovoltage_chan(const char physicalChannel[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, const char customScaleName[]) {
        int32 result = DAQmxBaseCreateAOVoltageChan((TaskHandle)$self, physicalChannel, nameToAssignToChannel, minVal, maxVal, units, customScaleName);
        if (result) handle_DAQmx_error("create_aovoltage_chan", result);
        return result;
      }
    };
// DAQmxBaseCreateDIChan(TaskHandle taskHandle, const char lines[], const char nameToAssignToLines[], int32 lineGrouping)
%ignore DAQmxBaseCreateDIChan;
    %extend Task {
      int32 create_dichan(const char lines[], const char nameToAssignToLines[], int32 lineGrouping) {
        int32 result = DAQmxBaseCreateDIChan((TaskHandle)$self, lines, nameToAssignToLines, lineGrouping);
        if (result) handle_DAQmx_error("create_dichan", result);
        return result;
      }
    };
// DAQmxBaseCreateDOChan(TaskHandle taskHandle, const char lines[], const char nameToAssignToLines[], int32 lineGrouping)
%ignore DAQmxBaseCreateDOChan;
    %extend Task {
      int32 create_dochan(const char lines[], const char nameToAssignToLines[], int32 lineGrouping) {
        int32 result = DAQmxBaseCreateDOChan((TaskHandle)$self, lines, nameToAssignToLines, lineGrouping);
        if (result) handle_DAQmx_error("create_dochan", result);
        return result;
      }
    };
// DAQmxBaseCreateCIPeriodChan(TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, int32 edge, int32 measMethod, float64 measTime, uInt32 divisor, const char customScaleName[])
%ignore DAQmxBaseCreateCIPeriodChan;
    %extend Task {
      int32 create_ciperiod_chan(const char counter[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, int32 edge, int32 measMethod, float64 measTime, uInt32 divisor, const char customScaleName[]) {
        int32 result = DAQmxBaseCreateCIPeriodChan((TaskHandle)$self, counter, nameToAssignToChannel, minVal, maxVal, units, edge, measMethod, measTime, divisor, customScaleName);
        if (result) handle_DAQmx_error("create_ciperiod_chan", result);
        return result;
      }
    };
// DAQmxBaseCreateCICountEdgesChan(TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], int32 edge, uInt32 initialCount, int32 countDirection)
%ignore DAQmxBaseCreateCICountEdgesChan;
    %extend Task {
      int32 create_cicount_edges_chan(const char counter[], const char nameToAssignToChannel[], int32 edge, uInt32 initialCount, int32 countDirection) {
        int32 result = DAQmxBaseCreateCICountEdgesChan((TaskHandle)$self, counter, nameToAssignToChannel, edge, initialCount, countDirection);
        if (result) handle_DAQmx_error("create_cicount_edges_chan", result);
        return result;
      }
    };
// DAQmxBaseCreateCIPulseWidthChan(TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, int32 startingEdge, const char customScaleName[])
%ignore DAQmxBaseCreateCIPulseWidthChan;
    %extend Task {
      int32 create_cipulse_width_chan(const char counter[], const char nameToAssignToChannel[], float64 minVal, float64 maxVal, int32 units, int32 startingEdge, const char customScaleName[]) {
        int32 result = DAQmxBaseCreateCIPulseWidthChan((TaskHandle)$self, counter, nameToAssignToChannel, minVal, maxVal, units, startingEdge, customScaleName);
        if (result) handle_DAQmx_error("create_cipulse_width_chan", result);
        return result;
      }
    };
// DAQmxBaseCreateCOPulseChanFreq(TaskHandle taskHandle, const char counter[], const char nameToAssignToChannel[], int32 units, int32 idleState, float64 initialDelay, float64 freq, float64 dutyCycle)
%ignore DAQmxBaseCreateCOPulseChanFreq;
    %extend Task {
      int32 create_copulse_chan_freq(const char counter[], const char nameToAssignToChannel[], int32 units, int32 idleState, float64 initialDelay, float64 freq, float64 dutyCycle) {
        int32 result = DAQmxBaseCreateCOPulseChanFreq((TaskHandle)$self, counter, nameToAssignToChannel, units, idleState, initialDelay, freq, dutyCycle);
        if (result) handle_DAQmx_error("create_copulse_chan_freq", result);
        return result;
      }
    };
// DAQmxBaseCfgSampClkTiming(TaskHandle taskHandle, const char source[], float64 rate, int32 activeEdge, int32 sampleMode, uInt64 sampsPerChan)
%ignore DAQmxBaseCfgSampClkTiming;
    %extend Task {
      int32 cfg_samp_clk_timing(const char source[], float64 rate, int32 activeEdge, int32 sampleMode, uInt64 sampsPerChan) {
        int32 result = DAQmxBaseCfgSampClkTiming((TaskHandle)$self, source, rate, activeEdge, sampleMode, sampsPerChan);
        if (result) handle_DAQmx_error("cfg_samp_clk_timing", result);
        return result;
      }
    };
// DAQmxBaseCfgImplicitTiming(TaskHandle taskHandle, int32 sampleMode, uInt64 sampsPerChan)
%ignore DAQmxBaseCfgImplicitTiming;
    %extend Task {
      int32 cfg_implicit_timing(int32 sampleMode, uInt64 sampsPerChan) {
        int32 result = DAQmxBaseCfgImplicitTiming((TaskHandle)$self, sampleMode, sampsPerChan);
        if (result) handle_DAQmx_error("cfg_implicit_timing", result);
        return result;
      }
    };
// DAQmxBaseDisableStartTrig(TaskHandle taskHandle)
%ignore DAQmxBaseDisableStartTrig;
    %extend Task {
      int32 disable_start_trig() {
        int32 result = DAQmxBaseDisableStartTrig((TaskHandle)$self);
        if (result) handle_DAQmx_error("disable_start_trig", result);
        return result;
      }
    };
// DAQmxBaseCfgDigEdgeStartTrig(TaskHandle taskHandle, const char triggerSource[], int32 triggerEdge)
%ignore DAQmxBaseCfgDigEdgeStartTrig;
    %extend Task {
      int32 cfg_dig_edge_start_trig(const char triggerSource[], int32 triggerEdge) {
        int32 result = DAQmxBaseCfgDigEdgeStartTrig((TaskHandle)$self, triggerSource, triggerEdge);
        if (result) handle_DAQmx_error("cfg_dig_edge_start_trig", result);
        return result;
      }
    };
// DAQmxBaseCfgAnlgEdgeStartTrig(TaskHandle taskHandle, const char triggerSource[], int32 triggerSlope, float64 triggerLevel)
%ignore DAQmxBaseCfgAnlgEdgeStartTrig;
    %extend Task {
      int32 cfg_anlg_edge_start_trig(const char triggerSource[], int32 triggerSlope, float64 triggerLevel) {
        int32 result = DAQmxBaseCfgAnlgEdgeStartTrig((TaskHandle)$self, triggerSource, triggerSlope, triggerLevel);
        if (result) handle_DAQmx_error("cfg_anlg_edge_start_trig", result);
        return result;
      }
    };
// DAQmxBaseDisableRefTrig(TaskHandle taskHandle)
%ignore DAQmxBaseDisableRefTrig;
    %extend Task {
      int32 disable_ref_trig() {
        int32 result = DAQmxBaseDisableRefTrig((TaskHandle)$self);
        if (result) handle_DAQmx_error("disable_ref_trig", result);
        return result;
      }
    };
// DAQmxBaseCfgDigEdgeRefTrig(TaskHandle taskHandle, const char triggerSource[], int32 triggerEdge, uInt32 pretriggerSamples)
%ignore DAQmxBaseCfgDigEdgeRefTrig;
    %extend Task {
      int32 cfg_dig_edge_ref_trig(const char triggerSource[], int32 triggerEdge, uInt32 pretriggerSamples) {
        int32 result = DAQmxBaseCfgDigEdgeRefTrig((TaskHandle)$self, triggerSource, triggerEdge, pretriggerSamples);
        if (result) handle_DAQmx_error("cfg_dig_edge_ref_trig", result);
        return result;
      }
    };
// DAQmxBaseCfgAnlgEdgeRefTrig(TaskHandle taskHandle, const char triggerSource[], int32 triggerSlope, float64 triggerLevel, uInt32 pretriggerSamples)
%ignore DAQmxBaseCfgAnlgEdgeRefTrig;
    %extend Task {
      int32 cfg_anlg_edge_ref_trig(const char triggerSource[], int32 triggerSlope, float64 triggerLevel, uInt32 pretriggerSamples) {
        int32 result = DAQmxBaseCfgAnlgEdgeRefTrig((TaskHandle)$self, triggerSource, triggerSlope, triggerLevel, pretriggerSamples);
        if (result) handle_DAQmx_error("cfg_anlg_edge_ref_trig", result);
        return result;
      }
    };
// DAQmxBaseReadAnalogF64(TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, bool32 fillMode, float64 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
%ignore DAQmxBaseReadAnalogF64;
    %extend Task {
      int32 read_analog_f64(int32 numSampsPerChan, float64 timeout, bool32 fillMode, float64 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved) {
        int32 result = DAQmxBaseReadAnalogF64((TaskHandle)$self, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved);
        if (result) handle_DAQmx_error("read_analog_f64", result);
        return result;
      }
    };
// DAQmxBaseReadBinaryI16(TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, bool32 fillMode, int16 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
%ignore DAQmxBaseReadBinaryI16;
    %extend Task {
      int32 read_binary_i16(int32 numSampsPerChan, float64 timeout, bool32 fillMode, int16 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved) {
        int32 result = DAQmxBaseReadBinaryI16((TaskHandle)$self, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved);
        if (result) handle_DAQmx_error("read_binary_i16", result);
        return result;
      }
    };
// DAQmxBaseReadBinaryI32(TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, bool32 fillMode, int32 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
%ignore DAQmxBaseReadBinaryI32;
    %extend Task {
      int32 read_binary_i32(int32 numSampsPerChan, float64 timeout, bool32 fillMode, int32 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved) {
        int32 result = DAQmxBaseReadBinaryI32((TaskHandle)$self, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved);
        if (result) handle_DAQmx_error("read_binary_i32", result);
        return result;
      }
    };
// DAQmxBaseReadDigitalU8(TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, bool32 fillMode, uInt8 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
%ignore DAQmxBaseReadDigitalU8;
    %extend Task {
      int32 read_digital_u8(int32 numSampsPerChan, float64 timeout, bool32 fillMode, uInt8 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved) {
        int32 result = DAQmxBaseReadDigitalU8((TaskHandle)$self, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved);
        if (result) handle_DAQmx_error("read_digital_u8", result);
        return result;
      }
    };
// DAQmxBaseReadDigitalU32(TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, bool32 fillMode, uInt32 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
%ignore DAQmxBaseReadDigitalU32;
    %extend Task {
      int32 read_digital_u32(int32 numSampsPerChan, float64 timeout, bool32 fillMode, uInt32 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved) {
        int32 result = DAQmxBaseReadDigitalU32((TaskHandle)$self, numSampsPerChan, timeout, fillMode, readArray, arraySizeInSamps, sampsPerChanRead, reserved);
        if (result) handle_DAQmx_error("read_digital_u32", result);
        return result;
      }
    };
// DAQmxBaseReadDigitalScalarU32(TaskHandle taskHandle, float64 timeout, uInt32 *value, bool32 *reserved)
%ignore DAQmxBaseReadDigitalScalarU32;
    %extend Task {
      int32 read_digital_scalar_u32(float64 timeout, uInt32 *value, bool32 *reserved) {
        int32 result = DAQmxBaseReadDigitalScalarU32((TaskHandle)$self, timeout, value, reserved);
        if (result) handle_DAQmx_error("read_digital_scalar_u32", result);
        return result;
      }
    };
// DAQmxBaseReadCounterF64(TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, float64 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
%ignore DAQmxBaseReadCounterF64;
    %extend Task {
      int32 read_counter_f64(int32 numSampsPerChan, float64 timeout, float64 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved) {
        int32 result = DAQmxBaseReadCounterF64((TaskHandle)$self, numSampsPerChan, timeout, readArray, arraySizeInSamps, sampsPerChanRead, reserved);
        if (result) handle_DAQmx_error("read_counter_f64", result);
        return result;
      }
    };
// DAQmxBaseReadCounterU32(TaskHandle taskHandle, int32 numSampsPerChan, float64 timeout, uInt32 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved)
%ignore DAQmxBaseReadCounterU32;
    %extend Task {
      int32 read_counter_u32(int32 numSampsPerChan, float64 timeout, uInt32 readArray[], uInt32 arraySizeInSamps, int32 *sampsPerChanRead, bool32 *reserved) {
        int32 result = DAQmxBaseReadCounterU32((TaskHandle)$self, numSampsPerChan, timeout, readArray, arraySizeInSamps, sampsPerChanRead, reserved);
        if (result) handle_DAQmx_error("read_counter_u32", result);
        return result;
      }
    };
// DAQmxBaseReadCounterScalarF64(TaskHandle taskHandle, float64 timeout, float64 *value, bool32 *reserved)
%ignore DAQmxBaseReadCounterScalarF64;
    %extend Task {
      int32 read_counter_scalar_f64(float64 timeout, float64 *value, bool32 *reserved) {
        int32 result = DAQmxBaseReadCounterScalarF64((TaskHandle)$self, timeout, value, reserved);
        if (result) handle_DAQmx_error("read_counter_scalar_f64", result);
        return result;
      }
    };
// DAQmxBaseReadCounterScalarU32(TaskHandle taskHandle, float64 timeout, uInt32 *value, bool32 *reserved)
%ignore DAQmxBaseReadCounterScalarU32;
    %extend Task {
      int32 read_counter_scalar_u32(float64 timeout, uInt32 *value, bool32 *reserved) {
        int32 result = DAQmxBaseReadCounterScalarU32((TaskHandle)$self, timeout, value, reserved);
        if (result) handle_DAQmx_error("read_counter_scalar_u32", result);
        return result;
      }
    };
// DAQmxBaseWriteAnalogF64(TaskHandle taskHandle, int32 numSampsPerChan, bool32 autoStart, float64 timeout, bool32 dataLayout, float64 writeArray[], int32 *sampsPerChanWritten, bool32 *reserved)
%ignore DAQmxBaseWriteAnalogF64;
    %extend Task {
      int32 write_analog_f64(int32 numSampsPerChan, bool32 autoStart, float64 timeout, bool32 dataLayout, float64 writeArray[], int32 *sampsPerChanWritten, bool32 *reserved) {
        int32 result = DAQmxBaseWriteAnalogF64((TaskHandle)$self, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved);
        if (result) handle_DAQmx_error("write_analog_f64", result);
        return result;
      }
    };
// DAQmxBaseWriteDigitalU8(TaskHandle taskHandle, int32 numSampsPerChan, bool32 autoStart, float64 timeout, bool32 dataLayout, uInt8 writeArray[], int32 *sampsPerChanWritten, bool32 *reserved)
%ignore DAQmxBaseWriteDigitalU8;
    %extend Task {
      int32 write_digital_u8(int32 numSampsPerChan, bool32 autoStart, float64 timeout, bool32 dataLayout, uInt8 writeArray[], int32 *sampsPerChanWritten, bool32 *reserved) {
        int32 result = DAQmxBaseWriteDigitalU8((TaskHandle)$self, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved);
        if (result) handle_DAQmx_error("write_digital_u8", result);
        return result;
      }
    };
// DAQmxBaseWriteDigitalU32(TaskHandle taskHandle, int32 numSampsPerChan, bool32 autoStart, float64 timeout, bool32 dataLayout, uInt32 writeArray[], int32 *sampsPerChanWritten, bool32 *reserved)
%ignore DAQmxBaseWriteDigitalU32;
    %extend Task {
      int32 write_digital_u32(int32 numSampsPerChan, bool32 autoStart, float64 timeout, bool32 dataLayout, uInt32 writeArray[], int32 *sampsPerChanWritten, bool32 *reserved) {
        int32 result = DAQmxBaseWriteDigitalU32((TaskHandle)$self, numSampsPerChan, autoStart, timeout, dataLayout, writeArray, sampsPerChanWritten, reserved);
        if (result) handle_DAQmx_error("write_digital_u32", result);
        return result;
      }
    };
// DAQmxBaseWriteDigitalScalarU32(TaskHandle taskHandle, bool32 autoStart, float64 timeout, uInt32 value, bool32 *reserved)
%ignore DAQmxBaseWriteDigitalScalarU32;
    %extend Task {
      int32 write_digital_scalar_u32(bool32 autoStart, float64 timeout, uInt32 value, bool32 *reserved) {
        int32 result = DAQmxBaseWriteDigitalScalarU32((TaskHandle)$self, autoStart, timeout, value, reserved);
        if (result) handle_DAQmx_error("write_digital_scalar_u32", result);
        return result;
      }
    };
// DAQmxBaseCfgInputBuffer(TaskHandle taskHandle, uInt32 numSampsPerChan)
%ignore DAQmxBaseCfgInputBuffer;
    %extend Task {
      int32 cfg_input_buffer(uInt32 numSampsPerChan) {
        int32 result = DAQmxBaseCfgInputBuffer((TaskHandle)$self, numSampsPerChan);
        if (result) handle_DAQmx_error("cfg_input_buffer", result);
        return result;
      }
    };
%rename("VAL_SWITCH_TOPOLOGY_1127_1_WIRE_64X1_MUX") DAQmx_Val_Switch_Topology_1127_1_Wire_64x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1127_2_WIRE_32X1_MUX") DAQmx_Val_Switch_Topology_1127_2_Wire_32x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1127_2_WIRE_4X8_MATRIX") DAQmx_Val_Switch_Topology_1127_2_Wire_4x8_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1127_4_WIRE_16X1_MUX") DAQmx_Val_Switch_Topology_1127_4_Wire_16x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1127_INDEPENDENT") DAQmx_Val_Switch_Topology_1127_Independent;
%rename("VAL_SWITCH_TOPOLOGY_1128_1_WIRE_64X1_MUX") DAQmx_Val_Switch_Topology_1128_1_Wire_64x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1128_2_WIRE_32X1_MUX") DAQmx_Val_Switch_Topology_1128_2_Wire_32x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1128_2_WIRE_4X8_MATRIX") DAQmx_Val_Switch_Topology_1128_2_Wire_4x8_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1128_4_WIRE_16X1_MUX") DAQmx_Val_Switch_Topology_1128_4_Wire_16x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1128_INDEPENDENT") DAQmx_Val_Switch_Topology_1128_Independent;
%rename("VAL_SWITCH_TOPOLOGY_1129_2_WIRE_16X16_MATRIX") DAQmx_Val_Switch_Topology_1129_2_Wire_16x16_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1129_2_WIRE_8X32_MATRIX") DAQmx_Val_Switch_Topology_1129_2_Wire_8x32_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1129_2_WIRE_4X64_MATRIX") DAQmx_Val_Switch_Topology_1129_2_Wire_4x64_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1129_2_WIRE_DUAL_8X16_MATRIX") DAQmx_Val_Switch_Topology_1129_2_Wire_Dual_8x16_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1129_2_WIRE_DUAL_4X32_MATRIX") DAQmx_Val_Switch_Topology_1129_2_Wire_Dual_4x32_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1129_2_WIRE_QUAD_4X16_MATRIX") DAQmx_Val_Switch_Topology_1129_2_Wire_Quad_4x16_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1130_1_WIRE_256X1_MUX") DAQmx_Val_Switch_Topology_1130_1_Wire_256x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1130_2_WIRE_128X1_MUX") DAQmx_Val_Switch_Topology_1130_2_Wire_128x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1130_4_WIRE_64X1_MUX") DAQmx_Val_Switch_Topology_1130_4_Wire_64x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1130_1_WIRE_4X64_MATRIX") DAQmx_Val_Switch_Topology_1130_1_Wire_4x64_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1130_1_WIRE_8X32_MATRIX") DAQmx_Val_Switch_Topology_1130_1_Wire_8x32_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1130_2_WIRE_4X32_MATRIX") DAQmx_Val_Switch_Topology_1130_2_Wire_4x32_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_1130_INDEPENDENT") DAQmx_Val_Switch_Topology_1130_Independent;
%rename("VAL_SWITCH_TOPOLOGY_1160_16_SPDT") DAQmx_Val_Switch_Topology_1160_16_SPDT;
%rename("VAL_SWITCH_TOPOLOGY_1161_8_SPDT") DAQmx_Val_Switch_Topology_1161_8_SPDT;
%rename("VAL_SWITCH_TOPOLOGY_1163R_OCTAL_4X1_MUX") DAQmx_Val_Switch_Topology_1163R_Octal_4x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1166_32_SPDT") DAQmx_Val_Switch_Topology_1166_32_SPDT;
%rename("VAL_SWITCH_TOPOLOGY_1167_INDEPENDENT") DAQmx_Val_Switch_Topology_1167_Independent;
%rename("VAL_SWITCH_TOPOLOGY_1190_QUAD_4X1_MUX") DAQmx_Val_Switch_Topology_1190_Quad_4x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1191_QUAD_4X1_MUX") DAQmx_Val_Switch_Topology_1191_Quad_4x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1192_8_SPDT") DAQmx_Val_Switch_Topology_1192_8_SPDT;
%rename("VAL_SWITCH_TOPOLOGY_1193_32X1_MUX") DAQmx_Val_Switch_Topology_1193_32x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1193_DUAL_16X1_MUX") DAQmx_Val_Switch_Topology_1193_Dual_16x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1193_QUAD_8X1_MUX") DAQmx_Val_Switch_Topology_1193_Quad_8x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1193_16X1_TERMINATED_MUX") DAQmx_Val_Switch_Topology_1193_16x1_Terminated_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1193_DUAL_8X1_TERMINATED_MUX") DAQmx_Val_Switch_Topology_1193_Dual_8x1_Terminated_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1193_QUAD_4X1_TERMINATED_MUX") DAQmx_Val_Switch_Topology_1193_Quad_4x1_Terminated_Mux;
%rename("VAL_SWITCH_TOPOLOGY_1193_INDEPENDENT") DAQmx_Val_Switch_Topology_1193_Independent;
%rename("VAL_SWITCH_TOPOLOGY_2529_2_WIRE_8X16_MATRIX") DAQmx_Val_Switch_Topology_2529_2_Wire_8x16_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_2529_2_WIRE_4X32_MATRIX") DAQmx_Val_Switch_Topology_2529_2_Wire_4x32_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_2529_2_WIRE_DUAL_4X16_MATRIX") DAQmx_Val_Switch_Topology_2529_2_Wire_Dual_4x16_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_2530_1_WIRE_128X1_MUX") DAQmx_Val_Switch_Topology_2530_1_Wire_128x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_2530_2_WIRE_64X1_MUX") DAQmx_Val_Switch_Topology_2530_2_Wire_64x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_2530_4_WIRE_32X1_MUX") DAQmx_Val_Switch_Topology_2530_4_Wire_32x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_2530_1_WIRE_4X32_MATRIX") DAQmx_Val_Switch_Topology_2530_1_Wire_4x32_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_2530_1_WIRE_8X16_MATRIX") DAQmx_Val_Switch_Topology_2530_1_Wire_8x16_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_2530_2_WIRE_4X16_MATRIX") DAQmx_Val_Switch_Topology_2530_2_Wire_4x16_Matrix;
%rename("VAL_SWITCH_TOPOLOGY_2530_INDEPENDENT") DAQmx_Val_Switch_Topology_2530_Independent;
%rename("VAL_SWITCH_TOPOLOGY_2566_16_SPDT") DAQmx_Val_Switch_Topology_2566_16_SPDT;
%rename("VAL_SWITCH_TOPOLOGY_2567_INDEPENDENT") DAQmx_Val_Switch_Topology_2567_Independent;
%rename("VAL_SWITCH_TOPOLOGY_2570_40_SPDT") DAQmx_Val_Switch_Topology_2570_40_SPDT;
%rename("VAL_SWITCH_TOPOLOGY_2593_16X1_MUX") DAQmx_Val_Switch_Topology_2593_16x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_2593_DUAL_8X1_MUX") DAQmx_Val_Switch_Topology_2593_Dual_8x1_Mux;
%rename("VAL_SWITCH_TOPOLOGY_2593_8X1_TERMINATED_MUX") DAQmx_Val_Switch_Topology_2593_8x1_Terminated_Mux;
%rename("VAL_SWITCH_TOPOLOGY_2593_DUAL_4X1_TERMINATED_MUX") DAQmx_Val_Switch_Topology_2593_Dual_4x1_Terminated_Mux;
%rename("VAL_SWITCH_TOPOLOGY_2593_INDEPENDENT") DAQmx_Val_Switch_Topology_2593_Independent;
// DAQmxBaseResetDevice(const char deviceName[])
%ignore DAQmxBaseResetDevice;
    %inline {
      int32 reset_device(const char deviceName[]) {
        int32 result = DAQmxBaseResetDevice(deviceName);
        if (result) handle_DAQmx_error("reset_device", result);
        return result;
      }
    };
// DAQmxBaseGetExtendedErrorInfo(char errorString[], uInt32 bufferSize)
%ignore DAQmxBaseGetExtendedErrorInfo;
    %inline {
      int32 get_extended_error_info(char errorString[], uInt32 bufferSize) {
        int32 result = DAQmxBaseGetExtendedErrorInfo(errorString, bufferSize);
        if (result) handle_DAQmx_error("get_extended_error_info", result);
        return result;
      }
    };
// DAQmxBaseGetDevSerialNum(const char device[], uInt32 *data)
%ignore DAQmxBaseGetDevSerialNum;
    %inline {
      int32 get_dev_serial_num(const char device[], uInt32 *data) {
        int32 result = DAQmxBaseGetDevSerialNum(device, data);
        if (result) handle_DAQmx_error("get_dev_serial_num", result);
        return result;
      }
    };
%rename("SUCCESS") DAQmxSuccess;
%rename("ERROR_INVALID_INSTALLATION") DAQmxErrorInvalidInstallation;
%rename("ERROR_REF_TRIG_MASTER_SESSION_UNAVAILABLE") DAQmxErrorRefTrigMasterSessionUnavailable;
%rename("ERROR_ROUTE_FAILED_BECAUSE_WATCHDOG_EXPIRED") DAQmxErrorRouteFailedBecauseWatchdogExpired;
%rename("ERROR_DEVICE_SHUT_DOWN_DUE_TO_HIGH_TEMP") DAQmxErrorDeviceShutDownDueToHighTemp;
%rename("ERROR_NO_MEM_MAP_WHEN_HWTIMED_SINGLE_POINT") DAQmxErrorNoMemMapWhenHWTimedSinglePoint;
%rename("ERROR_WRITE_FAILED_BECAUSE_WATCHDOG_EXPIRED") DAQmxErrorWriteFailedBecauseWatchdogExpired;
%rename("ERROR_DIFFT_INTERNAL_AIINPUT_SRCS") DAQmxErrorDifftInternalAIInputSrcs;
%rename("ERROR_DIFFT_AIINPUT_SRC_IN_ONE_CHAN_GROUP") DAQmxErrorDifftAIInputSrcInOneChanGroup;
%rename("ERROR_INTERNAL_AIINPUT_SRC_IN_MULT_CHAN_GROUPS") DAQmxErrorInternalAIInputSrcInMultChanGroups;
%rename("ERROR_SWITCH_OP_FAILED_DUE_TO_PREV_ERROR") DAQmxErrorSwitchOpFailedDueToPrevError;
%rename("ERROR_WROTE_MULTI_SAMPS_USING_SINGLE_SAMP_WRITE") DAQmxErrorWroteMultiSampsUsingSingleSampWrite;
%rename("ERROR_MISMATCHED_INPUT_ARRAY_SIZES") DAQmxErrorMismatchedInputArraySizes;
%rename("ERROR_CANT_EXCEED_RELAY_DRIVE_LIMIT") DAQmxErrorCantExceedRelayDriveLimit;
%rename("ERROR_DACRNG_LOW_NOT_EQUAL_TO_MINUS_REF_VAL") DAQmxErrorDACRngLowNotEqualToMinusRefVal;
%rename("ERROR_CANT_ALLOW_CONNECT_DACTO_GND") DAQmxErrorCantAllowConnectDACToGnd;
%rename("ERROR_WATCHDOG_TIMEOUT_OUT_OF_RANGE_AND_NOT_SPECIAL_VAL") DAQmxErrorWatchdogTimeoutOutOfRangeAndNotSpecialVal;
%rename("ERROR_NO_WATCHDOG_OUTPUT_ON_PORT_RESERVED_FOR_INPUT") DAQmxErrorNoWatchdogOutputOnPortReservedForInput;
%rename("ERROR_NO_INPUT_ON_PORT_CFGD_FOR_WATCHDOG_OUTPUT") DAQmxErrorNoInputOnPortCfgdForWatchdogOutput;
%rename("ERROR_WATCHDOG_EXPIRATION_STATE_NOT_EQUAL_FOR_LINES_IN_PORT") DAQmxErrorWatchdogExpirationStateNotEqualForLinesInPort;
%rename("ERROR_CANNOT_PERFORM_OP_WHEN_TASK_NOT_RESERVED") DAQmxErrorCannotPerformOpWhenTaskNotReserved;
%rename("ERROR_POWERUP_STATE_NOT_SUPPORTED") DAQmxErrorPowerupStateNotSupported;
%rename("ERROR_WATCHDOG_TIMER_NOT_SUPPORTED") DAQmxErrorWatchdogTimerNotSupported;
%rename("ERROR_OP_NOT_SUPPORTED_WHEN_REF_CLK_SRC_NONE") DAQmxErrorOpNotSupportedWhenRefClkSrcNone;
%rename("ERROR_SAMP_CLK_RATE_UNAVAILABLE") DAQmxErrorSampClkRateUnavailable;
%rename("ERROR_PRPTY_GET_SPECD_SINGLE_ACTIVE_CHAN_FAILED_DUE_TO_DIFFT_VALS") DAQmxErrorPrptyGetSpecdSingleActiveChanFailedDueToDifftVals;
%rename("ERROR_PRPTY_GET_IMPLIED_ACTIVE_CHAN_FAILED_DUE_TO_DIFFT_VALS") DAQmxErrorPrptyGetImpliedActiveChanFailedDueToDifftVals;
%rename("ERROR_PRPTY_GET_SPECD_ACTIVE_CHAN_FAILED_DUE_TO_DIFFT_VALS") DAQmxErrorPrptyGetSpecdActiveChanFailedDueToDifftVals;
%rename("ERROR_NO_REGEN_WHEN_USING_BRD_MEM") DAQmxErrorNoRegenWhenUsingBrdMem;
%rename("ERROR_NONBUFFERED_READ_MORE_THAN_SAMPS_PER_CHAN") DAQmxErrorNonbufferedReadMoreThanSampsPerChan;
%rename("ERROR_WATCHDOG_EXPIRATION_TRISTATE_NOT_SPECD_FOR_ENTIRE_PORT") DAQmxErrorWatchdogExpirationTristateNotSpecdForEntirePort;
%rename("ERROR_POWERUP_TRISTATE_NOT_SPECD_FOR_ENTIRE_PORT") DAQmxErrorPowerupTristateNotSpecdForEntirePort;
%rename("ERROR_POWERUP_STATE_NOT_SPECD_FOR_ENTIRE_PORT") DAQmxErrorPowerupStateNotSpecdForEntirePort;
%rename("ERROR_CANT_SET_WATCHDOG_EXPIRATION_ON_DIG_IN_CHAN") DAQmxErrorCantSetWatchdogExpirationOnDigInChan;
%rename("ERROR_CANT_SET_POWERUP_STATE_ON_DIG_IN_CHAN") DAQmxErrorCantSetPowerupStateOnDigInChan;
%rename("ERROR_PHYS_CHAN_NOT_IN_TASK") DAQmxErrorPhysChanNotInTask;
%rename("ERROR_PHYS_CHAN_DEV_NOT_IN_TASK") DAQmxErrorPhysChanDevNotInTask;
%rename("ERROR_DIG_INPUT_NOT_SUPPORTED") DAQmxErrorDigInputNotSupported;
%rename("ERROR_DIG_FILTER_INTERVAL_NOT_EQUAL_FOR_LINES") DAQmxErrorDigFilterIntervalNotEqualForLines;
%rename("ERROR_DIG_FILTER_INTERVAL_ALREADY_CFGD") DAQmxErrorDigFilterIntervalAlreadyCfgd;
%rename("ERROR_CANT_RESET_EXPIRED_WATCHDOG") DAQmxErrorCantResetExpiredWatchdog;
%rename("ERROR_ACTIVE_CHAN_TOO_MANY_LINES_SPECD_WHEN_GETTING_PRPTY") DAQmxErrorActiveChanTooManyLinesSpecdWhenGettingPrpty;
%rename("ERROR_ACTIVE_CHAN_NOT_SPECD_WHEN_GETTING1LINE_PRPTY") DAQmxErrorActiveChanNotSpecdWhenGetting1LinePrpty;
%rename("ERROR_DIG_PRPTY_CANNOT_BE_SET_PER_LINE") DAQmxErrorDigPrptyCannotBeSetPerLine;
%rename("ERROR_SEND_ADV_CMPLT_AFTER_WAIT_FOR_TRIG_IN_SCANLIST") DAQmxErrorSendAdvCmpltAfterWaitForTrigInScanlist;
%rename("ERROR_DISCONNECTION_REQUIRED_IN_SCANLIST") DAQmxErrorDisconnectionRequiredInScanlist;
%rename("ERROR_TWO_WAIT_FOR_TRIGS_AFTER_CONNECTION_IN_SCANLIST") DAQmxErrorTwoWaitForTrigsAfterConnectionInScanlist;
%rename("ERROR_ACTION_SEPARATOR_REQUIRED_AFTER_BREAKING_CONNECTION_IN_SCANLIST") DAQmxErrorActionSeparatorRequiredAfterBreakingConnectionInScanlist;
%rename("ERROR_CONNECTION_IN_SCANLIST_MUST_WAIT_FOR_TRIG") DAQmxErrorConnectionInScanlistMustWaitForTrig;
%rename("ERROR_ACTION_NOT_SUPPORTED_TASK_NOT_WATCHDOG") DAQmxErrorActionNotSupportedTaskNotWatchdog;
%rename("ERROR_WFM_NAME_SAME_AS_SCRIPT_NAME") DAQmxErrorWfmNameSameAsScriptName;
%rename("ERROR_SCRIPT_NAME_SAME_AS_WFM_NAME") DAQmxErrorScriptNameSameAsWfmName;
%rename("ERROR_DSFSTOP_CLOCK") DAQmxErrorDSFStopClock;
%rename("ERROR_DSFREADY_FOR_START_CLOCK") DAQmxErrorDSFReadyForStartClock;
%rename("ERROR_WRITE_OFFSET_NOT_MULT_OF_INCR") DAQmxErrorWriteOffsetNotMultOfIncr;
%rename("ERROR_DIFFERENT_PRPTY_VALS_NOT_SUPPORTED_ON_DEV") DAQmxErrorDifferentPrptyValsNotSupportedOnDev;
%rename("ERROR_REF_AND_PAUSE_TRIG_CONFIGURED") DAQmxErrorRefAndPauseTrigConfigured;
%rename("ERROR_FAILED_TO_ENABLE_HIGH_SPEED_INPUT_CLOCK") DAQmxErrorFailedToEnableHighSpeedInputClock;
%rename("ERROR_EMPTY_PHYS_CHAN_IN_POWER_UP_STATES_ARRAY") DAQmxErrorEmptyPhysChanInPowerUpStatesArray;
%rename("ERROR_ACTIVE_PHYS_CHAN_TOO_MANY_LINES_SPECD_WHEN_GETTING_PRPTY") DAQmxErrorActivePhysChanTooManyLinesSpecdWhenGettingPrpty;
%rename("ERROR_ACTIVE_PHYS_CHAN_NOT_SPECD_WHEN_GETTING1LINE_PRPTY") DAQmxErrorActivePhysChanNotSpecdWhenGetting1LinePrpty;
%rename("ERROR_PXIDEV_TEMP_CAUSED_SHUT_DOWN") DAQmxErrorPXIDevTempCausedShutDown;
%rename("ERROR_INVALID_NUM_SAMPS_TO_WRITE") DAQmxErrorInvalidNumSampsToWrite;
%rename("ERROR_OUTPUT_FIFOUNDERFLOW2") DAQmxErrorOutputFIFOUnderflow2;
%rename("ERROR_REPEATED_AIPHYSICAL_CHAN") DAQmxErrorRepeatedAIPhysicalChan;
%rename("ERROR_MULT_SCAN_OPS_IN_ONE_CHASSIS") DAQmxErrorMultScanOpsInOneChassis;
%rename("ERROR_INVALID_AICHAN_ORDER") DAQmxErrorInvalidAIChanOrder;
%rename("ERROR_REVERSE_POWER_PROTECTION_ACTIVATED") DAQmxErrorReversePowerProtectionActivated;
%rename("ERROR_INVALID_ASYN_OP_HANDLE") DAQmxErrorInvalidAsynOpHandle;
%rename("ERROR_FAILED_TO_ENABLE_HIGH_SPEED_OUTPUT") DAQmxErrorFailedToEnableHighSpeedOutput;
%rename("ERROR_CANNOT_READ_PAST_END_OF_RECORD") DAQmxErrorCannotReadPastEndOfRecord;
%rename("ERROR_ACQ_STOPPED_TO_PREVENT_INPUT_BUFFER_OVERWRITE_ONE_DATA_XFER_MECH") DAQmxErrorAcqStoppedToPreventInputBufferOverwriteOneDataXferMech;
%rename("ERROR_ZERO_BASED_CHAN_INDEX_INVALID") DAQmxErrorZeroBasedChanIndexInvalid;
%rename("ERROR_NO_CHANS_OF_GIVEN_TYPE_IN_TASK") DAQmxErrorNoChansOfGivenTypeInTask;
%rename("ERROR_SAMP_CLK_SRC_INVALID_FOR_OUTPUT_VALID_FOR_INPUT") DAQmxErrorSampClkSrcInvalidForOutputValidForInput;
%rename("ERROR_OUTPUT_BUF_SIZE_TOO_SMALL_TO_START_GEN") DAQmxErrorOutputBufSizeTooSmallToStartGen;
%rename("ERROR_INPUT_BUF_SIZE_TOO_SMALL_TO_START_ACQ") DAQmxErrorInputBufSizeTooSmallToStartAcq;
%rename("ERROR_EXPORT_TWO_SIGNALS_ON_SAME_TERMINAL") DAQmxErrorExportTwoSignalsOnSameTerminal;
%rename("ERROR_CHAN_INDEX_INVALID") DAQmxErrorChanIndexInvalid;
%rename("ERROR_RANGE_SYNTAX_NUMBER_TOO_BIG") DAQmxErrorRangeSyntaxNumberTooBig;
%rename("ERROR_NULLPTR") DAQmxErrorNULLPtr;
%rename("ERROR_SCALED_MIN_EQUAL_MAX") DAQmxErrorScaledMinEqualMax;
%rename("ERROR_PRE_SCALED_MIN_EQUAL_MAX") DAQmxErrorPreScaledMinEqualMax;
%rename("ERROR_PROPERTY_NOT_SUPPORTED_FOR_SCALE_TYPE") DAQmxErrorPropertyNotSupportedForScaleType;
%rename("ERROR_CHANNEL_NAME_GENERATION_NUMBER_TOO_BIG") DAQmxErrorChannelNameGenerationNumberTooBig;
%rename("ERROR_REPEATED_NUMBER_IN_SCALED_VALUES") DAQmxErrorRepeatedNumberInScaledValues;
%rename("ERROR_REPEATED_NUMBER_IN_PRE_SCALED_VALUES") DAQmxErrorRepeatedNumberInPreScaledValues;
%rename("ERROR_LINES_ALREADY_RESERVED_FOR_OUTPUT") DAQmxErrorLinesAlreadyReservedForOutput;
%rename("ERROR_SWITCH_OPERATION_CHANS_SPAN_MULTIPLE_DEVS_IN_LIST") DAQmxErrorSwitchOperationChansSpanMultipleDevsInList;
%rename("ERROR_INVALID_IDIN_LIST_AT_BEGINNING_OF_SWITCH_OPERATION") DAQmxErrorInvalidIDInListAtBeginningOfSwitchOperation;
%rename("ERROR_MSTUDIO_INVALID_POLY_DIRECTION") DAQmxErrorMStudioInvalidPolyDirection;
%rename("ERROR_MSTUDIO_PROPERTY_GET_WHILE_TASK_NOT_VERIFIED") DAQmxErrorMStudioPropertyGetWhileTaskNotVerified;
%rename("ERROR_RANGE_WITH_TOO_MANY_OBJECTS") DAQmxErrorRangeWithTooManyObjects;
%rename("ERROR_CPP_DOT_NET_APINEGATIVE_BUFFER_SIZE") DAQmxErrorCppDotNetAPINegativeBufferSize;
%rename("ERROR_CPP_CANT_REMOVE_INVALID_EVENT_HANDLER") DAQmxErrorCppCantRemoveInvalidEventHandler;
%rename("ERROR_CPP_CANT_REMOVE_EVENT_HANDLER_TWICE") DAQmxErrorCppCantRemoveEventHandlerTwice;
%rename("ERROR_CPP_CANT_REMOVE_OTHER_OBJECTS_EVENT_HANDLER") DAQmxErrorCppCantRemoveOtherObjectsEventHandler;
%rename("ERROR_DIG_LINES_RESERVED_OR_UNAVAILABLE") DAQmxErrorDigLinesReservedOrUnavailable;
%rename("ERROR_DSFFAILED_TO_RESET_STREAM") DAQmxErrorDSFFailedToResetStream;
%rename("ERROR_DSFREADY_FOR_OUTPUT_NOT_ASSERTED") DAQmxErrorDSFReadyForOutputNotAsserted;
%rename("ERROR_SAMP_TO_WRITE_PER_CHAN_NOT_MULTIPLE_OF_INCR") DAQmxErrorSampToWritePerChanNotMultipleOfIncr;
%rename("ERROR_AOPROPERTIES_CAUSE_VOLTAGE_BELOW_MIN") DAQmxErrorAOPropertiesCauseVoltageBelowMin;
%rename("ERROR_AOPROPERTIES_CAUSE_VOLTAGE_OVER_MAX") DAQmxErrorAOPropertiesCauseVoltageOverMax;
%rename("ERROR_PROPERTY_NOT_SUPPORTED_WHEN_REF_CLK_SRC_NONE") DAQmxErrorPropertyNotSupportedWhenRefClkSrcNone;
%rename("ERROR_AIMAX_TOO_SMALL") DAQmxErrorAIMaxTooSmall;
%rename("ERROR_AIMAX_TOO_LARGE") DAQmxErrorAIMaxTooLarge;
%rename("ERROR_AIMIN_TOO_SMALL") DAQmxErrorAIMinTooSmall;
%rename("ERROR_AIMIN_TOO_LARGE") DAQmxErrorAIMinTooLarge;
%rename("ERROR_BUILT_IN_CJCSRC_NOT_SUPPORTED") DAQmxErrorBuiltInCJCSrcNotSupported;
%rename("ERROR_TOO_MANY_POST_TRIG_SAMPS_PER_CHAN") DAQmxErrorTooManyPostTrigSampsPerChan;
%rename("ERROR_TRIG_LINE_NOT_FOUND_SINGLE_DEV_ROUTE") DAQmxErrorTrigLineNotFoundSingleDevRoute;
%rename("ERROR_DIFFERENT_INTERNAL_AIINPUT_SOURCES") DAQmxErrorDifferentInternalAIInputSources;
%rename("ERROR_DIFFERENT_AIINPUT_SRC_IN_ONE_CHAN_GROUP") DAQmxErrorDifferentAIInputSrcInOneChanGroup;
%rename("ERROR_INTERNAL_AIINPUT_SRC_IN_MULTIPLE_CHAN_GROUPS") DAQmxErrorInternalAIInputSrcInMultipleChanGroups;
%rename("ERROR_CAPICHAN_INDEX_INVALID") DAQmxErrorCAPIChanIndexInvalid;
%rename("ERROR_COLLECTION_DOES_NOT_MATCH_CHAN_TYPE") DAQmxErrorCollectionDoesNotMatchChanType;
%rename("ERROR_OUTPUT_CANT_START_CHANGED_REGENERATION_MODE") DAQmxErrorOutputCantStartChangedRegenerationMode;
%rename("ERROR_OUTPUT_CANT_START_CHANGED_BUFFER_SIZE") DAQmxErrorOutputCantStartChangedBufferSize;
%rename("ERROR_CHAN_SIZE_TOO_BIG_FOR_U32PORT_WRITE") DAQmxErrorChanSizeTooBigForU32PortWrite;
%rename("ERROR_CHAN_SIZE_TOO_BIG_FOR_U8PORT_WRITE") DAQmxErrorChanSizeTooBigForU8PortWrite;
%rename("ERROR_CHAN_SIZE_TOO_BIG_FOR_U32PORT_READ") DAQmxErrorChanSizeTooBigForU32PortRead;
%rename("ERROR_CHAN_SIZE_TOO_BIG_FOR_U8PORT_READ") DAQmxErrorChanSizeTooBigForU8PortRead;
%rename("ERROR_INVALID_DIG_DATA_WRITE") DAQmxErrorInvalidDigDataWrite;
%rename("ERROR_INVALID_AODATA_WRITE") DAQmxErrorInvalidAODataWrite;
%rename("ERROR_WAIT_UNTIL_DONE_DOES_NOT_INDICATE_DONE") DAQmxErrorWaitUntilDoneDoesNotIndicateDone;
%rename("ERROR_MULTI_CHAN_TYPES_IN_TASK") DAQmxErrorMultiChanTypesInTask;
%rename("ERROR_MULTI_DEVS_IN_TASK") DAQmxErrorMultiDevsInTask;
%rename("ERROR_CANNOT_SET_PROPERTY_WHEN_TASK_RUNNING") DAQmxErrorCannotSetPropertyWhenTaskRunning;
%rename("ERROR_CANNOT_GET_PROPERTY_WHEN_TASK_NOT_COMMITTED_OR_RUNNING") DAQmxErrorCannotGetPropertyWhenTaskNotCommittedOrRunning;
%rename("ERROR_LEADING_UNDERSCORE_IN_STRING") DAQmxErrorLeadingUnderscoreInString;
%rename("ERROR_TRAILING_SPACE_IN_STRING") DAQmxErrorTrailingSpaceInString;
%rename("ERROR_LEADING_SPACE_IN_STRING") DAQmxErrorLeadingSpaceInString;
%rename("ERROR_INVALID_CHAR_IN_STRING") DAQmxErrorInvalidCharInString;
%rename("ERROR_DLLBECAME_UNLOCKED") DAQmxErrorDLLBecameUnlocked;
%rename("ERROR_DLLLOCK") DAQmxErrorDLLLock;
%rename("ERROR_SELF_CAL_CONSTS_INVALID") DAQmxErrorSelfCalConstsInvalid;
%rename("ERROR_INVALID_TRIG_COUPLING_EXCEPT_FOR_EXT_TRIG_CHAN") DAQmxErrorInvalidTrigCouplingExceptForExtTrigChan;
%rename("ERROR_WRITE_FAILS_BUFFER_SIZE_AUTO_CONFIGURED") DAQmxErrorWriteFailsBufferSizeAutoConfigured;
%rename("ERROR_EXT_CAL_ADJUST_EXT_REF_VOLTAGE_FAILED") DAQmxErrorExtCalAdjustExtRefVoltageFailed;
%rename("ERROR_SELF_CAL_FAILED_EXT_NOISE_OR_REF_VOLTAGE_OUT_OF_CAL") DAQmxErrorSelfCalFailedExtNoiseOrRefVoltageOutOfCal;
%rename("ERROR_EXT_CAL_TEMPERATURE_NOT_DAQMX") DAQmxErrorExtCalTemperatureNotDAQmx;
%rename("ERROR_EXT_CAL_DATE_TIME_NOT_DAQMX") DAQmxErrorExtCalDateTimeNotDAQmx;
%rename("ERROR_SELF_CAL_TEMPERATURE_NOT_DAQMX") DAQmxErrorSelfCalTemperatureNotDAQmx;
%rename("ERROR_SELF_CAL_DATE_TIME_NOT_DAQMX") DAQmxErrorSelfCalDateTimeNotDAQmx;
%rename("ERROR_DACREF_VAL_NOT_SET") DAQmxErrorDACRefValNotSet;
%rename("ERROR_ANALOG_MULTI_SAMP_WRITE_NOT_SUPPORTED") DAQmxErrorAnalogMultiSampWriteNotSupported;
%rename("ERROR_INVALID_ACTION_IN_CONTROL_TASK") DAQmxErrorInvalidActionInControlTask;
%rename("ERROR_POLY_COEFFS_INCONSISTENT") DAQmxErrorPolyCoeffsInconsistent;
%rename("ERROR_SENSOR_VAL_TOO_LOW") DAQmxErrorSensorValTooLow;
%rename("ERROR_SENSOR_VAL_TOO_HIGH") DAQmxErrorSensorValTooHigh;
%rename("ERROR_WAVEFORM_NAME_TOO_LONG") DAQmxErrorWaveformNameTooLong;
%rename("ERROR_IDENTIFIER_TOO_LONG_IN_SCRIPT") DAQmxErrorIdentifierTooLongInScript;
%rename("ERROR_UNEXPECTED_IDFOLLOWING_SWITCH_CHAN_NAME") DAQmxErrorUnexpectedIDFollowingSwitchChanName;
%rename("ERROR_RELAY_NAME_NOT_SPECIFIED_IN_LIST") DAQmxErrorRelayNameNotSpecifiedInList;
%rename("ERROR_UNEXPECTED_IDFOLLOWING_RELAY_NAME_IN_LIST") DAQmxErrorUnexpectedIDFollowingRelayNameInList;
%rename("ERROR_UNEXPECTED_IDFOLLOWING_SWITCH_OP_IN_LIST") DAQmxErrorUnexpectedIDFollowingSwitchOpInList;
%rename("ERROR_INVALID_LINE_GROUPING") DAQmxErrorInvalidLineGrouping;
%rename("ERROR_CTR_MIN_MAX") DAQmxErrorCtrMinMax;
%rename("ERROR_WRITE_CHAN_TYPE_MISMATCH") DAQmxErrorWriteChanTypeMismatch;
%rename("ERROR_READ_CHAN_TYPE_MISMATCH") DAQmxErrorReadChanTypeMismatch;
%rename("ERROR_WRITE_NUM_CHANS_MISMATCH") DAQmxErrorWriteNumChansMismatch;
%rename("ERROR_ONE_CHAN_READ_FOR_MULTI_CHAN_TASK") DAQmxErrorOneChanReadForMultiChanTask;
%rename("ERROR_CANNOT_SELF_CAL_DURING_EXT_CAL") DAQmxErrorCannotSelfCalDuringExtCal;
%rename("ERROR_MEAS_CAL_ADJUST_OSCILLATOR_PHASE_DAC") DAQmxErrorMeasCalAdjustOscillatorPhaseDAC;
%rename("ERROR_INVALID_CAL_CONST_CAL_ADCADJUSTMENT") DAQmxErrorInvalidCalConstCalADCAdjustment;
%rename("ERROR_INVALID_CAL_CONST_OSCILLATOR_FREQ_DACVALUE") DAQmxErrorInvalidCalConstOscillatorFreqDACValue;
%rename("ERROR_INVALID_CAL_CONST_OSCILLATOR_PHASE_DACVALUE") DAQmxErrorInvalidCalConstOscillatorPhaseDACValue;
%rename("ERROR_INVALID_CAL_CONST_OFFSET_DACVALUE") DAQmxErrorInvalidCalConstOffsetDACValue;
%rename("ERROR_INVALID_CAL_CONST_GAIN_DACVALUE") DAQmxErrorInvalidCalConstGainDACValue;
%rename("ERROR_INVALID_NUM_CAL_ADCREADS_TO_AVERAGE") DAQmxErrorInvalidNumCalADCReadsToAverage;
%rename("ERROR_INVALID_CFG_CAL_ADJUST_DIRECT_PATH_OUTPUT_IMPEDANCE") DAQmxErrorInvalidCfgCalAdjustDirectPathOutputImpedance;
%rename("ERROR_INVALID_CFG_CAL_ADJUST_MAIN_PATH_OUTPUT_IMPEDANCE") DAQmxErrorInvalidCfgCalAdjustMainPathOutputImpedance;
%rename("ERROR_INVALID_CFG_CAL_ADJUST_MAIN_PATH_POST_AMP_GAIN_AND_OFFSET") DAQmxErrorInvalidCfgCalAdjustMainPathPostAmpGainAndOffset;
%rename("ERROR_INVALID_CFG_CAL_ADJUST_MAIN_PATH_PRE_AMP_GAIN") DAQmxErrorInvalidCfgCalAdjustMainPathPreAmpGain;
%rename("ERROR_INVALID_CFG_CAL_ADJUST_MAIN_PRE_AMP_OFFSET") DAQmxErrorInvalidCfgCalAdjustMainPreAmpOffset;
%rename("ERROR_MEAS_CAL_ADJUST_CAL_ADC") DAQmxErrorMeasCalAdjustCalADC;
%rename("ERROR_MEAS_CAL_ADJUST_OSCILLATOR_FREQUENCY") DAQmxErrorMeasCalAdjustOscillatorFrequency;
%rename("ERROR_MEAS_CAL_ADJUST_DIRECT_PATH_OUTPUT_IMPEDANCE") DAQmxErrorMeasCalAdjustDirectPathOutputImpedance;
%rename("ERROR_MEAS_CAL_ADJUST_MAIN_PATH_OUTPUT_IMPEDANCE") DAQmxErrorMeasCalAdjustMainPathOutputImpedance;
%rename("ERROR_MEAS_CAL_ADJUST_DIRECT_PATH_GAIN") DAQmxErrorMeasCalAdjustDirectPathGain;
%rename("ERROR_MEAS_CAL_ADJUST_MAIN_PATH_POST_AMP_GAIN_AND_OFFSET") DAQmxErrorMeasCalAdjustMainPathPostAmpGainAndOffset;
%rename("ERROR_MEAS_CAL_ADJUST_MAIN_PATH_PRE_AMP_GAIN") DAQmxErrorMeasCalAdjustMainPathPreAmpGain;
%rename("ERROR_MEAS_CAL_ADJUST_MAIN_PATH_PRE_AMP_OFFSET") DAQmxErrorMeasCalAdjustMainPathPreAmpOffset;
%rename("ERROR_INVALID_DATE_TIME_IN_EEPROM") DAQmxErrorInvalidDateTimeInEEPROM;
%rename("ERROR_UNABLE_TO_LOCATE_ERROR_RESOURCES") DAQmxErrorUnableToLocateErrorResources;
%rename("ERROR_DOT_NET_APINOT_UNSIGNED32BIT_NUMBER") DAQmxErrorDotNetAPINotUnsigned32BitNumber;
%rename("ERROR_INVALID_RANGE_OF_OBJECTS_SYNTAX_IN_STRING") DAQmxErrorInvalidRangeOfObjectsSyntaxInString;
%rename("ERROR_ATTEMPT_TO_ENABLE_LINE_NOT_PREVIOUSLY_DISABLED") DAQmxErrorAttemptToEnableLineNotPreviouslyDisabled;
%rename("ERROR_INVALID_CHAR_IN_PATTERN") DAQmxErrorInvalidCharInPattern;
%rename("ERROR_INTERMEDIATE_BUFFER_FULL") DAQmxErrorIntermediateBufferFull;
%rename("ERROR_LOAD_TASK_FAILS_BECAUSE_NO_TIMING_ON_DEV") DAQmxErrorLoadTaskFailsBecauseNoTimingOnDev;
%rename("ERROR_CAPIRESERVED_PARAM_NOT_NULLNOR_EMPTY") DAQmxErrorCAPIReservedParamNotNULLNorEmpty;
%rename("ERROR_CAPIRESERVED_PARAM_NOT_NULL") DAQmxErrorCAPIReservedParamNotNULL;
%rename("ERROR_CAPIRESERVED_PARAM_NOT_ZERO") DAQmxErrorCAPIReservedParamNotZero;
%rename("ERROR_SAMPLE_VALUE_OUT_OF_RANGE") DAQmxErrorSampleValueOutOfRange;
%rename("ERROR_CHAN_ALREADY_IN_TASK") DAQmxErrorChanAlreadyInTask;
%rename("ERROR_VIRTUAL_CHAN_DOES_NOT_EXIST") DAQmxErrorVirtualChanDoesNotExist;
%rename("ERROR_CHAN_NOT_IN_TASK") DAQmxErrorChanNotInTask;
%rename("ERROR_TASK_NOT_IN_DATA_NEIGHBORHOOD") DAQmxErrorTaskNotInDataNeighborhood;
%rename("ERROR_CANT_SAVE_TASK_WITHOUT_REPLACE") DAQmxErrorCantSaveTaskWithoutReplace;
%rename("ERROR_CANT_SAVE_CHAN_WITHOUT_REPLACE") DAQmxErrorCantSaveChanWithoutReplace;
%rename("ERROR_DEV_NOT_IN_TASK") DAQmxErrorDevNotInTask;
%rename("ERROR_DEV_ALREADY_IN_TASK") DAQmxErrorDevAlreadyInTask;
%rename("ERROR_CAN_NOT_PERFORM_OP_WHILE_TASK_RUNNING") DAQmxErrorCanNotPerformOpWhileTaskRunning;
%rename("ERROR_CAN_NOT_PERFORM_OP_WHEN_NO_CHANS_IN_TASK") DAQmxErrorCanNotPerformOpWhenNoChansInTask;
%rename("ERROR_CAN_NOT_PERFORM_OP_WHEN_NO_DEV_IN_TASK") DAQmxErrorCanNotPerformOpWhenNoDevInTask;
%rename("ERROR_CANNOT_PERFORM_OP_WHEN_TASK_NOT_RUNNING") DAQmxErrorCannotPerformOpWhenTaskNotRunning;
%rename("ERROR_OPERATION_TIMED_OUT") DAQmxErrorOperationTimedOut;
%rename("ERROR_CANNOT_READ_WHEN_AUTO_START_FALSE_AND_TASK_NOT_RUNNING_OR_COMMITTED") DAQmxErrorCannotReadWhenAutoStartFalseAndTaskNotRunningOrCommitted;
%rename("ERROR_CANNOT_WRITE_WHEN_AUTO_START_FALSE_AND_TASK_NOT_RUNNING_OR_COMMITTED") DAQmxErrorCannotWriteWhenAutoStartFalseAndTaskNotRunningOrCommitted;
%rename("ERROR_TASK_VERSION_NEW") DAQmxErrorTaskVersionNew;
%rename("ERROR_CHAN_VERSION_NEW") DAQmxErrorChanVersionNew;
%rename("ERROR_EMPTY_STRING") DAQmxErrorEmptyString;
%rename("ERROR_CHANNEL_SIZE_TOO_BIG_FOR_PORT_READ_TYPE") DAQmxErrorChannelSizeTooBigForPortReadType;
%rename("ERROR_CHANNEL_SIZE_TOO_BIG_FOR_PORT_WRITE_TYPE") DAQmxErrorChannelSizeTooBigForPortWriteType;
%rename("ERROR_EXPECTED_NUMBER_OF_CHANNELS_VERIFICATION_FAILED") DAQmxErrorExpectedNumberOfChannelsVerificationFailed;
%rename("ERROR_NUM_LINES_MISMATCH_IN_READ_OR_WRITE") DAQmxErrorNumLinesMismatchInReadOrWrite;
%rename("ERROR_OUTPUT_BUFFER_EMPTY") DAQmxErrorOutputBufferEmpty;
%rename("ERROR_INVALID_CHAN_NAME") DAQmxErrorInvalidChanName;
%rename("ERROR_READ_NO_INPUT_CHANS_IN_TASK") DAQmxErrorReadNoInputChansInTask;
%rename("ERROR_WRITE_NO_OUTPUT_CHANS_IN_TASK") DAQmxErrorWriteNoOutputChansInTask;
%rename("ERROR_PROPERTY_NOT_SUPPORTED_NOT_INPUT_TASK") DAQmxErrorPropertyNotSupportedNotInputTask;
%rename("ERROR_PROPERTY_NOT_SUPPORTED_NOT_OUTPUT_TASK") DAQmxErrorPropertyNotSupportedNotOutputTask;
%rename("ERROR_GET_PROPERTY_NOT_INPUT_BUFFERED_TASK") DAQmxErrorGetPropertyNotInputBufferedTask;
%rename("ERROR_GET_PROPERTY_NOT_OUTPUT_BUFFERED_TASK") DAQmxErrorGetPropertyNotOutputBufferedTask;
%rename("ERROR_INVALID_TIMEOUT_VAL") DAQmxErrorInvalidTimeoutVal;
%rename("ERROR_ATTRIBUTE_NOT_SUPPORTED_IN_TASK_CONTEXT") DAQmxErrorAttributeNotSupportedInTaskContext;
%rename("ERROR_ATTRIBUTE_NOT_QUERYABLE_UNLESS_TASK_IS_COMMITTED") DAQmxErrorAttributeNotQueryableUnlessTaskIsCommitted;
%rename("ERROR_ATTRIBUTE_NOT_SETTABLE_WHEN_TASK_IS_RUNNING") DAQmxErrorAttributeNotSettableWhenTaskIsRunning;
%rename("ERROR_DACRNG_LOW_NOT_MINUS_REF_VAL_NOR_ZERO") DAQmxErrorDACRngLowNotMinusRefValNorZero;
%rename("ERROR_DACRNG_HIGH_NOT_EQUAL_REF_VAL") DAQmxErrorDACRngHighNotEqualRefVal;
%rename("ERROR_UNITS_NOT_FROM_CUSTOM_SCALE") DAQmxErrorUnitsNotFromCustomScale;
%rename("ERROR_INVALID_VOLTAGE_READING_DURING_EXT_CAL") DAQmxErrorInvalidVoltageReadingDuringExtCal;
%rename("ERROR_CAL_FUNCTION_NOT_SUPPORTED") DAQmxErrorCalFunctionNotSupported;
%rename("ERROR_INVALID_PHYSICAL_CHAN_FOR_CAL") DAQmxErrorInvalidPhysicalChanForCal;
%rename("ERROR_EXT_CAL_NOT_COMPLETE") DAQmxErrorExtCalNotComplete;
%rename("ERROR_CANT_SYNC_TO_EXT_STIMULUS_FREQ_DURING_CAL") DAQmxErrorCantSyncToExtStimulusFreqDuringCal;
%rename("ERROR_UNABLE_TO_DETECT_EXT_STIMULUS_FREQ_DURING_CAL") DAQmxErrorUnableToDetectExtStimulusFreqDuringCal;
%rename("ERROR_INVALID_CLOSE_ACTION") DAQmxErrorInvalidCloseAction;
%rename("ERROR_EXT_CAL_FUNCTION_OUTSIDE_EXT_CAL_SESSION") DAQmxErrorExtCalFunctionOutsideExtCalSession;
%rename("ERROR_INVALID_CAL_AREA") DAQmxErrorInvalidCalArea;
%rename("ERROR_EXT_CAL_CONSTS_INVALID") DAQmxErrorExtCalConstsInvalid;
%rename("ERROR_START_TRIG_DELAY_WITH_EXT_SAMP_CLK") DAQmxErrorStartTrigDelayWithExtSampClk;
%rename("ERROR_DELAY_FROM_SAMP_CLK_WITH_EXT_CONV") DAQmxErrorDelayFromSampClkWithExtConv;
%rename("ERROR_FEWER_THAN2PRE_SCALED_VALS") DAQmxErrorFewerThan2PreScaledVals;
%rename("ERROR_FEWER_THAN2SCALED_VALUES") DAQmxErrorFewerThan2ScaledValues;
%rename("ERROR_PHYS_CHAN_OUTPUT_TYPE") DAQmxErrorPhysChanOutputType;
%rename("ERROR_PHYS_CHAN_MEAS_TYPE") DAQmxErrorPhysChanMeasType;
%rename("ERROR_INVALID_PHYS_CHAN_TYPE") DAQmxErrorInvalidPhysChanType;
%rename("ERROR_LAB_VIEWEMPTY_TASK_OR_CHANS") DAQmxErrorLabVIEWEmptyTaskOrChans;
%rename("ERROR_LAB_VIEWINVALID_TASK_OR_CHANS") DAQmxErrorLabVIEWInvalidTaskOrChans;
%rename("ERROR_INVALID_REF_CLK_RATE") DAQmxErrorInvalidRefClkRate;
%rename("ERROR_INVALID_EXT_TRIG_IMPEDANCE") DAQmxErrorInvalidExtTrigImpedance;
%rename("ERROR_HYST_TRIG_LEVEL_AIMAX") DAQmxErrorHystTrigLevelAIMax;
%rename("ERROR_LINE_NUM_INCOMPATIBLE_WITH_VIDEO_SIGNAL_FORMAT") DAQmxErrorLineNumIncompatibleWithVideoSignalFormat;
%rename("ERROR_TRIG_WINDOW_AIMIN_AIMAX_COMBO") DAQmxErrorTrigWindowAIMinAIMaxCombo;
%rename("ERROR_TRIG_AIMIN_AIMAX") DAQmxErrorTrigAIMinAIMax;
%rename("ERROR_HYST_TRIG_LEVEL_AIMIN") DAQmxErrorHystTrigLevelAIMin;
%rename("ERROR_INVALID_SAMP_RATE_CONSIDER_RIS") DAQmxErrorInvalidSampRateConsiderRIS;
%rename("ERROR_INVALID_READ_POS_DURING_RIS") DAQmxErrorInvalidReadPosDuringRIS;
%rename("ERROR_IMMED_TRIG_DURING_RISMODE") DAQmxErrorImmedTrigDuringRISMode;
%rename("ERROR_TDCNOT_ENABLED_DURING_RISMODE") DAQmxErrorTDCNotEnabledDuringRISMode;
%rename("ERROR_MULTI_REC_WITH_RIS") DAQmxErrorMultiRecWithRIS;
%rename("ERROR_INVALID_REF_CLK_SRC") DAQmxErrorInvalidRefClkSrc;
%rename("ERROR_INVALID_SAMP_CLK_SRC") DAQmxErrorInvalidSampClkSrc;
%rename("ERROR_INSUFFICIENT_ON_BOARD_MEM_FOR_NUM_RECS_AND_SAMPS") DAQmxErrorInsufficientOnBoardMemForNumRecsAndSamps;
%rename("ERROR_INVALID_AIATTENUATION") DAQmxErrorInvalidAIAttenuation;
%rename("ERROR_ACCOUPLING_NOT_ALLOWED_WITH50OHM_IMPEDANCE") DAQmxErrorACCouplingNotAllowedWith50OhmImpedance;
%rename("ERROR_INVALID_RECORD_NUM") DAQmxErrorInvalidRecordNum;
%rename("ERROR_ZERO_SLOPE_LINEAR_SCALE") DAQmxErrorZeroSlopeLinearScale;
%rename("ERROR_ZERO_REVERSE_POLY_SCALE_COEFFS") DAQmxErrorZeroReversePolyScaleCoeffs;
%rename("ERROR_ZERO_FORWARD_POLY_SCALE_COEFFS") DAQmxErrorZeroForwardPolyScaleCoeffs;
%rename("ERROR_NO_REVERSE_POLY_SCALE_COEFFS") DAQmxErrorNoReversePolyScaleCoeffs;
%rename("ERROR_NO_FORWARD_POLY_SCALE_COEFFS") DAQmxErrorNoForwardPolyScaleCoeffs;
%rename("ERROR_NO_POLY_SCALE_COEFFS") DAQmxErrorNoPolyScaleCoeffs;
%rename("ERROR_REVERSE_POLY_ORDER_LESS_THAN_NUM_PTS_TO_COMPUTE") DAQmxErrorReversePolyOrderLessThanNumPtsToCompute;
%rename("ERROR_REVERSE_POLY_ORDER_NOT_POSITIVE") DAQmxErrorReversePolyOrderNotPositive;
%rename("ERROR_NUM_PTS_TO_COMPUTE_NOT_POSITIVE") DAQmxErrorNumPtsToComputeNotPositive;
%rename("ERROR_WAVEFORM_LENGTH_NOT_MULTIPLE_OF_INCR") DAQmxErrorWaveformLengthNotMultipleOfIncr;
%rename("ERROR_CAPINO_EXTENDED_ERROR_INFO_AVAILABLE") DAQmxErrorCAPINoExtendedErrorInfoAvailable;
%rename("ERROR_CVIFUNCTION_NOT_FOUND_IN_DAQMX_DLL") DAQmxErrorCVIFunctionNotFoundInDAQmxDLL;
%rename("ERROR_CVIFAILED_TO_LOAD_DAQMX_DLL") DAQmxErrorCVIFailedToLoadDAQmxDLL;
%rename("ERROR_NO_COMMON_TRIG_LINE_FOR_IMMED_ROUTE") DAQmxErrorNoCommonTrigLineForImmedRoute;
%rename("ERROR_NO_COMMON_TRIG_LINE_FOR_TASK_ROUTE") DAQmxErrorNoCommonTrigLineForTaskRoute;
%rename("ERROR_F64PRPTY_VAL_NOT_UNSIGNED_INT") DAQmxErrorF64PrptyValNotUnsignedInt;
%rename("ERROR_REGISTER_NOT_WRITABLE") DAQmxErrorRegisterNotWritable;
%rename("ERROR_INVALID_OUTPUT_VOLTAGE_AT_SAMP_CLK_RATE") DAQmxErrorInvalidOutputVoltageAtSampClkRate;
%rename("ERROR_STROBE_PHASE_SHIFT_DCMBECAME_UNLOCKED") DAQmxErrorStrobePhaseShiftDCMBecameUnlocked;
%rename("ERROR_DRIVE_PHASE_SHIFT_DCMBECAME_UNLOCKED") DAQmxErrorDrivePhaseShiftDCMBecameUnlocked;
%rename("ERROR_CLK_OUT_PHASE_SHIFT_DCMBECAME_UNLOCKED") DAQmxErrorClkOutPhaseShiftDCMBecameUnlocked;
%rename("ERROR_OUTPUT_BOARD_CLK_DCMBECAME_UNLOCKED") DAQmxErrorOutputBoardClkDCMBecameUnlocked;
%rename("ERROR_INPUT_BOARD_CLK_DCMBECAME_UNLOCKED") DAQmxErrorInputBoardClkDCMBecameUnlocked;
%rename("ERROR_INTERNAL_CLK_DCMBECAME_UNLOCKED") DAQmxErrorInternalClkDCMBecameUnlocked;
%rename("ERROR_DCMLOCK") DAQmxErrorDCMLock;
%rename("ERROR_DATA_LINE_RESERVED_FOR_DYNAMIC_OUTPUT") DAQmxErrorDataLineReservedForDynamicOutput;
%rename("ERROR_INVALID_REF_CLK_SRC_GIVEN_SAMP_CLK_SRC") DAQmxErrorInvalidRefClkSrcGivenSampClkSrc;
%rename("ERROR_NO_PATTERN_MATCHER_AVAILABLE") DAQmxErrorNoPatternMatcherAvailable;
%rename("ERROR_INVALID_DELAY_SAMP_RATE_BELOW_PHASE_SHIFT_DCMTHRESH") DAQmxErrorInvalidDelaySampRateBelowPhaseShiftDCMThresh;
%rename("ERROR_STRAIN_GAGE_CALIBRATION") DAQmxErrorStrainGageCalibration;
%rename("ERROR_INVALID_EXT_CLOCK_FREQ_AND_DIV_COMBO") DAQmxErrorInvalidExtClockFreqAndDivCombo;
%rename("ERROR_CUSTOM_SCALE_DOES_NOT_EXIST") DAQmxErrorCustomScaleDoesNotExist;
%rename("ERROR_ONLY_FRONT_END_CHAN_OPS_DURING_SCAN") DAQmxErrorOnlyFrontEndChanOpsDuringScan;
%rename("ERROR_INVALID_OPTION_FOR_DIGITAL_PORT_CHANNEL") DAQmxErrorInvalidOptionForDigitalPortChannel;
%rename("ERROR_UNSUPPORTED_SIGNAL_TYPE_EXPORT_SIGNAL") DAQmxErrorUnsupportedSignalTypeExportSignal;
%rename("ERROR_INVALID_SIGNAL_TYPE_EXPORT_SIGNAL") DAQmxErrorInvalidSignalTypeExportSignal;
%rename("ERROR_UNSUPPORTED_TRIG_TYPE_SENDS_SWTRIG") DAQmxErrorUnsupportedTrigTypeSendsSWTrig;
%rename("ERROR_INVALID_TRIG_TYPE_SENDS_SWTRIG") DAQmxErrorInvalidTrigTypeSendsSWTrig;
%rename("ERROR_REPEATED_PHYSICAL_CHAN") DAQmxErrorRepeatedPhysicalChan;
%rename("ERROR_RESOURCES_IN_USE_FOR_ROUTE_IN_TASK") DAQmxErrorResourcesInUseForRouteInTask;
%rename("ERROR_RESOURCES_IN_USE_FOR_ROUTE") DAQmxErrorResourcesInUseForRoute;
%rename("ERROR_ROUTE_NOT_SUPPORTED_BY_HW") DAQmxErrorRouteNotSupportedByHW;
%rename("ERROR_RESOURCES_IN_USE_FOR_EXPORT_SIGNAL_POLARITY") DAQmxErrorResourcesInUseForExportSignalPolarity;
%rename("ERROR_RESOURCES_IN_USE_FOR_INVERSION_IN_TASK") DAQmxErrorResourcesInUseForInversionInTask;
%rename("ERROR_RESOURCES_IN_USE_FOR_INVERSION") DAQmxErrorResourcesInUseForInversion;
%rename("ERROR_EXPORT_SIGNAL_POLARITY_NOT_SUPPORTED_BY_HW") DAQmxErrorExportSignalPolarityNotSupportedByHW;
%rename("ERROR_INVERSION_NOT_SUPPORTED_BY_HW") DAQmxErrorInversionNotSupportedByHW;
%rename("ERROR_OVERLOADED_CHANS_EXIST_NOT_READ") DAQmxErrorOverloadedChansExistNotRead;
%rename("ERROR_INPUT_FIFOOVERFLOW2") DAQmxErrorInputFIFOOverflow2;
%rename("ERROR_CJCCHAN_NOT_SPECD") DAQmxErrorCJCChanNotSpecd;
%rename("ERROR_CTR_EXPORT_SIGNAL_NOT_POSSIBLE") DAQmxErrorCtrExportSignalNotPossible;
%rename("ERROR_REF_TRIG_WHEN_CONTINUOUS") DAQmxErrorRefTrigWhenContinuous;
%rename("ERROR_INCOMPATIBLE_SENSOR_OUTPUT_AND_DEVICE_INPUT_RANGES") DAQmxErrorIncompatibleSensorOutputAndDeviceInputRanges;
%rename("ERROR_CUSTOM_SCALE_NAME_USED") DAQmxErrorCustomScaleNameUsed;
%rename("ERROR_PROPERTY_VAL_NOT_SUPPORTED_BY_HW") DAQmxErrorPropertyValNotSupportedByHW;
%rename("ERROR_PROPERTY_VAL_NOT_VALID_TERM_NAME") DAQmxErrorPropertyValNotValidTermName;
%rename("ERROR_RESOURCES_IN_USE_FOR_PROPERTY") DAQmxErrorResourcesInUseForProperty;
%rename("ERROR_CJCCHAN_ALREADY_USED") DAQmxErrorCJCChanAlreadyUsed;
%rename("ERROR_FORWARD_POLYNOMIAL_COEF_NOT_SPECD") DAQmxErrorForwardPolynomialCoefNotSpecd;
%rename("ERROR_TABLE_SCALE_NUM_PRE_SCALED_AND_SCALED_VALS_NOT_EQUAL") DAQmxErrorTableScaleNumPreScaledAndScaledValsNotEqual;
%rename("ERROR_TABLE_SCALE_PRE_SCALED_VALS_NOT_SPECD") DAQmxErrorTableScalePreScaledValsNotSpecd;
%rename("ERROR_TABLE_SCALE_SCALED_VALS_NOT_SPECD") DAQmxErrorTableScaleScaledValsNotSpecd;
%rename("ERROR_INTERMEDIATE_BUFFER_SIZE_NOT_MULTIPLE_OF_INCR") DAQmxErrorIntermediateBufferSizeNotMultipleOfIncr;
%rename("ERROR_EVENT_PULSE_WIDTH_OUT_OF_RANGE") DAQmxErrorEventPulseWidthOutOfRange;
%rename("ERROR_EVENT_DELAY_OUT_OF_RANGE") DAQmxErrorEventDelayOutOfRange;
%rename("ERROR_SAMP_PER_CHAN_NOT_MULTIPLE_OF_INCR") DAQmxErrorSampPerChanNotMultipleOfIncr;
%rename("ERROR_CANNOT_CALCULATE_NUM_SAMPS_TASK_NOT_STARTED") DAQmxErrorCannotCalculateNumSampsTaskNotStarted;
%rename("ERROR_SCRIPT_NOT_IN_MEM") DAQmxErrorScriptNotInMem;
%rename("ERROR_ONBOARD_MEM_TOO_SMALL") DAQmxErrorOnboardMemTooSmall;
%rename("ERROR_READ_ALL_AVAILABLE_DATA_WITHOUT_BUFFER") DAQmxErrorReadAllAvailableDataWithoutBuffer;
%rename("ERROR_PULSE_ACTIVE_AT_START") DAQmxErrorPulseActiveAtStart;
%rename("ERROR_CAL_TEMP_NOT_SUPPORTED") DAQmxErrorCalTempNotSupported;
%rename("ERROR_DELAY_FROM_SAMP_CLK_TOO_LONG") DAQmxErrorDelayFromSampClkTooLong;
%rename("ERROR_DELAY_FROM_SAMP_CLK_TOO_SHORT") DAQmxErrorDelayFromSampClkTooShort;
%rename("ERROR_AICONV_RATE_TOO_HIGH") DAQmxErrorAIConvRateTooHigh;
%rename("ERROR_DELAY_FROM_START_TRIG_TOO_LONG") DAQmxErrorDelayFromStartTrigTooLong;
%rename("ERROR_DELAY_FROM_START_TRIG_TOO_SHORT") DAQmxErrorDelayFromStartTrigTooShort;
%rename("ERROR_SAMP_RATE_TOO_HIGH") DAQmxErrorSampRateTooHigh;
%rename("ERROR_SAMP_RATE_TOO_LOW") DAQmxErrorSampRateTooLow;
%rename("ERROR_PFI0USED_FOR_ANALOG_AND_DIGITAL_SRC") DAQmxErrorPFI0UsedForAnalogAndDigitalSrc;
%rename("ERROR_PRIMING_CFG_FIFO") DAQmxErrorPrimingCfgFIFO;
%rename("ERROR_CANNOT_OPEN_TOPOLOGY_CFG_FILE") DAQmxErrorCannotOpenTopologyCfgFile;
%rename("ERROR_INVALID_DTINSIDE_WFM_DATA_TYPE") DAQmxErrorInvalidDTInsideWfmDataType;
%rename("ERROR_ROUTE_SRC_AND_DEST_SAME") DAQmxErrorRouteSrcAndDestSame;
%rename("ERROR_REVERSE_POLYNOMIAL_COEF_NOT_SPECD") DAQmxErrorReversePolynomialCoefNotSpecd;
%rename("ERROR_DEV_ABSENT_OR_UNAVAILABLE") DAQmxErrorDevAbsentOrUnavailable;
%rename("ERROR_NO_ADV_TRIG_FOR_MULTI_DEV_SCAN") DAQmxErrorNoAdvTrigForMultiDevScan;
%rename("ERROR_INTERRUPTS_INSUFFICIENT_DATA_XFER_MECH") DAQmxErrorInterruptsInsufficientDataXferMech;
%rename("ERROR_INVALID_ATTENTUATION_BASED_ON_MIN_MAX") DAQmxErrorInvalidAttentuationBasedOnMinMax;
%rename("ERROR_CABLED_MODULE_CANNOT_ROUTE_SSH") DAQmxErrorCabledModuleCannotRouteSSH;
%rename("ERROR_CABLED_MODULE_CANNOT_ROUTE_CONV_CLK") DAQmxErrorCabledModuleCannotRouteConvClk;
%rename("ERROR_INVALID_EXCIT_VAL_FOR_SCALING") DAQmxErrorInvalidExcitValForScaling;
%rename("ERROR_NO_DEV_MEM_FOR_SCRIPT") DAQmxErrorNoDevMemForScript;
%rename("ERROR_SCRIPT_DATA_UNDERFLOW") DAQmxErrorScriptDataUnderflow;
%rename("ERROR_NO_DEV_MEM_FOR_WAVEFORM") DAQmxErrorNoDevMemForWaveform;
%rename("ERROR_STREAM_DCMBECAME_UNLOCKED") DAQmxErrorStreamDCMBecameUnlocked;
%rename("ERROR_STREAM_DCMLOCK") DAQmxErrorStreamDCMLock;
%rename("ERROR_WAVEFORM_NOT_IN_MEM") DAQmxErrorWaveformNotInMem;
%rename("ERROR_WAVEFORM_WRITE_OUT_OF_BOUNDS") DAQmxErrorWaveformWriteOutOfBounds;
%rename("ERROR_WAVEFORM_PREVIOUSLY_ALLOCATED") DAQmxErrorWaveformPreviouslyAllocated;
%rename("ERROR_SAMP_CLK_TB_MASTER_TB_DIV_NOT_APPROPRIATE_FOR_SAMP_TB_SRC") DAQmxErrorSampClkTbMasterTbDivNotAppropriateForSampTbSrc;
%rename("ERROR_SAMP_TB_RATE_SAMP_TB_SRC_MISMATCH") DAQmxErrorSampTbRateSampTbSrcMismatch;
%rename("ERROR_MASTER_TB_RATE_MASTER_TB_SRC_MISMATCH") DAQmxErrorMasterTbRateMasterTbSrcMismatch;
%rename("ERROR_SAMPS_PER_CHAN_TOO_BIG") DAQmxErrorSampsPerChanTooBig;
%rename("ERROR_FINITE_PULSE_TRAIN_NOT_POSSIBLE") DAQmxErrorFinitePulseTrainNotPossible;
%rename("ERROR_EXT_MASTER_TIMEBASE_RATE_NOT_SPECIFIED") DAQmxErrorExtMasterTimebaseRateNotSpecified;
%rename("ERROR_EXT_SAMP_CLK_SRC_NOT_SPECIFIED") DAQmxErrorExtSampClkSrcNotSpecified;
%rename("ERROR_INPUT_SIGNAL_SLOWER_THAN_MEAS_TIME") DAQmxErrorInputSignalSlowerThanMeasTime;
%rename("ERROR_CANNOT_UPDATE_PULSE_GEN_PROPERTY") DAQmxErrorCannotUpdatePulseGenProperty;
%rename("ERROR_INVALID_TIMING_TYPE") DAQmxErrorInvalidTimingType;
%rename("ERROR_PROPERTY_UNAVAIL_WHEN_USING_ONBOARD_MEMORY") DAQmxErrorPropertyUnavailWhenUsingOnboardMemory;
%rename("ERROR_CANNOT_WRITE_AFTER_START_WITH_ONBOARD_MEMORY") DAQmxErrorCannotWriteAfterStartWithOnboardMemory;
%rename("ERROR_NOT_ENOUGH_SAMPS_WRITTEN_FOR_INITIAL_XFER_RQST_CONDITION") DAQmxErrorNotEnoughSampsWrittenForInitialXferRqstCondition;
%rename("ERROR_NO_MORE_SPACE") DAQmxErrorNoMoreSpace;
%rename("ERROR_SAMPLES_CAN_NOT_YET_BE_WRITTEN") DAQmxErrorSamplesCanNotYetBeWritten;
%rename("ERROR_GEN_STOPPED_TO_PREVENT_INTERMEDIATE_BUFFER_REGEN_OF_OLD_SAMPLES") DAQmxErrorGenStoppedToPreventIntermediateBufferRegenOfOldSamples;
%rename("ERROR_GEN_STOPPED_TO_PREVENT_REGEN_OF_OLD_SAMPLES") DAQmxErrorGenStoppedToPreventRegenOfOldSamples;
%rename("ERROR_SAMPLES_NO_LONGER_WRITEABLE") DAQmxErrorSamplesNoLongerWriteable;
%rename("ERROR_SAMPLES_WILL_NEVER_BE_GENERATED") DAQmxErrorSamplesWillNeverBeGenerated;
%rename("ERROR_NEGATIVE_WRITE_SAMPLE_NUMBER") DAQmxErrorNegativeWriteSampleNumber;
%rename("ERROR_NO_ACQ_STARTED") DAQmxErrorNoAcqStarted;
%rename("ERROR_SAMPLES_NOT_YET_AVAILABLE") DAQmxErrorSamplesNotYetAvailable;
%rename("ERROR_ACQ_STOPPED_TO_PREVENT_INTERMEDIATE_BUFFER_OVERFLOW") DAQmxErrorAcqStoppedToPreventIntermediateBufferOverflow;
%rename("ERROR_NO_REF_TRIG_CONFIGURED") DAQmxErrorNoRefTrigConfigured;
%rename("ERROR_CANNOT_READ_RELATIVE_TO_REF_TRIG_UNTIL_DONE") DAQmxErrorCannotReadRelativeToRefTrigUntilDone;
%rename("ERROR_SAMPLES_NO_LONGER_AVAILABLE") DAQmxErrorSamplesNoLongerAvailable;
%rename("ERROR_SAMPLES_WILL_NEVER_BE_AVAILABLE") DAQmxErrorSamplesWillNeverBeAvailable;
%rename("ERROR_NEGATIVE_READ_SAMPLE_NUMBER") DAQmxErrorNegativeReadSampleNumber;
%rename("ERROR_EXTERNAL_SAMP_CLK_AND_REF_CLK_THRU_SAME_TERM") DAQmxErrorExternalSampClkAndRefClkThruSameTerm;
%rename("ERROR_EXT_SAMP_CLK_RATE_TOO_LOW_FOR_CLK_IN") DAQmxErrorExtSampClkRateTooLowForClkIn;
%rename("ERROR_EXT_SAMP_CLK_RATE_TOO_HIGH_FOR_BACKPLANE") DAQmxErrorExtSampClkRateTooHighForBackplane;
%rename("ERROR_SAMP_CLK_RATE_AND_DIV_COMBO") DAQmxErrorSampClkRateAndDivCombo;
%rename("ERROR_SAMP_CLK_RATE_TOO_LOW_FOR_DIV_DOWN") DAQmxErrorSampClkRateTooLowForDivDown;
%rename("ERROR_PRODUCT_OF_AOMIN_AND_GAIN_TOO_SMALL") DAQmxErrorProductOfAOMinAndGainTooSmall;
%rename("ERROR_INTERPOLATION_RATE_NOT_POSSIBLE") DAQmxErrorInterpolationRateNotPossible;
%rename("ERROR_OFFSET_TOO_LARGE") DAQmxErrorOffsetTooLarge;
%rename("ERROR_OFFSET_TOO_SMALL") DAQmxErrorOffsetTooSmall;
%rename("ERROR_PRODUCT_OF_AOMAX_AND_GAIN_TOO_LARGE") DAQmxErrorProductOfAOMaxAndGainTooLarge;
%rename("ERROR_MIN_AND_MAX_NOT_SYMMETRIC") DAQmxErrorMinAndMaxNotSymmetric;
%rename("ERROR_INVALID_ANALOG_TRIG_SRC") DAQmxErrorInvalidAnalogTrigSrc;
%rename("ERROR_TOO_MANY_CHANS_FOR_ANALOG_REF_TRIG") DAQmxErrorTooManyChansForAnalogRefTrig;
%rename("ERROR_TOO_MANY_CHANS_FOR_ANALOG_PAUSE_TRIG") DAQmxErrorTooManyChansForAnalogPauseTrig;
%rename("ERROR_TRIG_WHEN_ON_DEMAND_SAMP_TIMING") DAQmxErrorTrigWhenOnDemandSampTiming;
%rename("ERROR_INCONSISTENT_ANALOG_TRIG_SETTINGS") DAQmxErrorInconsistentAnalogTrigSettings;
%rename("ERROR_MEM_MAP_DATA_XFER_MODE_SAMP_TIMING_COMBO") DAQmxErrorMemMapDataXferModeSampTimingCombo;
%rename("ERROR_INVALID_JUMPERED_ATTR") DAQmxErrorInvalidJumperedAttr;
%rename("ERROR_INVALID_GAIN_BASED_ON_MIN_MAX") DAQmxErrorInvalidGainBasedOnMinMax;
%rename("ERROR_INCONSISTENT_EXCIT") DAQmxErrorInconsistentExcit;
%rename("ERROR_TOPOLOGY_NOT_SUPPORTED_BY_CFG_TERM_BLOCK") DAQmxErrorTopologyNotSupportedByCfgTermBlock;
%rename("ERROR_BUILT_IN_TEMP_SENSOR_NOT_SUPPORTED") DAQmxErrorBuiltInTempSensorNotSupported;
%rename("ERROR_INVALID_TERM") DAQmxErrorInvalidTerm;
%rename("ERROR_CANNOT_TRISTATE_TERM") DAQmxErrorCannotTristateTerm;
%rename("ERROR_CANNOT_TRISTATE_BUSY_TERM") DAQmxErrorCannotTristateBusyTerm;
%rename("ERROR_NO_DMACHANS_AVAILABLE") DAQmxErrorNoDMAChansAvailable;
%rename("ERROR_INVALID_WAVEFORM_LENGTH_WITHIN_LOOP_IN_SCRIPT") DAQmxErrorInvalidWaveformLengthWithinLoopInScript;
%rename("ERROR_INVALID_SUBSET_LENGTH_WITHIN_LOOP_IN_SCRIPT") DAQmxErrorInvalidSubsetLengthWithinLoopInScript;
%rename("ERROR_MARKER_POS_INVALID_FOR_LOOP_IN_SCRIPT") DAQmxErrorMarkerPosInvalidForLoopInScript;
%rename("ERROR_INTEGER_EXPECTED_IN_SCRIPT") DAQmxErrorIntegerExpectedInScript;
%rename("ERROR_PLLBECAME_UNLOCKED") DAQmxErrorPLLBecameUnlocked;
%rename("ERROR_PLLLOCK") DAQmxErrorPLLLock;
%rename("ERROR_DDCCLK_OUT_DCMBECAME_UNLOCKED") DAQmxErrorDDCClkOutDCMBecameUnlocked;
%rename("ERROR_DDCCLK_OUT_DCMLOCK") DAQmxErrorDDCClkOutDCMLock;
%rename("ERROR_CLK_DOUBLER_DCMBECAME_UNLOCKED") DAQmxErrorClkDoublerDCMBecameUnlocked;
%rename("ERROR_CLK_DOUBLER_DCMLOCK") DAQmxErrorClkDoublerDCMLock;
%rename("ERROR_SAMP_CLK_DCMBECAME_UNLOCKED") DAQmxErrorSampClkDCMBecameUnlocked;
%rename("ERROR_SAMP_CLK_DCMLOCK") DAQmxErrorSampClkDCMLock;
%rename("ERROR_SAMP_CLK_TIMEBASE_DCMBECAME_UNLOCKED") DAQmxErrorSampClkTimebaseDCMBecameUnlocked;
%rename("ERROR_SAMP_CLK_TIMEBASE_DCMLOCK") DAQmxErrorSampClkTimebaseDCMLock;
%rename("ERROR_ATTR_CANNOT_BE_RESET") DAQmxErrorAttrCannotBeReset;
%rename("ERROR_EXPLANATION_NOT_FOUND") DAQmxErrorExplanationNotFound;
%rename("ERROR_WRITE_BUFFER_TOO_SMALL") DAQmxErrorWriteBufferTooSmall;
%rename("ERROR_SPECIFIED_ATTR_NOT_VALID") DAQmxErrorSpecifiedAttrNotValid;
%rename("ERROR_ATTR_CANNOT_BE_READ") DAQmxErrorAttrCannotBeRead;
%rename("ERROR_ATTR_CANNOT_BE_SET") DAQmxErrorAttrCannotBeSet;
%rename("ERROR_NULLPTR_FOR_C_API") DAQmxErrorNULLPtrForC_Api;
%rename("ERROR_READ_BUFFER_TOO_SMALL") DAQmxErrorReadBufferTooSmall;
%rename("ERROR_BUFFER_TOO_SMALL_FOR_STRING") DAQmxErrorBufferTooSmallForString;
%rename("ERROR_NO_AVAIL_TRIG_LINES_ON_DEVICE") DAQmxErrorNoAvailTrigLinesOnDevice;
%rename("ERROR_TRIG_BUS_LINE_NOT_AVAIL") DAQmxErrorTrigBusLineNotAvail;
%rename("ERROR_COULD_NOT_RESERVE_REQUESTED_TRIG_LINE") DAQmxErrorCouldNotReserveRequestedTrigLine;
%rename("ERROR_TRIG_LINE_NOT_FOUND") DAQmxErrorTrigLineNotFound;
%rename("ERROR_SCXI1126THRESH_HYST_COMBINATION") DAQmxErrorSCXI1126ThreshHystCombination;
%rename("ERROR_ACQ_STOPPED_TO_PREVENT_INPUT_BUFFER_OVERWRITE") DAQmxErrorAcqStoppedToPreventInputBufferOverwrite;
%rename("ERROR_TIMEOUT_EXCEEDED") DAQmxErrorTimeoutExceeded;
%rename("ERROR_INVALID_DEVICE_ID") DAQmxErrorInvalidDeviceID;
%rename("ERROR_INVALID_AOCHAN_ORDER") DAQmxErrorInvalidAOChanOrder;
%rename("ERROR_SAMPLE_TIMING_TYPE_AND_DATA_XFER_MODE") DAQmxErrorSampleTimingTypeAndDataXferMode;
%rename("ERROR_BUFFER_WITH_ON_DEMAND_SAMP_TIMING") DAQmxErrorBufferWithOnDemandSampTiming;
%rename("ERROR_BUFFER_AND_DATA_XFER_MODE") DAQmxErrorBufferAndDataXferMode;
%rename("ERROR_MEM_MAP_AND_BUFFER") DAQmxErrorMemMapAndBuffer;
%rename("ERROR_NO_ANALOG_TRIG_HW") DAQmxErrorNoAnalogTrigHW;
%rename("ERROR_TOO_MANY_PRETRIG_PLUS_MIN_POST_TRIG_SAMPS") DAQmxErrorTooManyPretrigPlusMinPostTrigSamps;
%rename("ERROR_INCONSISTENT_UNITS_SPECIFIED") DAQmxErrorInconsistentUnitsSpecified;
%rename("ERROR_MULTIPLE_RELAYS_FOR_SINGLE_RELAY_OP") DAQmxErrorMultipleRelaysForSingleRelayOp;
%rename("ERROR_MULTIPLE_DEV_IDS_PER_CHASSIS_SPECIFIED_IN_LIST") DAQmxErrorMultipleDevIDsPerChassisSpecifiedInList;
%rename("ERROR_DUPLICATE_DEV_IDIN_LIST") DAQmxErrorDuplicateDevIDInList;
%rename("ERROR_INVALID_RANGE_STATEMENT_CHAR_IN_LIST") DAQmxErrorInvalidRangeStatementCharInList;
%rename("ERROR_INVALID_DEVICE_IDIN_LIST") DAQmxErrorInvalidDeviceIDInList;
%rename("ERROR_TRIGGER_POLARITY_CONFLICT") DAQmxErrorTriggerPolarityConflict;
%rename("ERROR_CANNOT_SCAN_WITH_CURRENT_TOPOLOGY") DAQmxErrorCannotScanWithCurrentTopology;
%rename("ERROR_UNEXPECTED_IDENTIFIER_IN_FULLY_SPECIFIED_PATH_IN_LIST") DAQmxErrorUnexpectedIdentifierInFullySpecifiedPathInList;
%rename("ERROR_SWITCH_CANNOT_DRIVE_MULTIPLE_TRIG_LINES") DAQmxErrorSwitchCannotDriveMultipleTrigLines;
%rename("ERROR_INVALID_RELAY_NAME") DAQmxErrorInvalidRelayName;
%rename("ERROR_SWITCH_SCANLIST_TOO_BIG") DAQmxErrorSwitchScanlistTooBig;
%rename("ERROR_SWITCH_CHAN_IN_USE") DAQmxErrorSwitchChanInUse;
%rename("ERROR_SWITCH_NOT_RESET_BEFORE_SCAN") DAQmxErrorSwitchNotResetBeforeScan;
%rename("ERROR_INVALID_TOPOLOGY") DAQmxErrorInvalidTopology;
%rename("ERROR_ATTR_NOT_SUPPORTED") DAQmxErrorAttrNotSupported;
%rename("ERROR_UNEXPECTED_END_OF_ACTIONS_IN_LIST") DAQmxErrorUnexpectedEndOfActionsInList;
%rename("ERROR_POWER_BUDGET_EXCEEDED") DAQmxErrorPowerBudgetExceeded;
%rename("ERROR_HWUNEXPECTEDLY_POWERED_OFF_AND_ON") DAQmxErrorHWUnexpectedlyPoweredOffAndOn;
%rename("ERROR_SWITCH_OPERATION_NOT_SUPPORTED") DAQmxErrorSwitchOperationNotSupported;
%rename("ERROR_ONLY_CONTINUOUS_SCAN_SUPPORTED") DAQmxErrorOnlyContinuousScanSupported;
%rename("ERROR_SWITCH_DIFFERENT_TOPOLOGY_WHEN_SCANNING") DAQmxErrorSwitchDifferentTopologyWhenScanning;
%rename("ERROR_DISCONNECT_PATH_NOT_SAME_AS_EXISTING_PATH") DAQmxErrorDisconnectPathNotSameAsExistingPath;
%rename("ERROR_CONNECTION_NOT_PERMITTED_ON_CHAN_RESERVED_FOR_ROUTING") DAQmxErrorConnectionNotPermittedOnChanReservedForRouting;
%rename("ERROR_CANNOT_CONNECT_SRC_CHANS") DAQmxErrorCannotConnectSrcChans;
%rename("ERROR_CANNOT_CONNECT_CHANNEL_TO_ITSELF") DAQmxErrorCannotConnectChannelToItself;
%rename("ERROR_CHANNEL_NOT_RESERVED_FOR_ROUTING") DAQmxErrorChannelNotReservedForRouting;
%rename("ERROR_CANNOT_CONNECT_CHANS_DIRECTLY") DAQmxErrorCannotConnectChansDirectly;
%rename("ERROR_CHANS_ALREADY_CONNECTED") DAQmxErrorChansAlreadyConnected;
%rename("ERROR_CHAN_DUPLICATED_IN_PATH") DAQmxErrorChanDuplicatedInPath;
%rename("ERROR_NO_PATH_TO_DISCONNECT") DAQmxErrorNoPathToDisconnect;
%rename("ERROR_INVALID_SWITCH_CHAN") DAQmxErrorInvalidSwitchChan;
%rename("ERROR_NO_PATH_AVAILABLE_BETWEEN2SWITCH_CHANS") DAQmxErrorNoPathAvailableBetween2SwitchChans;
%rename("ERROR_EXPLICIT_CONNECTION_EXISTS") DAQmxErrorExplicitConnectionExists;
%rename("ERROR_SWITCH_DIFFERENT_SETTLING_TIME_WHEN_SCANNING") DAQmxErrorSwitchDifferentSettlingTimeWhenScanning;
%rename("ERROR_OPERATION_ONLY_PERMITTED_WHILE_SCANNING") DAQmxErrorOperationOnlyPermittedWhileScanning;
%rename("ERROR_OPERATION_NOT_PERMITTED_WHILE_SCANNING") DAQmxErrorOperationNotPermittedWhileScanning;
%rename("ERROR_HARDWARE_NOT_RESPONDING") DAQmxErrorHardwareNotResponding;
%rename("ERROR_INVALID_SAMP_AND_MASTER_TIMEBASE_RATE_COMBO") DAQmxErrorInvalidSampAndMasterTimebaseRateCombo;
%rename("ERROR_NON_ZERO_BUFFER_SIZE_IN_PROG_IOXFER") DAQmxErrorNonZeroBufferSizeInProgIOXfer;
%rename("ERROR_VIRTUAL_CHAN_NAME_USED") DAQmxErrorVirtualChanNameUsed;
%rename("ERROR_PHYSICAL_CHAN_DOES_NOT_EXIST") DAQmxErrorPhysicalChanDoesNotExist;
%rename("ERROR_MEM_MAP_ONLY_FOR_PROG_IOXFER") DAQmxErrorMemMapOnlyForProgIOXfer;
%rename("ERROR_TOO_MANY_CHANS") DAQmxErrorTooManyChans;
%rename("ERROR_CANNOT_HAVE_CJTEMP_WITH_OTHER_CHANS") DAQmxErrorCannotHaveCJTempWithOtherChans;
%rename("ERROR_OUTPUT_BUFFER_UNDERWRITE") DAQmxErrorOutputBufferUnderwrite;
%rename("ERROR_SENSOR_INVALID_COMPLETION_RESISTANCE") DAQmxErrorSensorInvalidCompletionResistance;
%rename("ERROR_VOLTAGE_EXCIT_INCOMPATIBLE_WITH2WIRE_CFG") DAQmxErrorVoltageExcitIncompatibleWith2WireCfg;
%rename("ERROR_INT_EXCIT_SRC_NOT_AVAILABLE") DAQmxErrorIntExcitSrcNotAvailable;
%rename("ERROR_CANNOT_CREATE_CHANNEL_AFTER_TASK_VERIFIED") DAQmxErrorCannotCreateChannelAfterTaskVerified;
%rename("ERROR_LINES_RESERVED_FOR_SCXICONTROL") DAQmxErrorLinesReservedForSCXIControl;
%rename("ERROR_COULD_NOT_RESERVE_LINES_FOR_SCXICONTROL") DAQmxErrorCouldNotReserveLinesForSCXIControl;
%rename("ERROR_CALIBRATION_FAILED") DAQmxErrorCalibrationFailed;
%rename("ERROR_REFERENCE_FREQUENCY_INVALID") DAQmxErrorReferenceFrequencyInvalid;
%rename("ERROR_REFERENCE_RESISTANCE_INVALID") DAQmxErrorReferenceResistanceInvalid;
%rename("ERROR_REFERENCE_CURRENT_INVALID") DAQmxErrorReferenceCurrentInvalid;
%rename("ERROR_REFERENCE_VOLTAGE_INVALID") DAQmxErrorReferenceVoltageInvalid;
%rename("ERROR_EEPROMDATA_INVALID") DAQmxErrorEEPROMDataInvalid;
%rename("ERROR_CABLED_MODULE_NOT_CAPABLE_OF_ROUTING_AI") DAQmxErrorCabledModuleNotCapableOfRoutingAI;
%rename("ERROR_CHANNEL_NOT_AVAILABLE_IN_PARALLEL_MODE") DAQmxErrorChannelNotAvailableInParallelMode;
%rename("ERROR_EXTERNAL_TIMEBASE_RATE_NOT_KNOWN_FOR_DELAY") DAQmxErrorExternalTimebaseRateNotKnownForDelay;
%rename("ERROR_FREQOUTCANNOT_PRODUCE_DESIRED_FREQUENCY") DAQmxErrorFREQOUTCannotProduceDesiredFrequency;
%rename("ERROR_MULTIPLE_COUNTER_INPUT_TASK") DAQmxErrorMultipleCounterInputTask;
%rename("ERROR_COUNTER_START_PAUSE_TRIGGER_CONFLICT") DAQmxErrorCounterStartPauseTriggerConflict;
%rename("ERROR_COUNTER_INPUT_PAUSE_TRIGGER_AND_SAMPLE_CLOCK_INVALID") DAQmxErrorCounterInputPauseTriggerAndSampleClockInvalid;
%rename("ERROR_COUNTER_OUTPUT_PAUSE_TRIGGER_INVALID") DAQmxErrorCounterOutputPauseTriggerInvalid;
%rename("ERROR_COUNTER_TIMEBASE_RATE_NOT_SPECIFIED") DAQmxErrorCounterTimebaseRateNotSpecified;
%rename("ERROR_COUNTER_TIMEBASE_RATE_NOT_FOUND") DAQmxErrorCounterTimebaseRateNotFound;
%rename("ERROR_COUNTER_OVERFLOW") DAQmxErrorCounterOverflow;
%rename("ERROR_COUNTER_NO_TIMEBASE_EDGES_BETWEEN_GATES") DAQmxErrorCounterNoTimebaseEdgesBetweenGates;
%rename("ERROR_COUNTER_MAX_MIN_RANGE_FREQ") DAQmxErrorCounterMaxMinRangeFreq;
%rename("ERROR_COUNTER_MAX_MIN_RANGE_TIME") DAQmxErrorCounterMaxMinRangeTime;
%rename("ERROR_SUITABLE_TIMEBASE_NOT_FOUND_TIME_COMBO") DAQmxErrorSuitableTimebaseNotFoundTimeCombo;
%rename("ERROR_SUITABLE_TIMEBASE_NOT_FOUND_FREQUENCY_COMBO") DAQmxErrorSuitableTimebaseNotFoundFrequencyCombo;
%rename("ERROR_INTERNAL_TIMEBASE_SOURCE_DIVISOR_COMBO") DAQmxErrorInternalTimebaseSourceDivisorCombo;
%rename("ERROR_INTERNAL_TIMEBASE_SOURCE_RATE_COMBO") DAQmxErrorInternalTimebaseSourceRateCombo;
%rename("ERROR_INTERNAL_TIMEBASE_RATE_DIVISOR_SOURCE_COMBO") DAQmxErrorInternalTimebaseRateDivisorSourceCombo;
%rename("ERROR_EXTERNAL_TIMEBASE_RATE_NOTKNOWN_FOR_RATE") DAQmxErrorExternalTimebaseRateNotknownForRate;
%rename("ERROR_ANALOG_TRIG_CHAN_NOT_FIRST_IN_SCAN_LIST") DAQmxErrorAnalogTrigChanNotFirstInScanList;
%rename("ERROR_NO_DIVISOR_FOR_EXTERNAL_SIGNAL") DAQmxErrorNoDivisorForExternalSignal;
%rename("ERROR_ATTRIBUTE_INCONSISTENT_ACROSS_REPEATED_PHYSICAL_CHANNELS") DAQmxErrorAttributeInconsistentAcrossRepeatedPhysicalChannels;
%rename("ERROR_CANNOT_HANDSHAKE_WITH_PORT0") DAQmxErrorCannotHandshakeWithPort0;
%rename("ERROR_CONTROL_LINE_CONFLICT_ON_PORT_C") DAQmxErrorControlLineConflictOnPortC;
%rename("ERROR_LINES4TO7CONFIGURED_FOR_OUTPUT") DAQmxErrorLines4To7ConfiguredForOutput;
%rename("ERROR_LINES4TO7CONFIGURED_FOR_INPUT") DAQmxErrorLines4To7ConfiguredForInput;
%rename("ERROR_LINES0TO3CONFIGURED_FOR_OUTPUT") DAQmxErrorLines0To3ConfiguredForOutput;
%rename("ERROR_LINES0TO3CONFIGURED_FOR_INPUT") DAQmxErrorLines0To3ConfiguredForInput;
%rename("ERROR_PORT_CONFIGURED_FOR_OUTPUT") DAQmxErrorPortConfiguredForOutput;
%rename("ERROR_PORT_CONFIGURED_FOR_INPUT") DAQmxErrorPortConfiguredForInput;
%rename("ERROR_PORT_CONFIGURED_FOR_STATIC_DIGITAL_OPS") DAQmxErrorPortConfiguredForStaticDigitalOps;
%rename("ERROR_PORT_RESERVED_FOR_HANDSHAKING") DAQmxErrorPortReservedForHandshaking;
%rename("ERROR_PORT_DOES_NOT_SUPPORT_HANDSHAKING_DATA_IO") DAQmxErrorPortDoesNotSupportHandshakingDataIO;
%rename("ERROR_CANNOT_TRISTATE8255OUTPUT_LINES") DAQmxErrorCannotTristate8255OutputLines;
%rename("ERROR_TEMPERATURE_OUT_OF_RANGE_FOR_CALIBRATION") DAQmxErrorTemperatureOutOfRangeForCalibration;
%rename("ERROR_CALIBRATION_HANDLE_INVALID") DAQmxErrorCalibrationHandleInvalid;
%rename("ERROR_PASSWORD_REQUIRED") DAQmxErrorPasswordRequired;
%rename("ERROR_INCORRECT_PASSWORD") DAQmxErrorIncorrectPassword;
%rename("ERROR_PASSWORD_TOO_LONG") DAQmxErrorPasswordTooLong;
%rename("ERROR_CALIBRATION_SESSION_ALREADY_OPEN") DAQmxErrorCalibrationSessionAlreadyOpen;
%rename("ERROR_SCXIMODULE_INCORRECT") DAQmxErrorSCXIModuleIncorrect;
%rename("ERROR_ATTRIBUTE_INCONSISTENT_ACROSS_CHANNELS_ON_DEVICE") DAQmxErrorAttributeInconsistentAcrossChannelsOnDevice;
%rename("ERROR_SCXI1122RESISTANCE_CHAN_NOT_SUPPORTED_FOR_CFG") DAQmxErrorSCXI1122ResistanceChanNotSupportedForCfg;
%rename("ERROR_BRACKET_PAIRING_MISMATCH_IN_LIST") DAQmxErrorBracketPairingMismatchInList;
%rename("ERROR_INCONSISTENT_NUM_SAMPLES_TO_WRITE") DAQmxErrorInconsistentNumSamplesToWrite;
%rename("ERROR_INCORRECT_DIGITAL_PATTERN") DAQmxErrorIncorrectDigitalPattern;
%rename("ERROR_INCORRECT_NUM_CHANNELS_TO_WRITE") DAQmxErrorIncorrectNumChannelsToWrite;
%rename("ERROR_INCORRECT_READ_FUNCTION") DAQmxErrorIncorrectReadFunction;
%rename("ERROR_PHYSICAL_CHANNEL_NOT_SPECIFIED") DAQmxErrorPhysicalChannelNotSpecified;
%rename("ERROR_MORE_THAN_ONE_TERMINAL") DAQmxErrorMoreThanOneTerminal;
%rename("ERROR_MORE_THAN_ONE_ACTIVE_CHANNEL_SPECIFIED") DAQmxErrorMoreThanOneActiveChannelSpecified;
%rename("ERROR_INVALID_NUMBER_SAMPLES_TO_READ") DAQmxErrorInvalidNumberSamplesToRead;
%rename("ERROR_ANALOG_WAVEFORM_EXPECTED") DAQmxErrorAnalogWaveformExpected;
%rename("ERROR_DIGITAL_WAVEFORM_EXPECTED") DAQmxErrorDigitalWaveformExpected;
%rename("ERROR_ACTIVE_CHANNEL_NOT_SPECIFIED") DAQmxErrorActiveChannelNotSpecified;
%rename("ERROR_FUNCTION_NOT_SUPPORTED_FOR_DEVICE_TASKS") DAQmxErrorFunctionNotSupportedForDeviceTasks;
%rename("ERROR_FUNCTION_NOT_IN_LIBRARY") DAQmxErrorFunctionNotInLibrary;
%rename("ERROR_LIBRARY_NOT_PRESENT") DAQmxErrorLibraryNotPresent;
%rename("ERROR_DUPLICATE_TASK") DAQmxErrorDuplicateTask;
%rename("ERROR_INVALID_TASK") DAQmxErrorInvalidTask;
%rename("ERROR_INVALID_CHANNEL") DAQmxErrorInvalidChannel;
%rename("ERROR_INVALID_SYNTAX_FOR_PHYSICAL_CHANNEL_RANGE") DAQmxErrorInvalidSyntaxForPhysicalChannelRange;
%rename("ERROR_MIN_NOT_LESS_THAN_MAX") DAQmxErrorMinNotLessThanMax;
%rename("ERROR_SAMPLE_RATE_NUM_CHANS_CONVERT_PERIOD_COMBO") DAQmxErrorSampleRateNumChansConvertPeriodCombo;
%rename("ERROR_AODURING_COUNTER1DMACONFLICT") DAQmxErrorAODuringCounter1DMAConflict;
%rename("ERROR_AIDURING_COUNTER0DMACONFLICT") DAQmxErrorAIDuringCounter0DMAConflict;
%rename("ERROR_INVALID_ATTRIBUTE_VALUE") DAQmxErrorInvalidAttributeValue;
%rename("ERROR_SUPPLIED_CURRENT_DATA_OUTSIDE_SPECIFIED_RANGE") DAQmxErrorSuppliedCurrentDataOutsideSpecifiedRange;
%rename("ERROR_SUPPLIED_VOLTAGE_DATA_OUTSIDE_SPECIFIED_RANGE") DAQmxErrorSuppliedVoltageDataOutsideSpecifiedRange;
%rename("ERROR_CANNOT_STORE_CAL_CONST") DAQmxErrorCannotStoreCalConst;
%rename("ERROR_SCXIMODULE_NOT_FOUND") DAQmxErrorSCXIModuleNotFound;
%rename("ERROR_DUPLICATE_PHYSICAL_CHANS_NOT_SUPPORTED") DAQmxErrorDuplicatePhysicalChansNotSupported;
%rename("ERROR_TOO_MANY_PHYSICAL_CHANS_IN_LIST") DAQmxErrorTooManyPhysicalChansInList;
%rename("ERROR_INVALID_ADVANCE_EVENT_TRIGGER_TYPE") DAQmxErrorInvalidAdvanceEventTriggerType;
%rename("ERROR_DEVICE_IS_NOT_AVALID_SWITCH") DAQmxErrorDeviceIsNotAValidSwitch;
%rename("ERROR_DEVICE_DOES_NOT_SUPPORT_SCANNING") DAQmxErrorDeviceDoesNotSupportScanning;
%rename("ERROR_SCAN_LIST_CANNOT_BE_TIMED") DAQmxErrorScanListCannotBeTimed;
%rename("ERROR_CONNECT_OPERATOR_INVALID_AT_POINT_IN_LIST") DAQmxErrorConnectOperatorInvalidAtPointInList;
%rename("ERROR_UNEXPECTED_SWITCH_ACTION_IN_LIST") DAQmxErrorUnexpectedSwitchActionInList;
%rename("ERROR_UNEXPECTED_SEPARATOR_IN_LIST") DAQmxErrorUnexpectedSeparatorInList;
%rename("ERROR_EXPECTED_TERMINATOR_IN_LIST") DAQmxErrorExpectedTerminatorInList;
%rename("ERROR_EXPECTED_CONNECT_OPERATOR_IN_LIST") DAQmxErrorExpectedConnectOperatorInList;
%rename("ERROR_EXPECTED_SEPARATOR_IN_LIST") DAQmxErrorExpectedSeparatorInList;
%rename("ERROR_FULLY_SPECIFIED_PATH_IN_LIST_CONTAINS_RANGE") DAQmxErrorFullySpecifiedPathInListContainsRange;
%rename("ERROR_CONNECTION_SEPARATOR_AT_END_OF_LIST") DAQmxErrorConnectionSeparatorAtEndOfList;
%rename("ERROR_IDENTIFIER_IN_LIST_TOO_LONG") DAQmxErrorIdentifierInListTooLong;
%rename("ERROR_DUPLICATE_DEVICE_IDIN_LIST_WHEN_SETTLING") DAQmxErrorDuplicateDeviceIDInListWhenSettling;
%rename("ERROR_CHANNEL_NAME_NOT_SPECIFIED_IN_LIST") DAQmxErrorChannelNameNotSpecifiedInList;
%rename("ERROR_DEVICE_IDNOT_SPECIFIED_IN_LIST") DAQmxErrorDeviceIDNotSpecifiedInList;
%rename("ERROR_SEMICOLON_DOES_NOT_FOLLOW_RANGE_IN_LIST") DAQmxErrorSemicolonDoesNotFollowRangeInList;
%rename("ERROR_SWITCH_ACTION_IN_LIST_SPANS_MULTIPLE_DEVICES") DAQmxErrorSwitchActionInListSpansMultipleDevices;
%rename("ERROR_RANGE_WITHOUT_ACONNECT_ACTION_IN_LIST") DAQmxErrorRangeWithoutAConnectActionInList;
%rename("ERROR_INVALID_IDENTIFIER_FOLLOWING_SEPARATOR_IN_LIST") DAQmxErrorInvalidIdentifierFollowingSeparatorInList;
%rename("ERROR_INVALID_CHANNEL_NAME_IN_LIST") DAQmxErrorInvalidChannelNameInList;
%rename("ERROR_INVALID_NUMBER_IN_REPEAT_STATEMENT_IN_LIST") DAQmxErrorInvalidNumberInRepeatStatementInList;
%rename("ERROR_INVALID_TRIGGER_LINE_IN_LIST") DAQmxErrorInvalidTriggerLineInList;
%rename("ERROR_INVALID_IDENTIFIER_IN_LIST_FOLLOWING_DEVICE_ID") DAQmxErrorInvalidIdentifierInListFollowingDeviceID;
%rename("ERROR_INVALID_IDENTIFIER_IN_LIST_AT_END_OF_SWITCH_ACTION") DAQmxErrorInvalidIdentifierInListAtEndOfSwitchAction;
%rename("ERROR_DEVICE_REMOVED") DAQmxErrorDeviceRemoved;
%rename("ERROR_ROUTING_PATH_NOT_AVAILABLE") DAQmxErrorRoutingPathNotAvailable;
%rename("ERROR_ROUTING_HARDWARE_BUSY") DAQmxErrorRoutingHardwareBusy;
%rename("ERROR_REQUESTED_SIGNAL_INVERSION_FOR_ROUTING_NOT_POSSIBLE") DAQmxErrorRequestedSignalInversionForRoutingNotPossible;
%rename("ERROR_INVALID_ROUTING_DESTINATION_TERMINAL_NAME") DAQmxErrorInvalidRoutingDestinationTerminalName;
%rename("ERROR_INVALID_ROUTING_SOURCE_TERMINAL_NAME") DAQmxErrorInvalidRoutingSourceTerminalName;
%rename("ERROR_ROUTING_NOT_SUPPORTED_FOR_DEVICE") DAQmxErrorRoutingNotSupportedForDevice;
%rename("ERROR_WAIT_IS_LAST_INSTRUCTION_OF_LOOP_IN_SCRIPT") DAQmxErrorWaitIsLastInstructionOfLoopInScript;
%rename("ERROR_CLEAR_IS_LAST_INSTRUCTION_OF_LOOP_IN_SCRIPT") DAQmxErrorClearIsLastInstructionOfLoopInScript;
%rename("ERROR_INVALID_LOOP_ITERATIONS_IN_SCRIPT") DAQmxErrorInvalidLoopIterationsInScript;
%rename("ERROR_REPEAT_LOOP_NESTING_TOO_DEEP_IN_SCRIPT") DAQmxErrorRepeatLoopNestingTooDeepInScript;
%rename("ERROR_MARKER_POSITION_OUTSIDE_SUBSET_IN_SCRIPT") DAQmxErrorMarkerPositionOutsideSubsetInScript;
%rename("ERROR_SUBSET_START_OFFSET_NOT_ALIGNED_IN_SCRIPT") DAQmxErrorSubsetStartOffsetNotAlignedInScript;
%rename("ERROR_INVALID_SUBSET_LENGTH_IN_SCRIPT") DAQmxErrorInvalidSubsetLengthInScript;
%rename("ERROR_MARKER_POSITION_NOT_ALIGNED_IN_SCRIPT") DAQmxErrorMarkerPositionNotAlignedInScript;
%rename("ERROR_SUBSET_OUTSIDE_WAVEFORM_IN_SCRIPT") DAQmxErrorSubsetOutsideWaveformInScript;
%rename("ERROR_MARKER_OUTSIDE_WAVEFORM_IN_SCRIPT") DAQmxErrorMarkerOutsideWaveformInScript;
%rename("ERROR_WAVEFORM_IN_SCRIPT_NOT_IN_MEM") DAQmxErrorWaveformInScriptNotInMem;
%rename("ERROR_KEYWORD_EXPECTED_IN_SCRIPT") DAQmxErrorKeywordExpectedInScript;
%rename("ERROR_BUFFER_NAME_EXPECTED_IN_SCRIPT") DAQmxErrorBufferNameExpectedInScript;
%rename("ERROR_PROCEDURE_NAME_EXPECTED_IN_SCRIPT") DAQmxErrorProcedureNameExpectedInScript;
%rename("ERROR_SCRIPT_HAS_INVALID_IDENTIFIER") DAQmxErrorScriptHasInvalidIdentifier;
%rename("ERROR_SCRIPT_HAS_INVALID_CHARACTER") DAQmxErrorScriptHasInvalidCharacter;
%rename("ERROR_RESOURCE_ALREADY_RESERVED") DAQmxErrorResourceAlreadyReserved;
%rename("ERROR_SELF_TEST_FAILED") DAQmxErrorSelfTestFailed;
%rename("ERROR_ADCOVERRUN") DAQmxErrorADCOverrun;
%rename("ERROR_DACUNDERFLOW") DAQmxErrorDACUnderflow;
%rename("ERROR_INPUT_FIFOUNDERFLOW") DAQmxErrorInputFIFOUnderflow;
%rename("ERROR_OUTPUT_FIFOUNDERFLOW") DAQmxErrorOutputFIFOUnderflow;
%rename("ERROR_SCXISERIAL_COMMUNICATION") DAQmxErrorSCXISerialCommunication;
%rename("ERROR_DIGITAL_TERMINAL_SPECIFIED_MORE_THAN_ONCE") DAQmxErrorDigitalTerminalSpecifiedMoreThanOnce;
%rename("ERROR_DIGITAL_OUTPUT_NOT_SUPPORTED") DAQmxErrorDigitalOutputNotSupported;
%rename("ERROR_INCONSISTENT_CHANNEL_DIRECTIONS") DAQmxErrorInconsistentChannelDirections;
%rename("ERROR_INPUT_FIFOOVERFLOW") DAQmxErrorInputFIFOOverflow;
%rename("ERROR_TIME_STAMP_OVERWRITTEN") DAQmxErrorTimeStampOverwritten;
%rename("ERROR_STOP_TRIGGER_HAS_NOT_OCCURRED") DAQmxErrorStopTriggerHasNotOccurred;
%rename("ERROR_RECORD_NOT_AVAILABLE") DAQmxErrorRecordNotAvailable;
%rename("ERROR_RECORD_OVERWRITTEN") DAQmxErrorRecordOverwritten;
%rename("ERROR_DATA_NOT_AVAILABLE") DAQmxErrorDataNotAvailable;
%rename("ERROR_DATA_OVERWRITTEN_IN_DEVICE_MEMORY") DAQmxErrorDataOverwrittenInDeviceMemory;
%rename("ERROR_DUPLICATED_CHANNEL") DAQmxErrorDuplicatedChannel;
%rename("WARNING_TIMESTAMP_COUNTER_ROLLED_OVER") DAQmxWarningTimestampCounterRolledOver;
%rename("WARNING_INPUT_TERMINATION_OVERLOADED") DAQmxWarningInputTerminationOverloaded;
%rename("WARNING_ADCOVERLOADED") DAQmxWarningADCOverloaded;
%rename("WARNING_PLLUNLOCKED") DAQmxWarningPLLUnlocked;
%rename("WARNING_COUNTER0DMADURING_AICONFLICT") DAQmxWarningCounter0DMADuringAIConflict;
%rename("WARNING_COUNTER1DMADURING_AOCONFLICT") DAQmxWarningCounter1DMADuringAOConflict;
%rename("WARNING_STOPPED_BEFORE_DONE") DAQmxWarningStoppedBeforeDone;
%rename("WARNING_RATE_VIOLATES_SETTLING_TIME") DAQmxWarningRateViolatesSettlingTime;
%rename("WARNING_RATE_VIOLATES_MAX_ADCRATE") DAQmxWarningRateViolatesMaxADCRate;
%rename("WARNING_USER_DEF_INFO_STRING_TOO_LONG") DAQmxWarningUserDefInfoStringTooLong;
%rename("WARNING_TOO_MANY_INTERRUPTS_PER_SECOND") DAQmxWarningTooManyInterruptsPerSecond;
%rename("WARNING_POTENTIAL_GLITCH_DURING_WRITE") DAQmxWarningPotentialGlitchDuringWrite;
%rename("WARNING_DEV_NOT_SELF_CALIBRATED_WITH_DAQMX") DAQmxWarningDevNotSelfCalibratedWithDAQmx;
%rename("WARNING_AISAMP_RATE_TOO_LOW") DAQmxWarningAISampRateTooLow;
%rename("WARNING_AICONV_RATE_TOO_LOW") DAQmxWarningAIConvRateTooLow;
%rename("WARNING_READ_OFFSET_COERCION") DAQmxWarningReadOffsetCoercion;
%rename("WARNING_PRETRIG_COERCION") DAQmxWarningPretrigCoercion;
%rename("WARNING_SAMP_VAL_COERCED_TO_MAX") DAQmxWarningSampValCoercedToMax;
%rename("WARNING_SAMP_VAL_COERCED_TO_MIN") DAQmxWarningSampValCoercedToMin;
%rename("WARNING_PROPERTY_VERSION_NEW") DAQmxWarningPropertyVersionNew;
%rename("WARNING_USER_DEFINED_INFO_TOO_LONG") DAQmxWarningUserDefinedInfoTooLong;
%rename("WARNING_CAPISTRING_TRUNCATED_TO_FIT_BUFFER") DAQmxWarningCAPIStringTruncatedToFitBuffer;
%rename("WARNING_SAMP_CLK_RATE_TOO_LOW") DAQmxWarningSampClkRateTooLow;
%rename("WARNING_POSSIBLY_INVALID_CTRSAMPS_IN_FINITE_DMAACQ") DAQmxWarningPossiblyInvalidCTRSampsInFiniteDMAAcq;
%rename("WARNING_RISACQ_COMPLETED_SOME_BINS_NOT_FILLED") DAQmxWarningRISAcqCompletedSomeBinsNotFilled;
%rename("WARNING_PXIDEV_TEMP_EXCEEDS_MAX_OP_TEMP") DAQmxWarningPXIDevTempExceedsMaxOpTemp;
%rename("WARNING_OUTPUT_GAIN_TOO_LOW_FOR_RFFREQ") DAQmxWarningOutputGainTooLowForRFFreq;
%rename("WARNING_OUTPUT_GAIN_TOO_HIGH_FOR_RFFREQ") DAQmxWarningOutputGainTooHighForRFFreq;
%rename("WARNING_MULTIPLE_WRITES_BETWEEN_SAMP_CLKS") DAQmxWarningMultipleWritesBetweenSampClks;
%rename("WARNING_DEVICE_MAY_SHUT_DOWN_DUE_TO_HIGH_TEMP") DAQmxWarningDeviceMayShutDownDueToHighTemp;
%rename("WARNING_READ_NOT_COMPLETE_BEFORE_SAMP_CLK") DAQmxWarningReadNotCompleteBeforeSampClk;
%rename("WARNING_WRITE_NOT_COMPLETE_BEFORE_SAMP_CLK") DAQmxWarningWriteNotCompleteBeforeSampClk;
