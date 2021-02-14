import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingWizardBloc, ListingWizardState>(
      buildWhen: (previous, current) => previous.type != current.type,
      builder: (context, state) {
        return TypePicker(
            onTypeSelected: (type) => context
                .watch()<ListingWizardBloc>()
                .add(ListingTypeChanged(type)));
      },
    );
  }
}
