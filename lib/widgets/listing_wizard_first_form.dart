import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/models/models.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingWizardFirstForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FirstFormBloc, FirstFormState>(
      listener: (context, state) {
        if (state.valid) {
          context.bloc<ListingWizardBloc>().add(FirstFormStateChanged(state));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // _TypeInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _BrandInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _ModelInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _RegistrationInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _PriceInput(),
          ],
        ),
      ),
    );
  }
}

// class _TypeInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FirstFormBloc, FirstFormState>(
//       buildWhen: (previous, current) => previous.type != current.type,
//       builder: (context, state) {
//         return TypePicker(
//             onTypeSelected: (type) =>
//                 context.bloc<FirstFormBloc>().add(ListingTypeChanged(type)));
//       },
//     );
//   }
// }

class _BrandInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstFormBloc, FirstFormState>(
      buildWhen: (previous, current) => previous.brand != current.brand,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.car_repair,
          hint: 'BRAND',
          value: state.brand.value.name,
          picker: Scaffold(
            body: ListingBrandsList(
              onTap: (brand) {
                context.bloc<FirstFormBloc>().add(ListingBrandChanged(brand));
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

class _ModelInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstFormBloc, FirstFormState>(
      buildWhen: (previous, current) => previous.model != current.model,
      builder: (context, state) {
        return PickerInputField(
          icon: Icons.car_rental,
          hint: 'MODEL',
          value: state.model.value.name,
          picker: Scaffold(
            body: ListingModelsList(
              brand: state.brand.value,
              onTap: (model) {
                context.bloc<FirstFormBloc>().add(ListingModelChanged(model));
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

class _RegistrationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstFormBloc, FirstFormState>(
      buildWhen: (previous, current) =>
          previous.registration != current.registration,
      builder: (context, state) {
        return DatePickerInputField(
          icon: Icons.car_rental,
          hint: state.registration.value.day != null
              ? state.registration.value.toString()
              : "REGISTRATION DATE",
          onConfirmed: (selected) {
            Date date = Date(
              day: selected.day,
              month: selected.month,
              year: selected.year,
            );
            context.bloc<FirstFormBloc>().add(ListingRegistrationChanged(date));
          },
        );
      },
    );
  }
}

// class _MileageInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FirstFormBloc, FirstFormState>(
//       buildWhen: (previous, current) => previous.mileage != current.mileage,
//       builder: (context, state) {
//         return TextInputField(
//           icon: Icons.directions_car,
//           hint: "MILEAGE",
//           inputType: TextInputType.number,
//           suffixText: "KM",
//           onTextChanged: (String mileage) => context
//               .bloc<FirstFormBloc>()
//               .add(ListingMileageChanged(int.parse(mileage))), // ?
//         );
//       },
//     );
//   }
// }
// TODO: Replace `TextInputField` with `TextPickerInputField`
class _PriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstFormBloc, FirstFormState>(
      buildWhen: (previous, current) => previous.price != current.price,
      builder: (context, state) {
        return TextInputField(
          icon: Icons.directions_car,
          hint: "PRICE",
          showOverviewHint: state.price.value != 0,
          inputType: TextInputType.number,
          onTextChanged: (String price) => context
              .bloc<FirstFormBloc>()
              .add(ListingPriceChanged(int.parse(price))), // ?
        );
      },
    );
  }
}
