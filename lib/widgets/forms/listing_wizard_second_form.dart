import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/blocs/forms/second_form/second_form_bloc.dart';
import 'package:auto_kobe/utils/palette.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ListingWizardSecondForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SecondFormBloc, SecondFormState>(
      listener: (context, state) {
        if (state.valid) {
          context.bloc<ListingWizardBloc>().add(SecondFormStateChanged(state));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.all(8)),
            _MileageInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _TransmissionInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _OriginCountryInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _DoorTypeInput(),
          ],
        ),
      ),
    );
  }
}

class _OriginCountryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondFormBloc, SecondFormState>(
      buildWhen: (previous, current) => previous.country != current.country,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.access_time,
          hint: 'COUNTRY',
          value: state.country.value.name,
          expand: true,
          picker: CupertinoScaffold(
            transitionBackgroundColor: kWhite,
            body: ListingCountriesList(
              onTap: (country) {
                context
                    .bloc<SecondFormBloc>()
                    .add(ListingCountryChanged(country));
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

class _DoorTypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondFormBloc, SecondFormState>(
      buildWhen: (previous, current) => previous.doors != current.doors,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.add_link,
          hint: 'NUMBER OF DOORS',
          value: state.doors.value.number,
          picker: ListingDoorTypeList(
            onTap: (doors) {
              context.bloc<SecondFormBloc>().add(ListingDoorsChanged(doors));
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

class _MileageInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondFormBloc, SecondFormState>(
      buildWhen: (previous, current) => previous.mileage != current.mileage,
      builder: (context, state) {
        return TextInputField(
          icon: Icons.animation,
          hint: 'MILEAGE',
          showOverviewHint: state.mileage.value != 0,
          inputType: TextInputType.number,
          suffixText: 'KM',
          onTextChanged: (String seats) => context
              .bloc<SecondFormBloc>()
              .add(ListingMileageChanged(int.parse(seats))),
        );
      },
    );
  }
}

class _TransmissionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondFormBloc, SecondFormState>(
      buildWhen: (previous, current) =>
          previous.transmission != current.transmission,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.add_link,
          hint: 'TRANSMISSION',
          value: state.transmission.value.type != null
              ? state.transmission.value.type.toString().split('.').last
              : null,
          picker: ListingTrasmissionsList(
            onTap: (transmission) {
              context
                  .bloc<SecondFormBloc>()
                  .add(ListingTransmissionChanged(transmission));
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
