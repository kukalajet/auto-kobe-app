import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/listing_fuel_types_list.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingWizardThirdForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ThirdFormBloc, ThirdFormState>(
      listener: (context, state) {
        if (state.valid) {
          context.bloc<ListingWizardBloc>().add(ThirdFormStateChanged(state));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.all(8)),
            _CubicCapacityInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _FuelInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _MotorPowerInput(),
          ],
        ),
      ),
    );
  }
}

class _CubicCapacityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdFormBloc, ThirdFormState>(
      buildWhen: (previous, current) =>
          previous.cubicCapacity != current.cubicCapacity,
      builder: (context, state) {
        return TextInputField(
          icon: Icons.animation,
          hint: 'CUBIC CAPACITY',
          showOverviewHint: state.cubicCapacity.value != 0,
          inputType: TextInputType.number,
          suffixText: 'CC',
          onTextChanged: (String cubicCapacity) => context
              .bloc<ThirdFormBloc>()
              .add(ListingCubicCapacityChanged(int.parse(cubicCapacity))),
        );
      },
    );
  }
}

class _FuelInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdFormBloc, ThirdFormState>(
      buildWhen: (previous, current) => previous.fuel != current.fuel,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.access_time,
          hint: 'FUEL TYPE',
          value: state.fuel.value.type,
          picker: ListingFuelTypesList(
            onTap: (type) {
              context.bloc<ThirdFormBloc>().add(ListingFuelChanged(type));
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

class _MotorPowerInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdFormBloc, ThirdFormState>(
      buildWhen: (previous, current) =>
          previous.motorPower != current.motorPower,
      builder: (context, state) {
        return TextInputField(
          icon: Icons.animation,
          hint: 'MOTOR POWER',
          showOverviewHint: state.motorPower.value != 0,
          inputType: TextInputType.number,
          suffixText: 'kW',
          onTextChanged: (String motorPower) => context
              .bloc<ThirdFormBloc>()
              .add(ListingMotorPowerChanged(int.parse(motorPower))),
        );
      },
    );
  }
}
